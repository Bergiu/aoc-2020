module day1
contains
    subroutine read_file(input_numbers, amount_items)
        implicit none
        integer, allocatable, intent(out) :: input_numbers(:)
        integer, intent(out) :: amount_items
        integer :: arr_size, i, ios, inp
        integer, allocatable :: tmp(:)
        arr_size = 8
        allocate(input_numbers(arr_size))
        open(unit=1, file="input.txt", status="old")
        i = 1
        do
            read(unit=1, fmt=*, iostat=ios) inp
            if (ios /= 0) exit
            if (i > arr_size) then
                allocate(tmp(2 * arr_size))
                tmp(1:arr_size) = input_numbers(:)
                call move_alloc(tmp, input_numbers)
                arr_size = arr_size * 2
            end if
            input_numbers(i) = inp
            i = i + 1
        end do
        close(1)
        amount_items = i - 1
    end subroutine read_file

    subroutine part1()
        implicit none
        integer :: i, j, x, y, amount_items
        integer, allocatable :: input_numbers(:)
        logical :: found
        write(*,*) "Part 1"
        call read_file(input_numbers, amount_items)
        found = .false.
        do i = 1, amount_items / 2
            x = input_numbers(i)
            do j = i + 1, amount_items
                y = input_numbers(j)
                if (x + y == 2020) then
                    write(*,fmt="(i0'*'i0'='i0)") x, y, x*y
                    found = .true.
                end if
            end do
        end do
        if (.NOT. found) then
            write(*,*) "Nothing found"
        end if
    end subroutine part1

    subroutine part2()
        implicit none
        integer :: i, j, k, x, y, z, amount_items
        integer, allocatable :: input_numbers(:)
        logical :: found
        write(*,*) "Part 2"
        call read_file(input_numbers, amount_items)
        found = .false.
        do i = 1, amount_items / 2
            x = input_numbers(i)
            do j = i + 1, amount_items
                y = input_numbers(j)
                do k = j + 1, amount_items
                    z = input_numbers(k)
                    if (x + y +z == 2020) then
                        write(*,fmt="(i0'*'i0'*'i0'='i0)") x, y, z, x*y*z
                        found = .true.
                    end if
                end do
            end do
        end do
        if (.NOT. found) then
            write(*,*) "Nothing found"
        end if
    end subroutine part2
end module day1

program main
    use day1
    implicit none
    call part1()
    call part2()
end program main
