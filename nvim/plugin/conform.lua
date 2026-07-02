if vim.g.did_load_conform_plugin then
   return
end
vim.g.did_load_conform_plugin = true

require("conform").setup({
   event = { 'BufWritePre' },
   cmd = { 'ConformInfo' },
   keys = {
      {
         '<leader>f',
         function() require('conform').format { async = true, lsp_format = 'fallback' } end,
         mode = '',
         desc = '[F]ormat buffer',
      },
   },
   formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      -- You can customize some of the format options for the filetype (:help conform.format)
      rust = { "rustfmt", lsp_format = "fallback" },
      -- Conform will run the first available formatter
      javascript = { "prettierd", "prettier", stop_after_first = true },
      nix = { "nixfmt", "nixpkgs_fmt", stop_after_first = true },
   },
   format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
         return nil
      else
         return {
            timeout_ms = 500,
            lsp_format = 'fallback',
         }
      end
   end,
})
