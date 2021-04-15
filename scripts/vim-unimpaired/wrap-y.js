const fs = require('fs')
const settingsPath = process.env.HOME + '/.config/Code/User/settings.json'

const settings = JSON.parse(fs.readFileSync(settingsPath))

const next = {
    'off': 'on',
    'on': 'off'
}

settings["editor.wordWrap"] = next[settings["editor.wordWrap"]]

fs.writeFileSync(settingsPath, JSON.stringify(settings, null, 4), 'utf8')