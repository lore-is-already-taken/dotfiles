return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*",
	main = "after.luasnip",
	config = true,
	-- install jsregexp (optional!).
	build = "make install_jsregexp",
}
