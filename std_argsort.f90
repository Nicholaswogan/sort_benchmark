module std_argsort
  use iso_c_binding, only: c_double, c_int
  implicit none
  private
  public :: cpp_argsort, cpp_stable_argsort
  
  interface
    subroutine cpp_argsort(n,array,ind) bind(C,name="cpp_argsort")
      import c_double, c_int
      integer(c_int), intent(in), value :: n
      real(c_double), intent(in) :: array(*)
      integer(c_int), intent(inout) :: ind(*)
    end subroutine
    subroutine cpp_stable_argsort(n,array,ind) bind(C, &
         name="cpp_stable_argsort")
      import c_double, c_int
      integer(c_int), intent(in), value :: n
      real(c_double), intent(in) :: array(*)
      integer(c_int), intent(inout) :: ind(*)
    end subroutine
   end interface
end module