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
        end type
    end template
end module

program main
    use container_mod, only: container_tmpl
    implicit none

    instantiate container_tmpl(integer, real), only: container_int_real_t
    type(container_int_real_t) :: a

    a = container_int_real_t(1, 2.5)
    write(*,*) 'first = ', a%first, ' second = ', a%second

end program
