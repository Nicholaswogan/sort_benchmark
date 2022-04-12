program sort_benchmark
  
  use iso_fortran_env, only: dp => real64
  use iso_fortran_env, only: output_unit, compiler_version
  use futils, only: argsort
  use stdlib_sorting, only: sort_index
  implicit none
  
  real(dp), allocatable :: x_save(:), x(:), xx(:), rwork(:)
  integer(8), allocatable :: inds(:), iwork(:)
    
  integer, parameter :: nt = 200000
  real(dp) :: t(3)
  integer :: i, io
  
  open(unit=1,file='../sort_data.txt',form='formatted',status='old')
  
  io = 0
  i = 0
  do while(io == 0)
    read(1,*, iostat=io)
    if (io == 0) i = i + 1
  enddo
  
  allocate(x(i), inds(i), x_save(i))
  allocate(rwork(i), iwork(i))
  
  rewind(1)
  do i = 1,size(x)
    read(1,*) x(i)
  enddo
  x_save = x
  xx = x
  
  ! benchmark begins here
  
  call cpu_time(t(1))
  do i = 1,nt
    x = x_save
    inds = argsort(x)
    x = x(inds)
  enddo
  call cpu_time(t(2))
  do i = 1,nt
    xx = x_save
    call sort_index(xx, inds, work=rwork, iwork=iwork)
  enddo
  call cpu_time(t(3))

  write(output_unit,"(a)")          "| algorithm         | Time for 1 sort (s) |"
  write(output_unit,"(a)")          "| ----------------- | ------------------- |"
  write(output_unit,"(a,es19.7,a)") "| futils argsort    | ",(t(2)-t(1))/real(nt),' |'
  write(output_unit,"(a,es19.7,a)") "| stdlib sort_index | ",(t(3)-t(2))/real(nt),' |'
  write(output_unit,"(a)") ""
  write(output_unit,"(a,es25.18)") "x(1) = ",x(1)
  write(output_unit,"(a,es25.18)") "xx(1) = ",xx(1)
  write(output_unit,"(a)") ""
  
  if (.not. all(x == xx)) error stop "sorting failed"
  
end program