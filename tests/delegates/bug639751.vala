struct Foo {
	public SourceFunc bar;
}

void main() {
	var foo = Foo ();
	foo.bar = () => { foo.bar = null; return false; };
	var baz = foo;
	baz.bar ();
}
