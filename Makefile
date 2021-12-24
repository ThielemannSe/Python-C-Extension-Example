# Target
MODULE_NAME	:= example_module
EXT_SUFFIX	:= $(shell python3-config --extension-suffix)
TARGET		+= $(MODULE_NAME)$(EXT_SUFFIX)

# Directories
SRC_DIR 	:= src
BUILD_DIR	:= build

# Files
SRC_FILES 	:= $(wildcard $(SRC_DIR)/*.cpp)
OBJ_FILES 	:= $(patsubst $(SRC_DIR)/%.cpp,$(BUILD_DIR)/%.o,$(SRC_FILES))

# Compilation
CXX			:= g++-11
LDFLAGS 	:= -shared -fPIC -L/usr/local/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/lib/ -undefined dynamic_lookup -lgomp  # -undefined dynamic_lookup is only needed on MacOS
INCLUDES	:= -I/usr/local/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/include/python3.9
CXXFLAGS 	:= -fPIC -O3 -fopenmp


$(TARGET): $(OBJ_FILES)
	$(CXX) $(LDFLAGS) $< -o $@ -L/usr/local/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/lib/ -undefined dynamic_lookup


$(BUILD_DIR)/%.o: $(SRC_FILES) | $(BUILD_DIR)
	$(CXX) -c $(CXXFLAGS) $(INCLUDES) $< -o $@


$(BUILD_DIR):
	mkdir -p $@


clean:
	rm -rf $(BUILD_DIR)
