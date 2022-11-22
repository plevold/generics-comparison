#include <iostream>
#include <string>

class Base {
    protected:
        virtual void log(std::string operation) = 0;
};

template<typename T, typename U>
class Container : public Base {
    public:
        T first;
        U second;

        Container(T first, U second) : Base(), first(first), second(second) {};

        auto swapped() -> Container<U, T> {
            log("swapped");
            return Container<U, T>(second, first);
        }

        template<typename V>
        auto copy_first(V second) -> Container<T, V> {
            log("copy_first");
            return Container<T, V>(this->first, second);
        }

    protected:
        void log(std::string operation) override {
            std::cout << "-- Container: " << operation << " called on object with "
                << first << " " << second << std::endl;
        }
};

template<typename T, typename U, typename V>
class LargeContainer : public Container<T, U> {
    public:
        V third;

        LargeContainer(T first, U second, V third) : Container<T, U>(first, second), third(third) {};

    protected:
        void log(std::string operation) override {
            std::cout << "-- LargeContainer: " << operation << " called on object with "
            << Container<T, U>::first << " " << Container<T, U>::second << " " << third << std::endl;
        }
};

/*
When run, this outputs:

first = 1 second = 2.5
-- Container: swapped called on object with 1 2.5
first = 2.5 second = 1
-- Container: copy_first called on object with 2.5 1
first = 2.5 second = Hello world
-- LargeContainer: copy_first called on object with 1 42 3.14
first = 1 second = 2
-- LargeContainer: copy_first called on object with 1 42 3.14
first = 1 second = foo
*/
int main() {
    auto a = Container<int, double>(1, 2.5);
    std::cout << "first = " << a.first << " second = " << a.second << std::endl;
    auto b = a.swapped();
    std::cout << "first = " << b.first << " second = " << b.second << std::endl;
    auto c = b.copy_first<std::string>("Hello world");
    std::cout << "first = " << c.first << " second = " << c.second << std::endl;
    auto d = LargeContainer<int, int, double>(1, 42, 3.14);
    auto e = d.copy_first<int>(2);
    std::cout << "first = " << e.first << " second = " << e.second << std::endl;
    auto f = d.copy_first<std::string>("foo");
    std::cout << "first = " << f.first << " second = " << f.second << std::endl;

    return 0;
}
