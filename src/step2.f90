module container_mod
    implicit none
    private
    public :: container_tmpl

    requirement R(T, U)
        type :: T; end type
        type :: U; end type
    end requirement

    template container_tmpl(T, U)
        requires R(T, U)
        private
        public :: container_t

        type :: container_t
            type(T) :: first
            type(U) :: second
        contains
            procedure :: swapped
        end type
    contains

        function swapped(this)
            ! QUESTION: Will recursive template instantiation be allowed?
            ! NOTE: This is NOT instantiation! container_u_t_t is still generic.
            instantiate container_tmpl(U, T), only: container_u_t_t
            class(container_t), intent(in) :: this
            type(container_u_t_t) :: swapped

            swapped%first = this%second
            swapped%second = this%first
        end function
    end template
end module

program main
    use container_mod, only: container_tmpl
    implicit none

    instantiate container_tmpl(integer, real), only: container_int_real_t
    instantiate container_tmpl(real, integer), only: container_real_int_t
    type(container_int_real_t) :: a
    type(container_real_int_t) :: b

    a = container_int_real_t(1, 2.5)
    write(*,*) 'first = ', a%first, ' second = ', a%second
    b = a%swapped()
    write(*,*) 'first = ', b%first, ' second = ', b%second

end program
