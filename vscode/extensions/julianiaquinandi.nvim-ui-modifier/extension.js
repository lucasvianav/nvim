// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
const vscode = require("vscode");

// this method is called when your extension is activated
// your extension is activated the very first time the command is executed

function getConfiguration(section = "") {
  const activeTextEditor = vscode.window.activeTextEditor;
  const resource = activeTextEditor ? activeTextEditor.document.uri : null;
  return vscode.workspace.getConfiguration(section, resource);
}

function changeColor(workbenchConfig, color, foregroundColor = '#202020') {
  const currentColorCustomizations = workbenchConfig.get("colorCustomizations") || {};
  const colorCustomizations = { ...currentColorCustomizations };

  const keys = [
    "activityBarBadge.background",
    "editorCursor.foreground",
    "inputValidation.errorBorder",
    "panel.border",
    "panelTitle.activeBorder",
    "panelTitle.activeForeground",
    "peekView.border",
    "peekViewTitleLabel.foreground",
    "tab.activeBorder",
    "statusBar.border",
    "statusBar.background",
  ];

  keys.forEach((key) => (colorCustomizations[key] = color));
  keys.forEach(key => key.endsWith('.background') ? colorCustomizations[key.replace('.background', '.foreground')] = foregroundColor : '')

  if (currentColorCustomizations !== colorCustomizations) {
    workbenchConfig.update("colorCustomizations", colorCustomizations, true);
  }
}

/**
 * @param {vscode.ExtensionContext} context
 */
function activate(context) {
  const workbenchConfig = getConfiguration("workbench");

  // const operationMode = workbenchConfig.get('nvimUiMode')
  
  foregroundColor = workbenchConfig.get("nvimColorForeground")

  const cmds = [
    vscode.commands.registerCommand("nvim-theme.normal", function () {
      changeColor(workbenchConfig, workbenchConfig.get("nvimColorNormal"), foregroundColor);
    }),
    vscode.commands.registerCommand("nvim-theme.insert", function () {
      changeColor(workbenchConfig, workbenchConfig.get("nvimColorInsert"), foregroundColor);
    }),
    vscode.commands.registerCommand("nvim-theme.visual", function () {
      changeColor(workbenchConfig, workbenchConfig.get("nvimColorVisual"), foregroundColor);
    }),
    vscode.commands.registerCommand("nvim-theme.replace", function () {
      changeColor(workbenchConfig, workbenchConfig.get("nvimColorReplace"), foregroundColor);
    }),
  ];
  // The command has been defined in the package.json file
  // Now provide the implementation of the command with  registerCommand
  // The commandId parameter must match the command field in package.json
  cmds.forEach((cmd) => context.subscriptions.push(cmd));
}
exports.activate = activate;

// this method is called when your extension is deactivated
function deactivate() {}

module.exports = {
  activate,
  deactivate,
};
