program sort_benchmark
  
  use iso_fortran_env, only: dp => real64
  use iso_fortran_env, only: output_unit, compiler_version
  use futils, only: argsort
  use stdlib_sorting, only: sort_index
  use sorting_module, only: sort_ascending
  implicit none
  
  real(dp), allocatable :: x_save(:), x1(:), x2(:), x3(:), rwork(:)
  integer(8), allocatable :: inds(:), iwork(:)
    
  integer, parameter :: nt = 200000
  real(dp) :: t(4)
  integer :: i, io
  
  open(unit=1,file='../sort_data.txt',form='formatted',status='old')
  
  io = 0
  i = 0
  do while(io == 0)
    read(1,*, iostat=io)
    if (io == 0) i = i + 1
  enddo
  
  allocate(x1(i), inds(i), x_save(i))
  allocate(rwork(i), iwork(i))
  
  rewind(1)
  do i = 1,size(x1)
    read(1,*) x1(i)
  enddo
  close(1)
  
  x_save = x1
  x2 = x1
  x3 = x1
  
  ! benchmark begins here
  
  call cpu_time(t(1))
  do i = 1,nt
    x1 = x_save
    inds = argsort(x1)
    x1 = x1(inds)
  enddo
  call cpu_time(t(2))
  do i = 1,nt
    x2 = x_save
    call sort_index(x2, inds, work=rwork, iwork=iwork)
  enddo
  call cpu_time(t(3))
  do i = 1,nt
    x3 = x_save
    call sort_ascending(x3)
  enddo
  call cpu_time(t(4))

  write(output_unit,"(a)")          "| algorithm                     | Time for 1 sort (s) |"
  write(output_unit,"(a)")          "| ----------------------------- | ------------------- |"
  write(output_unit,"(a,es19.7,a)") "| futils argsort                | ",(t(2)-t(1))/real(nt),' |'
  write(output_unit,"(a,es19.7,a)") "| stdlib sort_index             | ",(t(3)-t(2))/real(nt),' |'
  write(output_unit,"(a,es19.7,a)") "| sorting_module quicksort      | ",(t(4)-t(3))/real(nt),' |'
  write(output_unit,"(a)") ""
  write(output_unit,"(a,es25.18)") "x1(1) = ",x1(1)
  write(output_unit,"(a,es25.18)") "x2(1) = ",x2(1)
  write(output_unit,"(a,es25.18)") "x3(1) = ",x3(1)
  write(output_unit,"(a)") ""
  
  if (.not. all(x1 == x2)) error stop "sorting failed"
  if (.not. all(x1 == x3)) error stop "sorting failed"
  
end program