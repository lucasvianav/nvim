local colors = require("v.utils").colors
require("nvim-web-devicons").setup({
  override = {
    ["docker-compose.yml"] = {
      icon = "󰡨 ",
      color = colors.blue_light,
      name = "Dockerfile",
    },
    Dockerfile = {
      icon = "󰡨 ",
      color = colors.blue_light,
      name = "Dockerfile",
    },
    graphql = {
      icon = "󰡷 ",
      color = colors.pink,
      name = "GraphQL",
    },
    graphqls = {
      icon = "󰡷 ",
      color = colors.pink,
      name = "GraphQL",
    },
    gql = {
      icon = "󰡷 ",
      color = colors.pink,
      name = "GraphQL",
    },
    ["*Test.kt"] = {
      icon = "ﭧ",
      color = colors.purple,
      name = "KotlinTest",
    },
    ["stories.jsx"] = {
      icon = "ﭧ",
      color = colors.salmon,
      name = "JavascriptStorybook",
    },
    ["stories.tsx"] = {
      icon = "ﭧ",
      color = colors.salmon,
      name = "TypescriptStorybook",
    },
    ["test.js"] = {
      icon = "ﭧ",
      color = colors.yellow,
      name = "JavascriptTest",
    },
    ["spec.js"] = {
      icon = "ﭧ",
      color = colors.yellow,
      name = "JavascriptTest",
    },
    ["test.ts"] = {
      icon = "ﭧ",
      color = colors.cyan,
      name = "TypescriptTest",
    },
    ["spec.ts"] = {
      icon = "ﭧ",
      color = colors.cyan,
      name = "TypescriptTest",
    },
  },
  default = true,
})
