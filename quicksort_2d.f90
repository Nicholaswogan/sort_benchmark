module quicksort_2d
  implicit none
  
contains
  
  recursive subroutine quicksort_own_2d_swapped(length, array)

    implicit none
    integer, intent(in) :: length
    double precision, intent(inout) :: array(2,length)
    integer :: partition_index
    integer :: ind_up, &
         ind_down, &
         ind_down_start
    double precision :: buffer(2), compare(2)
    logical :: found

    found = .False.

    partition_index = length
    compare = array(:, partition_index)

    ind_down_start = length-1

    do ind_up = 1, length-1

       if (array(1,ind_up) > compare(1)) then

          found = .True.

          do ind_down = ind_down_start, 1, -1

             if (ind_down == ind_up) then

                array(:,partition_index) = array(:,ind_down)
                array(:,ind_down) = compare

                if ((length-ind_down) > 1) then
                   call quicksort_own_2d_swapped(length-ind_down, array(:,ind_down+1:length))
                end if
                if ((ind_down-1) > 1) then
                   call quicksort_own_2d_swapped(ind_down-1, array(:,1:ind_down-1))
                end if
                return

             else if (array(1,ind_down) < compare(1)) then

                buffer = array(:,ind_up)
                array(:,ind_up) = array(:,ind_down)
                array(:,ind_down) = buffer
                ind_down_start = ind_down
                exit

             end if

          end do

       end if

    end do

    if (found .EQV. .FALSE.) then

       if ((length-1) > 1 ) then
          call quicksort_own_2d_swapped(length-1, array(:,1:length-1))
       end if
    end if

  end subroutine quicksort_own_2d_swapped

  
end module