# sort_benchmark

I'm trying to find the fastest algorithm for sorting `sort_data.txt`. The algorithm must return the indexes for how to sort of the data, and must be done in double precision. Current results:

| algorithm                     | Time for 1 sort (s) |
| ----------------------------- | ------------------- |
| futils argsort                |       1.0784625E-05 |
| stdlib sort_index             |       1.3765850E-06 |
| sorting_module quicksort      |       2.5269760E-05 |


**I would really appreciate any suggested sorting routines that are faster! Suggest by raising an issue or making a pull request. Thanks.**

## building and running

```sh
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build . -j4
./sort_benchmark
```