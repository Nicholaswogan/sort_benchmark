# sort_benchmark

I'm trying to find the fastest algorithm for sorting many sets of arrays in `sort_data.dat`. `sort_benchmark.f90` loads the data into a large 2-D array, and tests different sorting algorithms against all the data. The algorithm must return the indexes for how to sort of the data, and sorting must be done in double precision. Current results:

| algorithm                     | Time for 1 sort (s) |
| ----------------------------- | ------------------- |
| futils argsort                |       1.4152364E-05 |
| stdlib sort_index             |       1.7375455E-06 |
| sorting_module quicksort      |       3.1808000E-05 |
| sorter sortedIndex            |       2.6176364E-06 |
| C++ std::sort                 |       1.7956364E-06 |
| C++ std::stable_sort          |       1.8575455E-06 |
| quicksort_own_2d_swapped      |       4.0766364E-06 |

**I would really appreciate any suggested sorting routines that are faster! Suggest by raising an issue or making a pull request. Thanks.**

## building and running

```sh
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build . -j4
./sort_benchmark
```