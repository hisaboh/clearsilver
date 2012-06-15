K.import("konoha.class");
K.import("lib.clearsilver");

boolean test_set() {
	Hdf hdf = new Hdf();
	hdf.setValue("key", "val");
	return true;
}

assert(test_set());
