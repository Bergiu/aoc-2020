program day1
    implicit none

    integer :: inp, i, j, x, y, arr_size, ios, amount_items
    integer, allocatable :: input_numbers(:), tmp(:)
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
    do i = 1, amount_items / 2
        x = input_numbers(i)
        do j = i + 1, amount_items
            y = input_numbers(j)
            if (x + y == 2020) then
                write(*,fmt="(i0'*'i0'='i0)") x, y, x*y
            end if
        end do
    end do
end program day1
