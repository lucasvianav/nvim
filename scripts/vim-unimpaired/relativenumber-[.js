const fs = require('fs')
const settingsPath = process.env.HOME + '/.config/Code/User/settings.json'

const settings = JSON.parse(fs.readFileSync(settingsPath))

const next = {
    'off': 'interval',
    'interval': 'relative',
    'relative': 'on',
    'on': 'off'
}

settings["editor.lineNumbers"] = next[settings["editor.lineNumbers"]]

fs.writeFileSync(settingsPath, JSON.stringify(settings, null, 4), 'utf8')

