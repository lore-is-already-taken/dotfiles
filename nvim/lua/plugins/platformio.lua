-- Desarrollo de firmware ESP32 / PlatformIO.
--
-- Tres piezas independientes:
--   1. nvim-platformio.lua  -> compilar, subir y monitorear sin salir del editor
--   2. clangd               -> autocompletado y diagnosticos reales sobre el
--                              codigo del firmware
--   3. treesitter           -> resaltado de C/C++
--
-- Requisito externo: PlatformIO Core en el PATH (`pio --version`).
-- Aca esta instalado en ~/.platformio/penv/bin y enlazado desde ~/bin.
--
-- Flujo tipico dentro del proyecto:
--   <leader>\  -> menu de PlatformIO
--   :Piorun upload    (por cable)
--   :Piorun upload -e esp32dev_ota   (por red, sin tocar la placa)
--   :Piomon           (monitor serie)
--
-- IMPORTANTE sobre clangd: `compile_commands.json` no existe hasta que se
-- genera con `pio run -t compiledb`. Sin ese archivo clangd no sabe con que
-- flags se compila cada .cpp y reporta errores falsos. El autocomando del
-- final lo regenera al guardar platformio.ini, que es cuando puede cambiar.

return {
  -- 1. Wrapper de PlatformIO -------------------------------------------------
  {
    "anurag3301/nvim-platformio.lua",

    -- Solo se activa dentro de un proyecto PlatformIO. En cualquier otro sitio
    -- el plugin no existe y no cuesta nada. `:Pioinit` lo levanta a mano.
    cond = function()
      return vim.fn.filereadable("platformio.ini") == 1
    end,

    cmd = { "Pioinit", "Piorun", "Piomon", "Piodebug", "Piolib", "Piolsserial" },

    dependencies = {
      -- El plugin ejecuta los comandos de pio dentro de terminales de
      -- toggleterm; es una dependencia dura, no opcional.
      { "akinsho/toggleterm.nvim", opts = {} },
      { "nvim-lua/plenary.nvim" },
      { "folke/which-key.nvim" },
    },

    config = function()
      require("platformio").setup({
        lsp = "clangd",
        -- 'compiledb' usa `pio run -t compiledb`, que es justamente lo que
        -- entiende la config de .clangd de este proyecto. La alternativa
        -- ('ccls') exigiria instalar otro servidor de lenguaje.
        clangd_source = "compiledb",
        -- Este setup usa snacks_picker, no telescope. 'ui_select' delega en
        -- vim.ui.select, que snacks ya reemplaza: cero dependencias extra.
        picker_backend = "ui_select",
        menu_key = "<leader>\\",
        debug = false,
      })
    end,
  },

  -- 2. clangd sobre el toolchain cruzado ------------------------------------
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      local clangd = opts.servers.clangd or {}

      -- --query-driver le permite a clangd EJECUTAR el compilador cruzado para
      -- preguntarle cuales son sus includes de sistema. Es un flag de linea de
      -- comandos: no se puede poner en el archivo .clangd. Sin el, ningun
      -- header del framework Arduino/ESP-IDF resuelve.
      clangd.cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
        -- El glob lo resuelve clangd, no vim: `expand()` con comodines
        -- devolveria una sola coincidencia y perderia el resto de binarios.
        -- Por eso solo se expande el `~`.
        "--query-driver=" .. vim.fn.expand("~") .. "/.platformio/packages/toolchain-*/bin/*-elf-g*",
      }

      -- Sin esto clangd enraiza en el primer Makefile o .git que encuentre
      -- hacia arriba, y pierde de vista el compile_commands.json del proyecto.
      clangd.root_markers = vim.list_extend(
        { "platformio.ini", ".clangd", "compile_commands.json" },
        clangd.root_markers or {}
      )

      opts.servers.clangd = clangd
    end,
  },

  -- 3. Resaltado ------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "c", "cpp" } },
  },

  -- 4. Mantener el indice de clangd al dia -----------------------------------
  {
    "LazyVim/LazyVim",
    opts = function()
      local group = vim.api.nvim_create_augroup("platformio_compiledb", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = group,
        pattern = "platformio.ini",
        desc = "Regenerar compile_commands.json tras cambiar la config de PlatformIO",
        callback = function()
          vim.notify("PlatformIO: regenerando compile_commands.json...", vim.log.levels.INFO)
          vim.system({ "pio", "run", "-t", "compiledb" }, { text = true }, function(result)
            vim.schedule(function()
              if result.code == 0 then
                vim.notify("PlatformIO: compile_commands.json actualizado", vim.log.levels.INFO)
              else
                vim.notify("PlatformIO: fallo compiledb\n" .. (result.stderr or ""), vim.log.levels.ERROR)
              end
            end)
          end)
        end,
      })
    end,
  },
}
