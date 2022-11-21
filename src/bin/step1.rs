struct Container<T, U>
where
    T: Copy,
    U: Copy,
{
    first: T,
    second: U,
}

fn main() {
    let a = Container {
        first: 1,
        second: 2.5
    };
    println!("first = {} second = {}", &a.first, &a.second);
}