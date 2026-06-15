local ls     = require("luasnip")
local s      = ls.snippet
local i      = ls.insert_node
local t      = ls.text_node
local extras = require("luasnip.extras");
local rep    = extras.rep;
local t      = ls.text_node
return {
	s("begin", {
    t("\\begin{"),
    i(1, "itemize"),
    t({ "}", "" }),
	i(2),
    t({ "", "\\end{" }),
    rep(1),
    t("}"),
}),
	s("section",{
		t("\\section{"),
		i(1),
		t("}"),
	}),
	s("subsection",{
		t("\\subsection{"),
		i(1),
		t("}"),
	}),
	s("subsubsection",{
		t("\\subsubsection{"),
		i(1),
		t("}"),
	}),
	s("frac",{
		t("\\frac{"),
		i(1),
		t("}{"),
		i(2),
		t("}"),
	}),
}
