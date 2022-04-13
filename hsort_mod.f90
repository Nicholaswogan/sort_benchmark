module hsort_mod
  implicit none
  interface
    subroutine hsort(n, list, key)
      integer, intent(in) :: n
      integer, intent(out) :: list(n)
      real(8), intent(in) :: key(n) 
    end subroutine
  end interface
end module