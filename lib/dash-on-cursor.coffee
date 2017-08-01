shell = require 'shell'

grammar2docsets =
  C: "c,glib,gl2,gl3,gl4,manpages"
  "C++": "cpp,net,boost,qt,cvcpp,cocos2dx,c,manpages"
  CoffeeScript: "coffee"
  CSS: "css,bootstrap,foundation,less,cordova,phonegap"
  "Github Markdown": "markdown"
  Go: "go"
  HTML: "html,svg,css,bootstrap,foundation,javascript,jquery,jqueryui,jquerym,angularjs,backbone,marionette,meteor,moo,prototype,ember,lodash,underscore,sencha,extjs,knockout,zepto,cordova,phonegap,yui"
  Java: "java,javafx,grails,groovy,playjava,spring,cvj,processing"
  JavaScript: "javascript,backbone,angularjs,nodejs"
  LESS: "less"
  "Objective-C": "cpp,iphoneos,macosx,appledoc,cocos2dx,cocos2d,cocos3d,kobold2d,sparrow,c,manpages"
  "Objective-C++": "cpp,iphoneos,macosx,appledoc,cocos2dx,cocos2d,cocos3d,kobold2d,sparrow,c,manpages"
  Perl: "perl,manpages"
  PHP: "php,wordpress,drupal,zend,laravel,yii,joomla,ee,codeigniter,cakephp,symfony,typo3,twig,smarty,html,mysql,sqlite,mongodb,psql,redis"
  Python: "python3,django,twisted,sphinx,flask,cvp"
  Ruby: "ruby,rubygems,rails"
  SASS: "sass,compass,bourbon,neat,css"
  Scala: "scala,akka,playscala"
  YAML: "chef,ansible"

module.exports =
  activate: (state) ->
    atom.commands.add 'atom-workspace','dash-on-cursor:open': => @open()

  open: ->
    editor = atom.workspace.getActiveTextEditor()
    return unless editor?

    token = editor.tokenForBufferPosition(editor.getCursorBufferPosition())
    return unless token?.value

    grammar = editor.getGrammar()
    docsets = grammar2docsets[grammar.name] if grammar
    if docsets
      shell.openExternal("dash-plugin://keys=#{docsets}&query=#{token.value}")
    else
      shell.openExternal("dash://#{token.value}")
