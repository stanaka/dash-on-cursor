{WorkspaceView} = require 'atom'
shell = require 'shell'

describe "dash-on-cursor package", ->
  activationPromise = null

  beforeEach ->
    atom.packages.activatePackage('language-coffee-script')

    atom.workspaceView = new WorkspaceView
    atom.workspace = atom.workspaceView.model

    activationPromise = atom.packages.activatePackage('dash-on-cursor')

  describe "when the dash:open event is triggered", ->
    it "opens dash for searching text on the cursor", ->
      atom.workspaceView.openSync('sample.coffee')
      editorView = atom.workspaceView.getActiveView()
      {editor} = editorView
      editor.setText("return\n")

      spyOn(shell, 'openExternal')
      editorView.trigger('dash-on-cursor:open')
      expect(shell.openExternal).not.toHaveBeenCalled()

      editor.setCursorBufferPosition([0,5])
      editorView.trigger('dash-on-cursor:open')

      expect(shell.openExternal).toHaveBeenCalled()
      expect(shell.openExternal.argsForCall[0][0]).toBe 'dash://return'
