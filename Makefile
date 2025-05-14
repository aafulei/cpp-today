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

all: $(TARGET)

# build program
$(TARGET): $(OBJ) | $(BINSTAMP)
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

clean:
	rm -rfv $(BIN_DIR_RELEASE) $(BIN_DIR_DEBUG)

clean-debug:
	rm -rfv $(BIN_DIR_DEBUG)

clean-release:
	rm -rfv $(BIN_DIR_RELEASE)

# debug target to compile with debug flags
debug:
	$(MAKE) BUILD=debug all

release:
	$(MAKE) BUILD=release all

run: $(TARGET)
	$(TARGET)

run-debug:
	$(MAKE) BUILD=debug run

run-release:
	$(MAKE) BUILD=release run

test: $(TARGET)
	$(TEST) $(TARGET)

test-debug:
	$(MAKE) BUILD=debug test

test-release:
	$(MAKE) BUILD=release test

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
	@echo "  clean          - Remove release and debug build files"
	@echo "  clean-release  - Remove release build files"
	@echo "  clean-debug    - Remove debug build files"
	@echo "  help           - Show this help message and exit"
	@echo
	@echo "Variables:"
	@echo "  CXX            - C++ compiler (default: c++)."
	@echo "  CXX_STANDARD   - C++ standard (default: c++23)."
	@echo
	@echo "Examples:"
	@echo "  make                       # Build release version"
	@echo "  make all                   # Build release version"
	@echo "  make release               # Build release version"
	@echo "  make debug                 # Build debug version"
	@echo "  make run-debug             # Build and run debug version"
	@echo "  make test-debug            # Build and test debug version"
	@echo "  make CXX=g++               # Build with g++ compiler"
	@echo "  make CXX_STANDARD=c++20    # Build with C++20 standard"

.PHONY: all release debug run run-release run-debug test test-release \
        test-debug clean clean-release clean-debug help
