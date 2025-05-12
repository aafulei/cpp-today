# --- Compiler -----------------------------------------------------------------

# Default compiler is c++, which usually is clang++ on macOS, or g++ on Linux.
# This can be overridden by setting CXX, e.g. make CXX=clang++.
CXX ?= c++
CXXFLAGS := -std=c++23 -pedantic -Wall -Wextra -O2
DEBUGFLAGS := -std=c++23 -pedantic -Wall -Wextra -g -O0

# --- Application --------------------------------------------------------------

APP := today

# --- Directories --------------------------------------------------------------

SRC_DIR := src
BIN_DIR := bin

# --- Files --------------------------------------------------------------------

TARGET := $(BIN_DIR)/$(APP)
SRC := $(wildcard $(SRC_DIR)/*.cpp)
OBJ := $(patsubst $(SRC_DIR)/%.cpp,$(BIN_DIR)/%.o,$(SRC))
DEP := $(OBJ:.o=.d)
BINSTAMP := $(BIN_DIR)/.stamp

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
	rm -rfv $(BIN_DIR)

# debug target to compile with debug flags
debug: CXXFLAGS := $(DEBUGFLAGS)
debug: clean all

run: $(TARGET)
	@$(TARGET)

help:
	@echo "Usage: make [target] [CXX=compiler]"
	@echo ""
	@echo "Targets:"
	@echo "  all      - Build the release version of the program (default)"
	@echo "  clean    - Remove all build files and binaries"
	@echo "  debug    - Clean and build the program with debug flags"
	@echo "  run      - Run the compiled program"
	@echo "  help     - Show this help message and exit"
	@echo ""
	@echo "Variables:"
	@echo "  CXX      - C++ compiler (default: c++). You can override it by "
	@echo "             running, e.g. \"make CXX=clang++\", or setting the CXX"
	@echo "             environment variable."

.PHONY: all clean debug run help
