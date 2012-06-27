K.import("konoha");
K.import("lib.clearsilver");

boolean test_new() {
	Hdf hdf = new Hdf();
	Cs cs = new Cs(hdf);
	return true;
}
assert(test_new());

boolean test_parseString() {
	Hdf hdf = new Hdf();
	Cs cs = new Cs(hdf);
	cs.parseString("hogehoge");
	return true;
}
assert(test_parseString());

boolean test_parseFile() {
	Hdf hdf = new Hdf();
	Cs cs = new Cs(hdf);
	cs.parseFile("../test/Debug/Cs.k.cs");
	return true;
}
assert(test_parseFile());
