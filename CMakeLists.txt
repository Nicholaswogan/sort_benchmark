cmake_minimum_required(VERSION "3.14")

project(SORTBENCH LANGUAGES Fortran CXX)

set(CMAKE_Fortran_MODULE_DIRECTORY "${CMAKE_BINARY_DIR}/modules")

set(CMAKE_CXX_STANDARD 20)

if (NOT CMAKE_BUILD_TYPE OR CMAKE_BUILD_TYPE STREQUAL "")
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING "" FORCE)
endif()

if ("${CMAKE_Fortran_COMPILER_ID}" MATCHES "GNU")
  set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -Wunused")
  if (CMAKE_BUILD_TYPE STREQUAL "Release")
    set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -finline-functions -ftree-vectorize -funroll-loops -march=native")
  endif()
endif()

# dependencies
include(cmake/CPM.cmake)

CPMAddPackage(
  NAME futils
  VERSION 0.1.0
  URL "https://github.com/Nicholaswogan/futils/archive/7fc7a57eaee65ad6a825e7fed584eb8a0269d020.zip"
  EXCLUDE_FROM_ALL ON
)

CPMAddPackage(
  NAME fortran_stdlib
  VERSION 0.2.0
  GITHUB_REPOSITORY "fortran-lang/stdlib"
  GIT_TAG "v0.2.0"
  EXCLUDE_FROM_ALL ON
)

CPMAddPackage(
  NAME fortran-search-and-sort
  VERSION 1.0.1
  GITHUB_REPOSITORY "jacobwilliams/fortran-search-and-sort"
  GIT_TAG "1.0.1"
  DOWNLOAD_ONLY ON
)

add_library(fortran-search-and-sort ${fortran-search-and-sort_SOURCE_DIR}/src/sorting_module.f90)

add_library(sorter sorter.f90)

add_library(std_argsort std_argsort.cpp std_argsort.f90)

add_library(quicksort_2d quicksort_2d.f90)

add_library(hsort_mod hsort.f hsort_mod.f90)

add_library(mrgrnk mrgrnk_mod.f90)

# benchmark
add_executable(sort_benchmark sort_benchmark.f90)
target_link_libraries(sort_benchmark 
  futils fortran_stdlib fortran-search-and-sort 
  sorter std_argsort quicksort_2d hsort_mod mrgrnk
)
target_include_directories(sort_benchmark PUBLIC ${CMAKE_Fortran_MODULE_DIRECTORY})

