struct Container<T, U>
where
    T: Copy,
    U: Copy,
{
    first: T,
    second: U,
}

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
}