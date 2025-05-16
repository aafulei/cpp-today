# --- Compiler -----------------------------------------------------------------

CXX ?= c++             # c++ usually is clang++ on macOS, g++ on Linux
CXX_STANDARD ?= c++23  # can be overriden, in case only c++20/2b is supported
CXXFLAGS_RELEASE := -std=$(CXX_STANDARD) -pedantic -Wall -Wextra -O2
CXXFLAGS_DEBUG := -std=$(CXX_STANDARD) -pedantic -Wall -Wextra -g -O0

# --- Application --------------------------------------------------------------

APP := today

# --- Directories --------------------------------------------------------------

SRC_DIR := src
BIN_DIR_RELEASE := bin/release
BIN_DIR_DEBUG := bin/debug
TESTS_DIR := tests
PREFIX ?= /usr/local
INSTALL_DIR ?= $(PREFIX)/bin

# --- Builds -------------------------------------------------------------------

BUILD ?= release
ifeq ($(BUILD),debug)
  BIN_DIR := $(BIN_DIR_DEBUG)
  CXXFLAGS := $(CXXFLAGS_DEBUG)
else
  BIN_DIR := $(BIN_DIR_RELEASE)
  CXXFLAGS := $(CXXFLAGS_RELEASE)
endif

# --- Files --------------------------------------------------------------------

TARGET := $(BIN_DIR)/$(APP)
SRC := $(wildcard $(SRC_DIR)/*.cpp)
OBJ := $(patsubst $(SRC_DIR)/%.cpp,$(BIN_DIR)/%.o,$(SRC))
DEP := $(OBJ:.o=.d)
BINSTAMP := $(BIN_DIR)/.stamp
TEST := $(TESTS_DIR)/test.sh

# --- Rules --------------------------------------------------------------------

.PHONY: all release debug run run-release run-debug test-release test-debug \
	clean clean-release clean-debug install uninstall show show-os show-compiler \
	help

all: $(TARGET)

# build program
$(TARGET): $(OBJ) | $(BINSTAMP)
	$(MAKE) show
	$(CXX) $(CXXFLAGS) -o $@ $^

# generate object files and dependency files
# -MMD generates .d dependency files, excluding system headers
# -MP adds phony targets to prevent errors if headers are deleted
$(BIN_DIR)/%.o: $(SRC_DIR)/%.cpp | $(BINSTAMP)
	$(CXX) $(CXXFLAGS) -MMD -MP -c $< -o $@

# create the bin directory
$(BINSTAMP):
	mkdir -p $(BIN_DIR)
	touch $(BINSTAMP)

# include dependency files (if they exist)
-include $(DEP)

release:
	$(MAKE) BUILD=release all

# debug target to compile with debug flags
debug:
	$(MAKE) BUILD=debug all

run: $(TARGET)
	$(TARGET)

run-release:
	$(MAKE) BUILD=release run

run-debug:
	$(MAKE) BUILD=debug run

test: $(TARGET)
	$(TEST) $(TARGET)

test-release:
	$(MAKE) BUILD=release test

test-debug:
	$(MAKE) BUILD=debug test

install: $(TARGET)
	mkdir -pv $(INSTALL_DIR)
	cp -fv $(TARGET) $(INSTALL_DIR)/

uninstall:
	rm -fv $(INSTALL_DIR)/$(APP)

clean:
	rm -rfv $(BIN_DIR_RELEASE) $(BIN_DIR_DEBUG)

clean-release:
	rm -rfv $(BIN_DIR_RELEASE)

clean-debug:
	rm -rfv $(BIN_DIR_DEBUG)

show:
	$(MAKE) show-os
	$(MAKE) show-compiler

show-compiler:
	$(shell which $(CXX)) --version

show-os:
	@if [ -n "$$OS" ] && [ "$$OS" = "Windows_NT" ]; then  \
		echo "Operating System: Windows (native CMD/PowerShell)";  \
		echo "Windows Version:"; ver;  \
	else  \
		unameOut=$$(uname -s);  \
		if [ "$$unameOut" = "Darwin" ]; then  \
			echo "Operating System: macOS";  \
			echo "Version:"; sw_vers;  \
		elif [ "$$unameOut" = "Linux" ]; then  \
			echo "Operating System: Linux";  \
			if [ -f /etc/os-release ]; then  \
				echo "Version:"; cat /etc/os-release;  \
			else  \
				uname -a;  \
			fi;  \
		elif echo "$$unameOut" | grep -qiE 'MINGW|MSYS|CYGWIN'; then  \
			echo "Operating System: Windows (Git Bash/MSYS/Cygwin)";  \
			winver=$$(cmd.exe /c ver);  \
			echo "Windows Version:"; echo "$$winver";  \
		else  \
			echo "Operating System: Unknown";  \
			uname -a;  \
		fi  \
	fi

help:
	@echo "Usage: make [CXX=c++] [CXX_STANDARD=c++23] [target]"
	@echo
	@echo "Targets:"
	@echo "  all            - Build release version (default)"
	@echo "  release        - Build release version"
	@echo "  debug          - Build debug version"
	@echo "  run            - Build and run release version"
	@echo "  run-release    - Build and run release version"
	@echo "  run-debug      - Build and run debug version"
	@echo "  test           - Build and test release version"
	@echo "  test-release   - Build and test release version"
	@echo "  test-debug     - Build and test debug version"
	@echo "  install        - Build and install release version"
	@echo "  uninstall      - Remove installed program"
	@echo "  clean          - Remove release and debug build files"
	@echo "  clean-release  - Remove release build files"
	@echo "  clean-debug    - Remove debug build files"
	@echo "  show           - Show operating system and compiler info"
	@echo "  show-os        - Show operating system info"
	@echo "  show-compiler  - Show compiler info"
	@echo "  help           - Show this help message and exit"
	@echo
	@echo "Variables:"
	@echo "  CXX            - C++ compiler (default: c++)."
	@echo "  CXX_STANDARD   - C++ standard (default: c++23)."
	@echo "  PREFIX         - Installation prefix (default: /usr/local)"
	@echo "  INSTALL_DIR    - Installation directory (default: \$$PREFIX/bin)"
	@echo
	@echo "Examples:"
	@echo "  make                              # Build release version"
	@echo "  make all                          # Build release version"
	@echo "  make release                      # Build release version"
	@echo "  make debug                        # Build debug version"
	@echo "  make run-debug                    # Build and run debug version"
	@echo "  make test-debug                   # Build and test debug version"
	@echo "  make CXX=g++                      # Build with g++ compiler"
	@echo "  make CXX_STANDARD=c++20           # Build with C++20 standard"
	@echo "  make PREFIX=/opt/local install    # Install to /opt/local/bin"
	@echo "  make PREFIX=/opt/local uninstall  # Remove program from /opt/local/bin"
