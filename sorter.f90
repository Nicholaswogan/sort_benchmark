module sorter
  implicit none
  integer, parameter :: rk = kind(0.d0)
  integer, parameter :: ixk = 8
 contains
  subroutine sortedIndex(n,a,ix)
    integer, intent(in) :: n
    real(rk), intent(in) :: a(n)
    integer(ixk), intent(out) :: ix(n)
    integer, parameter :: itk = 8
    integer(itk) :: buff(n,2)
    integer(itk) :: j, from, to, step
    integer(itk) :: from1, from2, limit1, limit2
    from = 1
    to = 2
    do j=1,n
      buff(j, from) = j
    end do
    ! Repeatedly merge-sort power-of-two sections of buff(:, from)
    ! into buff(:, to), swap to/from, and increase the section size
    ! until fully sorted.
    step = 1
    do while (step < n)
      j = 1
      do while (j <= n)
        from1 = j
        limit1 = min(j + step, n + 1)
        from2 = limit1
        limit2 = min(limit1 + step, n + 1)
        do
          if (from1 == limit1) then
            if (from2 == limit2) exit
            buff(j, to) = buff(from2, from)
            from2 = from2 + 1
          else if (from2 == limit2) then
            buff(j, to) = buff(from1, from)
            from1 = from1 + 1
          else if (a(buff(from1, from)) <= a(buff(from2, from))) then
            buff(j, to) = buff(from1, from)
            from1 = from1 + 1
          else
            buff(j, to) = buff(from2, from)
            from2 = from2 + 1
          end if
          j = j + 1
        end do
      end do
      from = to
      to = 3 - from
      step = 2 * step
    end do
    do j = 1,n
      ix(j) = buff(j, from)
    end do
  end subroutine
end module