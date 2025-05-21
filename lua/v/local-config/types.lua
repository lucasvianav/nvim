---@meta _

---@alias KtlintRulesetVersionOpts
---|"2.0.0"
---|"1.0.0"
---|"0.50.0"

---@class LocalKtlintConfig
---@field ruleset_version KtlintRulesetVersionOpts?
---@field ruleset_jar_path string?
---@field baseline_file_path string?

---@class LocalEfmConfig
---@field ktlint LocalKtlintConfig?

---@class LocalNvimConfig
---@field efm LocalEfmConfig?
