---personal namespace
_G.v = {}

---load local config into global namespace
_G.v.local_config = require('v.local-config').config or {}
