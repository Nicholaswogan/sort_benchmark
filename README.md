# sort_benchmark

I'm trying to find the fastest algorithm for sorting many sets of arrays in `sort_data.dat`. `sort_benchmark.f90` loads the data into a large 2-D array, and tests different sorting algorithms against all the data. The algorithm must return the indexes for how to sort of the data, and sorting must be done in double precision. Current results:

| algorithm                     | Time for 1 sort (s) |
| ----------------------------- | ------------------- |
| futils argsort                |       1.4215727E-05 |
| stdlib sort_index             |       1.7480909E-06 |
| sorting_module quicksort      |       3.1813727E-05 |
| sorter sortedIndex            |       3.1142727E-06 |


**I would really appreciate any suggested sorting routines that are faster! Suggest by raising an issue or making a pull request. Thanks.**

## building and running

```sh
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build . -j4
./sort_benchmark
```