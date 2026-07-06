-- Markdown-only editor behavior (buffer-local, never global).

-- Visual soft wrap: wrap long lines at the window edge without touching the file.
vim.opt_local.wrap = true -- wrap visually
vim.opt_local.linebreak = true -- break at word boundaries, not mid-word
vim.opt_local.breakindent = true -- keep visual indent on wrapped lines

-- Prevent automatic HARD line breaks while typing.
-- The markdown ftplugin sometimes sets textwidth and the 't' flag, so we
-- explicitly clear them per buffer.
vim.opt_local.textwidth = 0 -- disable auto hard-wrap by column
vim.opt_local.formatoptions:remove({ "t", "c" }) -- don't auto-insert line breaks

-- Format-on-save stays ENABLED for markdown: prettier aligns tables and
-- normalizes lists/headings. Prose is protected by --prose-wrap preserve
-- (see lua/plugins/conform.lua), so paragraphs are never reflowed.
