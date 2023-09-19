local gitlinker = require("gitlinker")
local neogit = require("neogit")
local diffview = require("diffview")
local vgit = require("vgit")

gitlinker.setup()

neogit.setup {
  integrations = {
    diffview = true
  },
  kind = 'split'
}

diffview.setup({
  use_icons = false
})

vgit.setup()
