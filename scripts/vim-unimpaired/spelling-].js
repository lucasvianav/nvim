const fs = require('fs')
const settingsPath = process.env.HOME + '/.config/Code/User/settings.json'

const settings = JSON.parse(fs.readFileSync(settingsPath))

settings["cSpell.enabled"] = false

fs.writeFileSync(settingsPath, JSON.stringify(settings, null, 4), 'utf8')