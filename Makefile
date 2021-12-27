# Python
PY_INCLUDES     := $(shell python3-config --includes)
PY_LDFLAGS      := $(shell python3-config --ldflags)

# Target
MODULE_NAME     := example_module
PyEXT_SUFFIX    := $(shell python3-config --extension-suffix)
TARGET          += $(MODULE_NAME)$(PyEXT_SUFFIX)


# Directories
SRC_DIR         := src
BUILD_DIR       := build

# Files
SRC_FILES       := $(wildcard $(SRC_DIR)/*.cpp)
OBJ_FILES       := $(patsubst $(SRC_DIR)/%.cpp,$(BUILD_DIR)/%.o,$(SRC_FILES))

# Compilation
CXX                     := nvc++
LDFLAGS                 := $(PY_LDFLAGS) -mp -mp=gpu -shared -fPIC # -lgomp # -undefined dynamic_lookup is only needed on MacOS
INCLUDES                := $(PY_INCLUDES)
CXXFLAGS                := -fPIC -O3 -mp -mp=gpu -Minfo=mp



$(TARGET): $(OBJ_FILES)
        $(CXX) $(LDFLAGS) $< -o $@


$(BUILD_DIR)/%.o: $(SRC_FILES) | $(BUILD_DIR)
        $(CXX) -c $(CXXFLAGS) $(INCLUDES) $< -o $@


$(BUILD_DIR):
        mkdir -p $@


clean:
        rm -rf $(BUILD_DIR)