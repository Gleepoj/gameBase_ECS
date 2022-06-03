
package aleiiioa.systems.ui;


import echoes.Entity;
import aleiiioa.components.flags.collision.IsDiedFlag;
import aleiiioa.components.ui.UIOptionComponent;
import hxyarn.program.VirtualMachine.ExecutionState;
import haxe.Exception;
import aleiiioa.builders.UIBuild;

import aleiiioa.systems.ui.Navigator;
import haxe.exceptions.*;

import hxyarn.dialogue.Dialogue;
import hxyarn.dialogue.VariableStorage.MemoryVariableStore;
import hxyarn.dialogue.StringInfo;
import hxyarn.dialogue.Line;
import hxyarn.dialogue.Command;
import hxyarn.dialogue.Option;
import hxyarn.dialogue.OptionSet;
import hxyarn.compiler.Compiler;
import hxyarn.compiler.CompilationJob;


class DialogSystem extends echoes.System {
    var dial:DialogText;
    var ca : ControllerAccess<GameAction>;
	var previousState :ExecutionState;
	var state : ExecutionState; // getters to add
	var optionSelect:Int;
	var selector:Int = 1;

    public function new() {
        ca = App.ME.controller.createAccess();
		ca.lockCondition = Game.isGameControllerLocked;
        dial = new DialogText('res/yarn/Example.yarn');
        dial.start();
		state = dial.dialogue.get_executionState();
		previousState = state;
		optionSelect = 0;
		//conf = ca.input.pad.config;
    }

    @u function updateDialog(){
        
    	state = dial.dialogue.get_executionState();
		previousState = state;
		
		optionSelect = selector-1;

        if(ca.isPressed(Blow)){
            if(dial.dialogue.isActive()){
				
				if(state == ExecutionState.WaitingForContinue)
					dial.dialogue.resume();

				if(state == ExecutionState.WaitingOnOptionSelection){
					dial.dialogue.setSelectedOption(optionSelect);
					state = dial.dialogue.get_executionState();
					dial.dialogue.resume();
					selector = 1; 
				}
				
               
			}
        }
		var maxSelector = dial.optionCount;
		if(ca.isDown(MoveLeft)){
			selector -=1;

			if(selector < 1)
				selector = maxSelector;

			ca.lock(0.2);
		}

		if(ca.isDown(MoveRight)){
			selector +=1;
			
			if(selector > maxSelector)
				selector = 1;

			ca.lock(0.2);
			
		}

    }

	@u function optionWindowDeleter(entity:Entity,uoc:UIOptionComponent){

		if(uoc.id == optionSelect){
			uoc.isSelected = true;
		}
		
		if(uoc.id != optionSelect){
			uoc.isSelected = false;
		}

		if(state == ExecutionState.WaitingForContinue && previousState ==  ExecutionState.WaitingOnOptionSelection){
			var isDied = new IsDiedFlag();
			entity.add(isDied);
		}

	}

    
}


class DialogText {
	
	var storage = new MemoryVariableStore();
	public var dialogue:Dialogue;
	var stringTable:Map<String, StringInfo>;
	var testPlan:Navigator;
	public var optionCount:Int = 0 ;
	
	public function new(yarnFile:String, ?testPlanFile:String = null) {
		
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

	public function logDebugMessage(message:String):Void {
		//trace('DEBUG: $message');
	}

	public function logErrorMessage(message:String):Void {
		//trace('Error: $message');
	}
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

	public function commandHandler(command:Command) {
		trace('Command: ${command.text}');
	}

	public function nodeCompleteHandler(nodeName:String) {}

	public function nodeStartHandler(nodeName:String) {}

	public function dialogueCompleteHandler() {
		trace("current dialogue end");
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
