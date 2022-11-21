struct Container<T, U>
where
    T: Copy,
    U: Copy,
{
    first: T,
    second: U,
}

type UniformContainer<T> = Container<T, T>;

impl<T, U> Container<T, U>
where
    T: Copy,
    U: Copy,
{
    fn swapped(&self) -> Container<U, T> {
        Container {
            first: self.second,
            second: self.first,
        }
    }

    fn copy_first<V>(&self, second: V) -> Container<T, V>
    where
        V: Copy
    {
        Container {
            first: self.first,
            second,
        }
    }

    fn only_first(&self) -> UniformContainer<T> {
        UniformContainer {
            first: self.first,
            second: self.first,
        }
    }

}

impl Container<f64, f64> {
    fn add_both(&self) -> f64
    {
        self.first + self.second
    }
}

fn main() {
    let a = Container {
        first: 1,
        second: 2.5
    };
    println!("first = {} second = {}", &a.first, &a.second);
    let b = a.swapped();
    println!("first = {} second = {}", &b.first, &b.second);
    let c = b.copy_first("Hello world");
    println!("first = {} second = {}", &c.first, &c.second);
    let d = b.only_first();
    println!("first = {} second = {}", &d.first, &d.second);
    let sum = d.add_both();
    println!("sum = {}", sum);
    // NOTE: The following line give a compile error because types don't mach
    // let x = c.add_both();
}