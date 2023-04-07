-- Disable line numbers any time a terminal is opened
vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("UserTermConfig", {}),
    callback = function ()
        vim.opt_local.number = false
    end
})

-- Keybinds only needed when an lsp server is attached
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function (ev)
        -- Helper function to make adding lsp keymaps simpler
        local nmap = function (keys, func, desc)
            if desc then
                desc = "LSP: " .. desc
            end

            vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = desc })
        end

        -- Attach useful lsp functions to keybinds
        -- Movement
        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        nmap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")

        -- Documentation
        nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

        -- Actions
        nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        nmap("<space>rf", function ()
            vim.lsp.buf.format({ async = true })
        end, "[R]e[f]ormat")

        -- Workspaces
        nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
        nmap("<leader>wl", function ()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[W]orkspace [L]ist Folders")

        -- Find symbols
        nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    end,
})
