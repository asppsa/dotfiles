local gitlinker = require("gitlinker")
local neogit = require("neogit")
local diffview = require("diffview")

gitlinker.setup()

neogit.setup {
  integrations = {
    diffview = true
  },
}

diffview.setup({
  use_icons = false
})
