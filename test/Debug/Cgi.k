K.import("konoha.class");
K.import("clearsilver");

void test_urlEscape() {
	System.p(Cgi.urlEscape("&"))
	System.p(Cgi.urlEscape("あいうえお"))
}
test_urlEscape();

void test_htmlEscape() {
	System.p(Cgi.htmlEscape("&z\"<> "));
}
test_htmlEscape();
