local ls     = require("luasnip")
local s      = ls.snippet
local i      = ls.insert_node
local t      = ls.text_node
local extras = require("luasnip.extras");
local rep    = extras.rep;
local t      = ls.text_node

return {
	s("html", {
		t({
			"<!DOCTYPE html>",
			"<html>",
			"<head>",
			"    <title>",
		}),
		i(1),
		t({
			"</title>",
			"</head>",
			"<body>",
			"</body>",
			"</html>",
		}),
	}),
}
