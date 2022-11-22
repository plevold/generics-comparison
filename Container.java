class Container<T, U> {
    public T first;
    public U second;

    public Container(T first, U second) {
        this.first = first;
        this.second = second;
    }

    public Container<U, T> swapped() {
        log("swapped");
        return new Container<>(second, first);
    }

    public <V> Container<T, V> copy_first(V second) {
        log("copy_first");
        return new Container<>(this.first, second);
    }

    protected void log(String operation) {
        System.out.println("-- Container: " + operation + " called on object with "
            + first + " and " + second);
    }
}

class LargeContainer<T, U, V> extends Container<T, U> {
    public V third;

    public LargeContainer(T first, U second, V third) {
        super(first, second);
        this.third = third;
    }

    protected void log(String operation) {
        System.out.println("-- LargeContainer: " + operation + " called on object with "
            + first + " and " + second + " and " + third);
    }
}

class Main {
    /*
    When run, this outputs:

    first = 1 second = 2.5
    -- Container: swapped called on object with 1 and 2.5
    first = 2.5 second = 1
    -- Container: copy_first called on object with 2.5 and 1
    first = 2.5 second = Hello world
    -- LargeContainer: copy_first called on object with 1 and 42 and 3.14
first = 1 second = 2
-- LargeContainer: copy_first called on object with 1 and 42 and 3.14
first = 1 second = foo
    */
    public static void main(String args[]) {
        var a = new Container<>(1, 2.5);
        System.out.println("first = " + a.first + " second = " + a.second);
        var b = a.swapped();
        System.out.println("first = " + b.first + " second = " + b.second);
        var c = b.copy_first("Hello world");
        System.out.println("first = " + c.first + " second = " + c.second);
        var d = new LargeContainer<>(1, 42, 3.14);
        var e = d.copy_first(2);
        System.out.println("first = " + e.first + " second = " + e.second);
        var f = d.copy_first("foo");
        System.out.println("first = " + f.first + " second = " + f.second);
    }
}