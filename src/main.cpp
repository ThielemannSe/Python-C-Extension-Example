#define PY_SSIZE_CLEAN
#include <Python.h>
#include <iostream>
#include <omp.h>

// Method to be wrapped
static PyObject * example_method( PyObject *self, PyObject *args )
{
    std::cout << omp_get_num_procs() << std::endl;

    return PyLong_FromLong( 2);
}


static PyMethodDef ExampleMethods[] = {
    { "example_method", example_method, METH_VARARGS, "Example C++ method wrapped for Python."},
    { NULL, NULL, 0, NULL }
};


static struct PyModuleDef example_module = {
    PyModuleDef_HEAD_INIT,
    "ExampleModule",
    "Example C++ Module for Python",
    -1,
    ExampleMethods
};


PyMODINIT_FUNC PyInit_example_module() {
    return PyModule_Create(&example_module);
}


// /usr/local/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/include/python3.9