#!/bin/bash

module purge

module load modenv/hiera
module load GCC/10.2.0
module load Python
module load NVHPC

make -B

python3 test.py