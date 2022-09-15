local util = require("vim.lsp.util")
local lspconfig = require("lspconfig")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local servers = {
	"tailwindcss",
	"tsserver"
}

local enhance_server_opts = {
	["sumneko_lua"] = function(opts)
		opts.settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		}
	end,

	--[[
    -- Provide settings that should only apply to the "jsonls" server
    ["jsonls"] = function(opts)
        opts.settings = {
            json = {
                -- schemas = require("custom.lsp.settings.jsonls")
            }
        }
    end,
    -- Provide settings that should only apply to the "emmet_ls" server
    ["emmet_ls"] = function(opts)
        opts.filetypes = {"html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less"}
    end
]]
}

for _, name in pairs(servers) do
	local opts = {
		capabilities = capabilities,
		on_attach = on_attach,
	}

	if enhance_server_opts[name] then
		-- Enhance the default opts with the server-specific ones
		enhance_server_opts[name](opts)
	end

	lspconfig[name].setup(opts)
end

--[[
--
-- TODO: Use this in neovim 0.8
--
local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end
]]

local lsp_formatting = function(client, bufnr)
	vim.keymap.set("n", "<leader>f", function()
		local params = util.make_formatting_params({})
		client.request("textDocument/formatting", params, nil, bufnr)
	end, { buffer = bufnr })
end

-- null-ls

local null_ls = require("null-ls")

null_ls.setup({

	on_attach = function(client, bufnr)
		lsp_formatting(client, bufnr)
		on_attach(client, bufnr)
	end,

	sources = {
		null_ls.builtins.formatting.prettier,
	},
})

