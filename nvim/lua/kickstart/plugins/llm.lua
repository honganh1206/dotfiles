local function local_llm_streaming_handler(chunk, line, assistant_output, bufnr, winid, F)
  if not chunk then
    return assistant_output
  end
  local tail = chunk:sub(-1, -1)
  if tail:sub(1, 1) ~= "}" then
    line = line .. chunk
  else
    line = line .. chunk
    local status, data = pcall(vim.fn.json_decode, line)
    if not status or not data.message.content then
      return assistant_output
    end
    assistant_output = assistant_output .. data.message.content
    F.WriteContent(bufnr, winid, data.message.content)
    line = ""
  end
  return assistant_output
end

local function local_llm_parse_handler(chunk)
  local assistant_output = chunk.message.content
  return assistant_output
end

return {
  {
    "Kurama622/llm.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
    config = function()
      local tools = require("llm.common.tools")
      require("llm").setup({
        url = "http://localhost:11434/api/chat", -- your url
        model = "deepseek-r1:1.5b",
        api_type = "ollama",

        streaming_handler = local_llm_streaming_handler,
        app_handler = {
          -- WordTranslate = {
          --   handler = tools.flexi_handler,
          --   prompt = "Translate the following text to Chinese, please only return the translation",
          --   opts = {
          --     parse_handler = local_llm_parse_handler,
          --     exit_on_move = true,
          --     enter_flexible_window = false,
          --   },
          -- },
          OptimizeCode = {
            handler = tools.side_by_side_handler,
            opts = {
              streaming_handler = local_llm_streaming_handler,
            },
          },
          TestCode = {
            handler = tools.side_by_side_handler,
            prompt = [[ Write some test cases for the following code, only return the test cases.
            Give the code content directly, do not use code blocks or other tags to wrap it. ]],
            opts = {
              streaming_handler = local_llm_streaming_handler,
              right = {
                title = " Test Cases ",
              },
            },
          },
          -- OptimCompare = {
          --   handler = tools.action_handler,
          --   opts = {
          --     url = "https://models.inference.ai.azure.com/chat/completions",
          --     model = "gpt-4o",
          --     api_type = "openai",
          --   },
          -- },
          CodeExplain = {
            handler = tools.flexi_handler,
            prompt = "Explain the following code, please only return the explanation",
            opts = {
              parse_handler = local_llm_parse_handler,
              enter_flexible_window = true,
            },
          },
        },
        style = "right",
        max_tokens = 1024,
        save_session = true,
        max_history = 15,
        history_path = "/tmp/history", -- where to save history
        temperature = 0.3,
        top_p = 0.7,

        spinner = {
          text = {
            "󰧞󰧞",
            "󰧞󰧞",
            "󰧞󰧞",
            "󰧞󰧞",
          },
          hl = "Title",
        },

        display = {
          diff = {
            layout = "vertical",    -- vertical|horizontal split for default provider
            opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
            provider = "mini_diff", -- default|mini_diff
          },
        },

        -- stylua: ignore
        keys = {
          -- The keyboard mapping for the input window.
          ["Input:Cancel"]      = { mode = "n", key = "<C-c>" },
          ["Input:Submit"]      = { mode = "n", key = "<cr>" },
          ["Input:Resend"]      = { mode = "n", key = "<C-r>" },

          -- only works when "save_session = true"
          ["Input:HistoryNext"] = { mode = "n", key = "<C-j>" },
          ["Input:HistoryPrev"] = { mode = "n", key = "<C-k>" },

          -- The keyboard mapping for the output window in "split" style.
          ["Output:Ask"]        = { mode = "n", key = "i" },
          ["Output:Cancel"]     = { mode = "n", key = "<C-c>" },
          ["Output:Resend"]     = { mode = "n", key = "<C-r>" },

          -- The keyboard mapping for the output and input windows in "float" style.
          ["Session:Toggle"]    = { mode = "n", key = "<leader>ac" },
          ["Session:Close"]     = { mode = "n", key = "<esc>" },
        },
      })
    end,
    keys = {
      { "<leader>av", mode = "v", "<cmd>LLMSelectedTextHandler<cr>" },
      { "<leader>ax", mode = "x", "<cmd>LLMSelectedTextHandler<cr>" },
      { "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>" },
      -- { "<leader>ts", mode = "x", "<cmd>LLMAppHandler WordTranslate<cr>" },
      { "<leader>ae", mode = "v", "<cmd>LLMAppHandler CodeExplain<cr>" },
      -- { "<leader>at", mode = "n", "<cmd>LLMAppHandler Translate<cr>" },
      { "<leader>tc", mode = "x", "<cmd>LLMAppHandler TestCode<cr>" },
      -- { "<leader>ao", mode = "x", "<cmd>LLMAppHandler OptimCompare<cr>" },
      -- { "<leader>au", mode = "n", "<cmd>LLMAppHandler UserInfo<cr>" },
      -- { "<leader>ag", mode = "n", "<cmd>LLMAppHandler CommitMsg<cr>" },
      { "<leader>ao", mode = "x", "<cmd>LLMAppHandler OptimizeCode<cr>" },
    },
  }
}
