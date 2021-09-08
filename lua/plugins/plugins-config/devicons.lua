local colors = require('utils').colors

require('nvim-web-devicons').setup({
    override = {
        Dockerfile = {
            icon = "",
            color = colors.lightBlue,
            name = "Dockerfile",
        },

        graphql = {
            icon = '',
            color = colors.pink,
            name = 'GraphQL'
        },

        gql = {
            icon = '',
            color = colors.pink,
            name = 'GraphQL'
        },

        ['test.js'] = {
            icon = 'ﭧ',
            color = colors.yellow,
            name = 'JavascriptTest'
        },

        ['spec.js'] = {
            icon = 'ﭧ',
            color = colors.yellow,
            name = 'JavascriptTest'
        },

        ['test.ts'] = {
            icon = 'ﭧ',
            color = colors.cyan,
            name = 'TypescriptTest'
        },

        ['spec.ts'] = {
            icon = 'ﭧ',
            color = colors.cyan,
            name = 'TypescriptTest'
        }
    },

    default = true
})
