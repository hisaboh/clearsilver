K.import("konoha.class");
K.import("lib.clearsilver");

boolean test_setValue() {
	Hdf hdf = new Hdf();
	hdf.setValue("key", "val");
	return true;
}
assert(test_setValue());

void test_getObj() {
	Hdf hdf = new Hdf();
	hdf.setValue("abc.cde.efg", "efg val");
	Hdf obj = hdf.getObj("abc");
	Hdf notExist = hdf.getObj("c.d.e");
	System.p(obj.writeString());
	System.p(notExist.writeString());
	System.p(hdf.writeString());
}
test_getObj();

void test_getNode() {
	Hdf hdf = new Hdf();
	hdf.setValue("abc.cde.efg", "efg val");
	Hdf obj = hdf.getNode("abc");
	Hdf notExist = hdf.getNode("c.d.e");
	System.p(obj.writeString());
	System.p(notExist.writeString());
	System.p(hdf.writeString());
}
test_getNode();

void test_objChild() {
	Hdf hdf = new Hdf();
	hdf.setValue("a.b.c", "c val");
	hdf.setValue("d.e.f", "f value");
	System.p(hdf.objChild().writeString());
}
test_objChild();

void test_objNext() {
	Hdf hdf = new Hdf();
	hdf.setValue("a.b.c", "c val");
	hdf.setValue("d.e.f", "f value");
	Hdf a = hdf.getObj("a");
	Hdf b = hdf.getObj("a.b");
	System.p(a.objName());
	System.p(a.objNext().objName());
	System.p(a.objNext().objNext().objName());
	System.p(b.objName())
	System.p(b.objNext().objName())
}
test_objNext();

void test_getChild() {
	Hdf hdf = new Hdf();
	hdf.setValue("a.b.c", "c val");
	hdf.setValue("d.e.f", "f value");
	System.p(hdf.getChild("d.e").objName());
}
test_getChild();

void test_objTop() {
	Hdf hdf = new Hdf();
	hdf.setValue("a.b.c", "c val");
	Hdf child = hdf.getObj("a.b");
	System.p(child.writeString());
	Hdf top = child.objTop();
	System.p(top.writeString());
	assert(top.writeString() == hdf.writeString());
}
test_objTop();

// void test_setSymLink() {
// 	Hdf hdf = new Hdf();
// 	hdf.setValue("a.b.c", "c val");
// 	hdf.setValue("d.e.f", "f val");
// 	System.p(hdf.writeString());
// 	hdf.setSymLink("a.b.c", "d.e");
// 	System.p(hdf.writeString());
// 	System.p(hdf.getObj("a.b.c").objName());
// }
// test_setSymLink();
