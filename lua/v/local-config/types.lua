---@meta _

---@alias KtlintRulesetVersionOpts
---|"default"
---|"2.0.0"
---|"1.5.0"
---|"1.4.1"
---|"1.3.1"
---|"1.3.0"
---|"1.2.1"
---|"1.2.0"
---|"1.1.1"
---|"1.0.1"
---|"0.50.0"

---@class EfmExtensionLocalConfig
---@field enabled boolean?

---@class LocalKtlintConfig : EfmExtensionLocalConfig
---@field ruleset_version KtlintRulesetVersionOpts?
---@field ruleset_jar_path string?
---@field baseline_file_path string?

---@class LocalEfmConfig
---@field ktlint LocalKtlintConfig?
---@field [string] EfmExtensionLocalConfig?

---@class LocalNvimConfig
---@field efm LocalEfmConfig?
