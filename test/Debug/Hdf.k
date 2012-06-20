K.import("konoha.class");
K.import("lib.clearsilver");

boolean test_setValue() {
	Hdf hdf = new Hdf();
	hdf.setValue("key", "val");
	return true;
}
assert(test_setValue());

test_getValue() {
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

