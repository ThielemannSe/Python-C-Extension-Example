#define PY_SSIZE_CLEAN
#include <Python.h>

#include <iostream>
#include <omp.h>
#include <vector>


// Method to be wrapped
static PyObject * example_method( PyObject *self, PyObject *args )
{
    std::cout << omp_get_num_procs() << std::endl;

        Py_BEGIN_ALLOW_THREADS

        const int N = 8;
        int A[N], B[N], C[N];
        int k = 4;
        int nteams = 16;
        int block_threads = N/nteams;
        for(int i=0; i<N; ++i)
        {
                A[i] = 0;
                B[i] = i;
                C[i] = 3*i;
        }

        #pragma omp target map(tofrom: A) map(to: B, C)
        #pragma omp teams num_teams(nteams)
        #pragma omp distribute parallel for dist_schedule(static, block_threads)
        for( int i=0; i < N; ++i )
        {
                A[i] = B[i] + k*C[i];
        }

        Py_END_ALLOW_THREADS
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