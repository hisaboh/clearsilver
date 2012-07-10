K.import("konoha");
K.import("clearsilver");

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

int render_callback(String s) {
	System.p(s);
	return STATUS_OK;
}

void test_render() {
	Hdf hdf = new Hdf();
	hdf.setValue("name", "ワールド")
	Cs cs = new Cs(hdf);
	cs.parseString("hello <?cs var:name ?>");
	cs.render(render_callback);
}
test_render();

int dump_callback(String s) {
	System.p(s);
	return STATUS_OK;
}
void test_dump() {
	Hdf hdf = new Hdf();
	Cs cs = new Cs(hdf);
	cs.parseString("かきくけこ");
	cs.dump(dump_callback);
}
test_dump();
