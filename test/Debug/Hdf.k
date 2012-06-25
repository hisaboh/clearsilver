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

void test_writeFile() {
	Hdf hdf = new Hdf();
	hdf.setValue("a.b.c", "val");
	hdf.writeFile("Testing/Temporary/testfile.hdf");

	Hdf test = new Hdf();
	test.readFile("Testing/Temporary/testfile.hdf");
	System.p(test.writeString());
	assert(hdf.writeString() == test.writeString());
}
test_writeFile();

void test_writeFileAtomic() {
	Hdf hdf = new Hdf();
	hdf.setValue("a.b.c", "val");
	hdf.writeFileAtomic("Testing/Temporary/testfile_atomic.hdf");

	Hdf test = new Hdf();
	test.readFile("Testing/Temporary/testfile_atomic.hdf");
	System.p(test.writeString());
	assert(hdf.writeString() == test.writeString());
}
test_writeFileAtomic();
