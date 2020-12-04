module day2
    type, public :: password_policy_t
        integer :: min
        integer :: max
        character :: char
        character(len=99) :: password
    end type

contains
    subroutine read_file(password_policies, amount_items)
        implicit none
        type(password_policy_t), allocatable, intent(out) :: password_policies(:)
        integer, intent(out) :: amount_items
        integer :: arr_size, i, ios
        character(len=108) :: line
        integer :: end_point, start_point
        type(password_policy_t), allocatable :: tmp(:)
        type(password_policy_t) :: password_policy
        arr_size = 8
        allocate(password_policies(arr_size))
        open(unit=1, file="input.txt", status="old")
        i = 1
        do
            read(unit=1, fmt="(a)", iostat=ios) line
            if (ios /= 0) exit

            ! FORMAT:
            ! "[min]-[max] [char]: password"
            ! "[min]- "
            end_point = index(line, "-")
            read(line(0:end_point-1), *) password_policy%min
            ! "-[max] "
            start_point = end_point + 1
            end_point = index(line, " ")
            read(line(start_point:end_point-1), *) password_policy%max
            ! " [char]:"
            start_point = end_point + 1
            end_point = index(line, ":")
            read(line(start_point:end_point-1), *) password_policy%char
            ! ": [password]"
            start_point = end_point + 1
            read(line(start_point:), *) password_policy%password

            ! write(*,*) password_policy%min
            ! write(*,*) password_policy%max
            ! write(*,*) password_policy%char
            ! write(*,*) password_policy%password

            ! resize array
            if (i > arr_size) then
                allocate(tmp(2 * arr_size))
                tmp(1:arr_size) = password_policies(:)
                call move_alloc(tmp, password_policies)
                arr_size = arr_size * 2
            end if
            password_policies(i) = password_policy
            i = i + 1
        end do
        close(1)
        amount_items = i - 1
    end subroutine read_file

    logical function check_password_old(password_policy) result(valid)
        implicit none
        type(password_policy_t) :: password_policy
        integer :: nloc, start_point, count
        character(len=99) :: password
        password = password_policy%password
        start_point = 0
        nloc = -1
        count = -1
        do while (nloc .ne. 0 )
            count = count + 1
            nloc = index(password(start_point+1:), password_policy%char)
            start_point = start_point + nloc
        end do
        valid = count >= password_policy%min .and. count <= password_policy%max
    end function check_password_old

    logical function check_password_new(password_policy) result(valid)
        implicit none
        type(password_policy_t) :: password_policy
        character :: char1, char2
        character(len=99) :: password
        logical :: valid1, valid2
        password = password_policy%password
        char1 = password(password_policy%min:password_policy%min+1)
        char2 = password(password_policy%max:password_policy%max+1)
        valid1 = (char1 == password_policy%char) .and. (.not. char2 == password_policy%char)
        valid2 = (.not. char1 == password_policy%char) .and. (char2 == password_policy%char)
        valid = valid1 .or. valid2
    end function check_password_new

    subroutine part1()
        implicit none
        integer :: i, amount_items, count
        type(password_policy_t) :: password_policy
        type(password_policy_t), allocatable :: password_policies(:)
        logical :: valid
        write(*,*) "Part 1"
        call read_file(password_policies, amount_items)
        count = 0
        do i = 1, amount_items
            password_policy = password_policies(i)
            valid = check_password_old(password_policy)
            if (valid) count = count + 1
        end do
        write(*,*) count
    end subroutine part1

    subroutine part2()
        implicit none
        integer :: i, amount_items, count
        type(password_policy_t) :: password_policy
        type(password_policy_t), allocatable :: password_policies(:)
        logical :: valid
        write(*,*) "Part 2"
        call read_file(password_policies, amount_items)
        count = 0
        do i = 1, amount_items
            password_policy = password_policies(i)
            valid = check_password_new(password_policy)
            if (valid) count = count + 1
        end do
        write(*,*) count
    end subroutine part2

end module day2

program main
    use day2
    implicit none
    call part1()
    call part2()
end program main
