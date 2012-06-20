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
