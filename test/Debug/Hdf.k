K.import("konoha.class");
K.import("lib.clearsilver");

boolean test_setValue() {
	Hdf hdf = new Hdf();
	hdf.setValue("key", "val");
	return true;
}
assert(test_setValue());

void test_getValue() {
	Hdf hdf = new Hdf();
	hdf.setValue("key", "val");
	hdf.setValue("key2", "あいう")
	hdf.setValue("鍵", "あああ");
	System.p(hdf.getValue("key", "hoge"));
	System.p(hdf.getValue("non-key", "defval"));
	System.p(hdf.getValue("key2", "defval"));
	System.p(hdf.getValue("鍵", "defval"));
}
test_getValue();

void test_writeString() {
	Hdf hdf = new Hdf();
	hdf.setValue("key", "value");
	hdf.setValue("abc.cde.efg", "efg val");
	System.p(hdf.writeString());
}
test_writeString();

boolean test_dump() {
	Hdf hdf = new Hdf();
	hdf.setValue("key", "value");
	hdf.setValue("abc.cde.efg", "efg val");
	hdf.dump("prefix");
	return true;
}
assert(test_dump());

void test_objValue() {
	Hdf hdf = new Hdf();
	hdf.setValue("abc.cde", "efg val");
	// Hdf subnode1 = hdf.getObj("abc");
	// Hdf subnode2 = hdf.getObj("abc.cde");
	System.p(hdf.objValue());
	// System.p(subnode1.objValue());
	// System.p(subnode2.objValue());
}
test_objValue();

void test_getIntValue() {
	Hdf hdf = new Hdf();
	hdf.setValue("key", "1");
	hdf.setValue("key2", "あいう")
	System.p(hdf.getIntValue("key", 0));
	System.p(hdf.getIntValue("non-key", 3));
	System.p(hdf.getIntValue("key2", 3));
}
test_getIntValue();

void test_copy() {
	Hdf hdf = new Hdf();
	hdf.setValue("key", "value");
	Hdf src = new Hdf();
	src.setValue("srcKey", "value");
	hdf.copy("", src);
	hdf.copy("src", src);
	System.p(hdf.writeString());
}
test_copy();

void test_readString() {
	Hdf hdf = new Hdf();
	hdf.readString("key = value\nabc {\ncde {\nefg = efg val\n}\n}");
	System.p(hdf.writeString());
}
test_readString();

void test_objName() {
	Hdf hdf = new Hdf();
	hdf.setValue("a.b.c", "c val");
	hdf.setValue("d.e.f", "f value");
	// Hdf a = hdf.getObj("a");
	System.p(hdf.objName());
	// System.p(a.objName());
}
test_objName();

void test_setIntValue() {
	Hdf hdf = new Hdf();
	hdf.setIntValue("key", 1);
	System.p(hdf.writeString());
	System.p(hdf.getIntValue("key", 0));
}
test_setIntValue();

void test_setCopy() {
	Hdf hdf = new Hdf();
	hdf.setValue("a.b.c", "c val");
	hdf.setCopy("d", "a.b.c");
	System.p(hdf.writeString());
}
test_setCopy();

void test_removeTree() {
	Hdf hdf = new Hdf();
	hdf.setValue("a", "a val");
	hdf.setValue("a.b", "b val");
	hdf.setValue("a.b.c", "c val");
	hdf.setValue("d.e.f", "f val");
	hdf.removeTree("a.b.c");
	System.p(hdf.writeString());
}
test_removeTree();

void test_objTop() {
	Hdf hdf = new Hdf();
	hdf.setValue("a.b.c", "c val");
	Hdf child = hdf.getObj("a.b");
	System.p(child.writeString());
	Hdf top = child.objTop();
	System.p(child.objTop().writeString());
}
// TODO: このエラーの修正 → konoha(6729) malloc: *** error for object 0x109e147d0: pointer being freed was not allocated
// test_objTop();
