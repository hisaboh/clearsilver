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

void test_getObj() {
	Hdf hdf = new Hdf();
	hdf.setValue("abc.cde.efg", "efg val");
	Hdf obj = hdf.getObj("abc");
	System.p(obj.writeString());
}
test_getObj();

void test_objValue() {
	Hdf hdf = new Hdf();
	hdf.setValue("abc.cde", "efg val");
	Hdf subnode1 = hdf.getObj("abc");
	Hdf subnode2 = hdf.getObj("abc.cde");
	System.p(hdf.objValue());
	System.p(subnode1.objValue());
	System.p(subnode2.objValue());
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