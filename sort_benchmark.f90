program sort_benchmark
  
  use iso_fortran_env, only: dp => real64
  use iso_fortran_env, only: output_unit, compiler_version
  use futils, only: argsort
  use stdlib_sorting, only: sort_index
  use sorting_module, only: sort_ascending
  use sorter, only: sortedIndex
  implicit none
  
  real(dp), allocatable :: x1(:), x2(:), x3(:), x4(:)
  real(dp), allocatable :: all_data(:,:)
  integer(8), allocatable :: inds(:)
  
  real(dp), allocatable ::  work(:)
  integer(8), allocatable :: iwork(:)
  
  integer, parameter :: n_dat = 200*55
  integer, parameter :: n = 256
  real(dp) :: t(5)
  integer :: i
  
  open(unit=1,file='../sort_data.dat',form='unformatted',status='old')

  allocate(all_data(n,n_dat))
  allocate(x1(n), x2(n), x3(n), x4(n))
  allocate(inds(n))
  allocate(work(n), iwork(n))
  
  do i = 1,n_dat
    read(1) all_data(:,i)
  enddo
  
  close(1)
  
  ! benchmark begins here
  
  call cpu_time(t(1))
  do i = 1,n_dat
    x1 = all_data(:,i)
    inds = argsort(x1)
    x1 = x1(inds)
  enddo
  call cpu_time(t(2))
  do i = 1,n_dat
    x2 = all_data(:,i)
    call sort_index(x2, inds, work=work, iwork=iwork)
  enddo
  call cpu_time(t(3))
  do i = 1,n_dat
    x3 = all_data(:,i)
    call sort_ascending(x3)
  enddo
  call cpu_time(t(4))
  do i = 1,n_dat
    x4 = all_data(:,i)
    call sortedIndex(n, x4, inds)
    x4 = x4(inds)
  enddo
  call cpu_time(t(5))

  write(output_unit,"(a)")          "| algorithm                     | Time for 1 sort (s) |"
  write(output_unit,"(a)")          "| ----------------------------- | ------------------- |"
  write(output_unit,"(a,es19.7,a)") "| futils argsort                | ",(t(2)-t(1))/real(n_dat),' |'
  write(output_unit,"(a,es19.7,a)") "| stdlib sort_index             | ",(t(3)-t(2))/real(n_dat),' |'
  write(output_unit,"(a,es19.7,a)") "| sorting_module quicksort      | ",(t(4)-t(3))/real(n_dat),' |'
  write(output_unit,"(a,es19.7,a)") "| sorter sortedIndex            | ",(t(5)-t(4))/real(n_dat),' |'
  write(output_unit,"(a)") ""
  write(output_unit,"(a,es25.18)") "x1(1) = ",x1(1)
  write(output_unit,"(a,es25.18)") "x2(1) = ",x2(1)
  write(output_unit,"(a,es25.18)") "x3(1) = ",x3(1)
  write(output_unit,"(a,es25.18)") "x4(1) = ",x4(1)
  write(output_unit,"(a)") ""
  
  if (.not. all(x1 == x2)) error stop "sorting failed 2"
  if (.not. all(x1 == x3)) error stop "sorting failed 3"
  if (.not. all(x1 == x4)) error stop "sorting failed 4"
  
end program