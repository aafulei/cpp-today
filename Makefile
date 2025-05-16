# --- Compiler -----------------------------------------------------------------

CXX ?= c++             # c++ usually is clang++ on macOS, g++ on Linux
CXX_STANDARD ?= c++23  # can be overriden, in case only c++20/2b is supported
CXXFLAGS_RELEASE := -std=$(CXX_STANDARD) -pedantic -Wall -Wextra -O2
CXXFLAGS_DEBUG := -std=$(CXX_STANDARD) -pedantic -Wall -Wextra -g -O0

# --- Application --------------------------------------------------------------

PROG := today

# --- Directories --------------------------------------------------------------

SRC_DIR := src
BIN_DIR_RELEASE := bin/release
BIN_DIR_DEBUG := bin/debug
TESTS_DIR := tests
INST_DIR ?= /usr/local/bin
MAN_DIR ?= /usr/local/share/man/man1

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

BIN := $(BIN_DIR)/$(PROG)
SRC := $(wildcard $(SRC_DIR)/*.cpp)
OBJ := $(patsubst $(SRC_DIR)/%.cpp,$(BIN_DIR)/%.o,$(SRC))
DEP := $(OBJ:.o=.d)
BINSTAMP := $(BIN_DIR)/.stamp
TEST := $(TESTS_DIR)/test.sh
VER_FILE := VERSION
MANPAGE_GEN := help2man
MANPAGE_SRC := docs/man/$(PROG).1

# --- Version ------------------------------------------------------------------

DEFAULT_VER := develop
ifneq ("$(wildcard $(VER_FILE))","")
  VER_BASE := $(shell cat $(VER_FILE))
else
  VER_BASE := $(DEFAULT_VER)
endif
ifeq ($(BUILD),debug)
  VER_FULL := $(VER_BASE)-debug
else
  VER_FULL := $(VER_BASE)
endif
CXXFLAGS += -DVERSION=\"$(VER_FULL)\"

# --- Rules --------------------------------------------------------------------

.PHONY: all release debug \
  run run-release run-debug \
  test test-release test-debug \
  man dist install uninstall \
  clean clean-release clean-debug \
  show show-os show-compiler show-version help

all: $(BIN)

# build program
$(BIN): $(OBJ) | $(BINSTAMP)
	@echo
	@echo "% ======="
	@echo "% Linking"
	@echo "% ======="
	@echo
	$(CXX) $(CXXFLAGS) -o $@ $^
	$(MAKE) show

# generate dependency files and object files
# -MMD generates .d dependency files, excluding system headers
# -MP adds phony targets to prevent errors if headers are deleted
$(BIN_DIR)/%.o: $(SRC_DIR)/%.cpp $(VER_FILE) | $(BINSTAMP)
	@echo
	@echo "% ========="
	@echo "% Compiling"
	@echo "% ========="
	@echo
	$(CXX) $(CXXFLAGS) -MMD -MP -c $< -o $@

# create the bin directory
$(BINSTAMP):
	@echo
	@echo "% ============"
	@echo "% Touching Dir"
	@echo "% ============"
	@echo
	mkdir -p $(BIN_DIR)
	touch $(BINSTAMP)

$(MANPAGE_SRC): $(BIN)
	@echo
	@echo "% ==================="
	@echo "% Generating Man Page"
	@echo "% ==================="
	@echo
	@if command -v $(MANPAGE_GEN) >/dev/null 2>&1; then \
	  $(MANPAGE_GEN) \
	  --name="$$(cat ./docs/man/desc.txt)" \
	  --no-info \
	  --output=$(MANPAGE_SRC) \
	  $(BIN); \
	  echo "% $(MANPAGE_SRC) updated."; \
	else \
	  echo "% $(MANPAGE_GEN) not found. Skip. Using pre-built $(MANPAGE_SRC)."; \
	fi

# generate VERSION file if it's missing
$(VER_FILE):
	echo $(DEFAULT_VER) > $(VER_FILE)

# include dependency files (if they exist)
-include $(DEP)

release:
	$(MAKE) BUILD=release all

# debug target to compile with debug flags
debug:
	$(MAKE) BUILD=debug all

run: $(BIN)
	@echo
	@echo "% ======="
	@echo "% Running"
	@echo "% ======="
	@echo
	$(BIN) $(ARGS)

run-release:
	$(MAKE) BUILD=release run

run-debug:
	$(MAKE) BUILD=debug run

test: $(BIN)
	@echo
	@echo "% ======="
	@echo "% Testing"
	@echo "% ======="
	@echo
	$(TEST) $(BIN)

test-release:
	$(MAKE) BUILD=release test

test-debug:
	$(MAKE) BUILD=debug test

dist: all man

man: $(MANPAGE_SRC)

install: $(BIN) $(MANPAGE_SRC)
	@echo
	@echo "% =========="
	@echo "% Installing"
	@echo "% =========="
	@echo
	# install program
	mkdir -pv $(INST_DIR)
	cp -fv $(BIN) $(INST_DIR)/
	# install man page
	mkdir -pv $(MAN_DIR)
	install -m 644 -v $(MANPAGE_SRC) $(MAN_DIR)/

uninstall:
	@echo
	@echo "% ============"
	@echo "% Uninstalling"
	@echo "% ============"
	@echo
	rm -fv $(INST_DIR)/$(PROG)
	rm -fv $(MAN_DIR)/$(notdir $(MANPAGE_SRC))

clean:
	@echo
	@echo "% ========"
	@echo "% Cleaning"
	@echo "% ========"
	@echo
	rm -rfv $(BIN_DIR_RELEASE) $(BIN_DIR_DEBUG)

clean-release:
	rm -rfv $(BIN_DIR_RELEASE)

clean-debug:
	rm -rfv $(BIN_DIR_DEBUG)

show:
	$(MAKE) show-os
	$(MAKE) show-compiler
	$(MAKE) show-version

show-compiler:
	@echo
	@echo "% ===================="
	@echo "% Compiler Information"
	@echo "% ===================="
	@echo
	$(shell which $(CXX)) --version

show-os:
	@echo
	@echo "% ================"
	@echo "% Operating System"
	@echo "% ================"
	@echo
	@if [ -n "$$OS" ] && [ "$$OS" = "Windows_NT" ]; then \
		echo "Operating System: Windows (native CMD/PowerShell)"; \
		echo "Windows Version:"; ver; \
	else \
		unameOut=$$(uname -s); \
		if [ "$$unameOut" = "Darwin" ]; then \
			echo "Operating System: macOS"; \
			echo "Version:"; sw_vers; \
		elif [ "$$unameOut" = "Linux" ]; then \
			echo "Operating System: Linux"; \
			if [ -f /etc/os-release ]; then \
				echo "Version:"; cat /etc/os-release; \
			else \
				uname -a; \
			fi; \
		elif echo "$$unameOut" | grep -qiE 'MINGW|MSYS|CYGWIN'; then \
			echo "Operating System: Windows (Git Bash/MSYS/Cygwin)"; \
			winver=$$(cmd.exe /c ver); \
			echo "Windows Version:"; echo "$$winver"; \
		else \
			echo "Operating System: Unknown"; \
			uname -a; \
		fi \
	fi

show-version:
	@echo
	@echo "% ================"
	@echo "% Software Version"
	@echo "% ================"
	@echo
	@if [ -f $(VER_FILE) ]; then \
		cat $(VER_FILE); \
	else \
		echo "File $(VER_FILE) not found."; \
	fi

help:
	@echo "Usage: make [CXX=c++] [CXX_STANDARD=c++23] [INST_DIR=/usr/local/bin] "
	@echo "            [MAN_DIR=/usr/local/share/man/man1] [ARGS] [target=all]"
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
	@echo "  man            - Build man page"
	@echo "  dist           - Build program and man page"
	@echo "  install        - Install program and man page"
	@echo "  uninstall      - Uninstall program and man page"
	@echo "  clean          - Remove release and debug build files"
	@echo "  clean-release  - Remove release build files"
	@echo "  clean-debug    - Remove debug build files"
	@echo "  show           - Show operating system and compiler info"
	@echo "  show-os        - Show operating system info"
	@echo "  show-compiler  - Show compiler info"
	@echo "  show-version   - Show version number"
	@echo "  help           - Show this help message and exit"
	@echo
	@echo "Variables:"
	@echo "  CXX            - C++ compiler (default: c++)."
	@echo "  CXX_STANDARD   - C++ standard (default: c++23)."
	@echo "  INST_DIR       - Install dir for program (default: /usr/local/bin)"
	@echo "  MAN_DIR        - Install dir for man page (default: /usr/local/share/man/man1)"
	@echo "  ARGS           - Command-line arguments to forward to program"
	@echo
	@echo "Examples:"
	@echo "  make                          # Build release version"
	@echo "  make all                      # Build release version"
	@echo "  make release                  # Build release version"
	@echo "  make debug                    # Build debug version"
	@echo "  make run-debug                # Build and run debug version"
	@echo "  make test-debug               # Build and test debug version"
	@echo "  make dist                     # Build program and man page"
	@echo "  make CXX=g++                  # Build with g++ compiler"
	@echo "  make CXX_STANDARD=c++20       # Build with C++20 standard"
	@echo "  make INST_DIR=/opt install    # Install to /opt"
	@echo "  make INST_DIR=/opt uninstall  # Uninstall from /opt"
	@echo "  make MAN_DIR=/opt install     # Install, saving man page to /opt"
	@echo "  make MAN_DIR=/opt uninstall   # Uninstall, removing man page from /opt"
	@echo "  make ARGS=--help run-debug    # Run debug-version program with --help"
