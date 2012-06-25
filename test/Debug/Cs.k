K.import("konoha.class");
K.import("lib.clearsilver");

boolean test_new() {
	Hdf hdf = new Hdf();
	Cs cs = new Cs(hdf);
	return true;
}
assert(test_new());