#include <algorithm>
#include <numeric>
#include <span>

extern "C" {

// Finds the indices that would sort an array
//
// Performs an indirect sort of the rank-1 array `a` of size `n`. 
// Indices are returned in the array `index`.
// Fortran or 1-based numbering is assumed for the `index` array.
//
void cpp_argsort(int n, const double *a, int *index) {

  std::span inds(index, static_cast<size_t>(n));
  std::iota(inds.begin(),inds.end(),1);

  auto compare = [&a](const int& il, const int& ir) {
    return a[il-1] < a[ir-1];
  };

  std::sort(inds.begin(),inds.end(),compare);

}

// Finds the indices that would sort an array while preserving order
// between equal elements.
//
// Performs an indirect sort of the rank-1 array `a` of size `n`. 
// Indices are returned in the array `index`.
// Fortran or 1-based numbering is assumed for the `index` array.
//
void cpp_stable_argsort(int n, const double *a, int *index) {

  std::span inds(index, static_cast<size_t>(n));
  std::iota(inds.begin(),inds.end(),1);

  auto compare = [&a](const int& il, const int& ir) {
    return a[il-1] < a[ir-1];
  };

  std::stable_sort(inds.begin(),inds.end(),compare);
}


} // extern "C"