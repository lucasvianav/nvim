const fs = require('fs')
const settingsPath = process.env.HOME + '/.config/Code/User/settings.json'

const settings = JSON.parse(fs.readFileSync(settingsPath))

const next = {
    'on': 'relative',
    'relative': 'on'
}

settings["editor.lineNumbers"] = next[settings["editor.lineNumbers"]]

fs.writeFileSync(settingsPath, JSON.stringify(settings, null, 4), 'utf8')