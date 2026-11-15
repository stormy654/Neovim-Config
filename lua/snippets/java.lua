local ls     = require("luasnip")
local s      = ls.snippet
local i      = ls.insert_node
local t      = ls.text_node
local extras = require("luasnip.extras");
local rep    = extras.rep;
local t      = ls.text_node

return {
	s("main",{
		t({ "public static void main(String[] args){",""}),
		i(1),
		t({ "","}" }),
	}),
	s("print",{
		t("System.out.print("),
		i(1),
		t(");"),
	}),
	s("println",{
		t("System.out.println("),
		i(1),
		t(");"),
	}),
	s("for",{
		t("for("),
		i(1),
		t({"){",""}),
		i(2),
		t({ "","}" }),
	}),
}

