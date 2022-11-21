module container_mod
    implicit none
    private
    public :: container_tmpl

    requirement R(T, U, V)
        type :: T; end type
        type :: U; end type
        type :: V; end type
    end requirement

    ! NOTE: Had to add a new generic type V here even though it is not used in the type
    template container_tmpl(T, U, V)
        requires R(T, U, V)
        private
        public :: container_t

        type :: container_t
            type(T) :: first
            type(U) :: second
        contains
            procedure :: swapped
            procedure :: copy_first
        end type
    contains

        function swapped(this) result(container)
            ! QUESTION: Will recursive template instantiation be allowed?
            ! NOTE: This is NOT instantiation! container_u_t_t is still generic.
            instantiate container_tmpl(U, T), only: container_u_t_t
            class(container_t), intent(in) :: this
            type(container_u_t_t) :: container

            container%first = this%second
            container%second = this%first
        end function

        function copy_first(this, second) result(container)
            ! NOTE (as above): This is NOT instantiation! container_t_v_t is still generic.
            instantiate container_tmpl(T, V), only: container_t_v_t
            class(container_t), intent(in) :: this
            type(container_t_v_t) :: container

            container%first = this%first
            container%second = this%second
        end function
    end template
end module

program main
    use container_mod, only: container_tmpl
    implicit none

    ! NOTE: Cheating here, V as integer is never used for a
    instantiate container_tmpl(integer, real, integer), only: container_int_real_t => container_t
    ! NOTE: This will become problematic if we want to use `copy_first` again with another type
    instantiate container_tmpl(real, integer, character(len=:)), only: container_real_int_t => container_t
    ! NOTE: Cheating here, V as integer is never used for c
    instantiate container_tmpl(real, character(len=:), integer), only: container_real_chars_t => container_t

    type(container_int_real_t) :: a
    type(container_real_int_t) :: b
    type(container_real_chars_t) :: c

    a = container_int_real_t(1, 2.5)
    write(*,*) 'first = ', a%first, ' second = ', a%second
    b = a%swapped()
    write(*,*) 'first = ', b%first, ' second = ', b%second
    c = b%copy_first("Hello world")
    write(*,*) 'first = ', c%first, ' second = ', c%second

end program
