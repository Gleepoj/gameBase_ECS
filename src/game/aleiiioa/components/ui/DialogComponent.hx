package aleiiioa.components.ui;



import aleiiioa.builders.UIBuild;

import hxyarn.program.VirtualMachine.ExecutionState;
import haxe.Exception;

import hxyarn.dialogue.Dialogue;
import hxyarn.dialogue.VariableStorage.MemoryVariableStore;
import hxyarn.dialogue.StringInfo;
import hxyarn.dialogue.Line;
import hxyarn.dialogue.Command;
import hxyarn.dialogue.Option;
import hxyarn.dialogue.OptionSet;
import hxyarn.compiler.Compiler;
import hxyarn.compiler.CompilationJob;

class DialogComponent {
	
    public var dialogue:Dialogue;
	public var optionCount:Int = 0;
    public var isComplete:Bool = false;

	var storage = new MemoryVariableStore();
	var stringTable:Map<String, StringInfo>;
	
	public function new(yarnFile:String) {
		
		dialogue = new Dialogue(new MemoryVariableStore());
		dialogue.logDebugMessage = this.logDebugMessage;
		dialogue.logErrorMessage = this.logErrorMessage;
		dialogue.lineHandler = this.lineHandler;
		dialogue.optionsHandler = this.optionsHandler;
		dialogue.commandHandler = this.commandHandler;
		dialogue.nodeCompleteHandler = this.nodeCompleteHandler;
		dialogue.nodeStartHandler = this.nodeStartHandler;
		dialogue.dialogueCompleteHandler = this.dialogueCompleteHandler;

		var job = CompilationJob.createFromFiles([yarnFile], dialogue.library);
		var compilerResults = Compiler.compile(job);
		stringTable = compilerResults.stringTable;

		dialogue.addProgram(compilerResults.program);
	}

	public function start() {
		dialogue.setNode("Start");
        dialogue.resume();
	}

	function setUp(fileName:String) {}

    // ovverride? 
	public function lineHandler(line:Line):HandlerExecutionType {
		var text = getComposedTextForLine(line);
        
		UIBuild.dialog('$text',2);
        
		return HandlerExecutionType.ContinueExecution;
	}

	public function optionsHandler(options:OptionSet) {
		optionCount = options.options.length;
		var optionText = new Array<String>();
		var count:Int = -1;

		//trace("Options:");
		for (option in options.options) {
			var text = getComposedTextForLine(option.line);
			optionText.push(text);
			count += 1;
            UIBuild.option('$text', count);
		}

	}

	public function getComposedTextForLine(line:Line):String {
		var substitutedText = Dialogue.expandSubstitutions(stringTable[line.id].text, line.substitutions);

		var markup = dialogue.parseMarkup(substitutedText);

		return markup.text;
	}

    
	public function logDebugMessage(message:String):Void {
		//trace('DEBUG: $message');
	}

	public function logErrorMessage(message:String):Void {
		//trace('Error: $message');
	}

	public function commandHandler(command:Command) {
		trace('Command: ${command.text}');
	}

	public function nodeCompleteHandler(nodeName:String) {}

	public function nodeStartHandler(nodeName:String) {}

	public function dialogueCompleteHandler() {
		//trace("current dialogue end");
        isComplete = true;
	}

	function assertString(expected:String, actual:String) {
		if (expected != actual)
			throw new Exception('Expected: "$expected", but got "$actual"');
	}

	function assertBool(expected:Bool, actual:Bool) {
		if (expected != actual)
			throw new Exception('Expected: "$expected", but got "$actual"');
	}

	function assertInt(expected:Int, actual:Int) {
		if (expected != actual)
			throw new Exception('Expected: "$expected", but got "$actual"');
	}
}
