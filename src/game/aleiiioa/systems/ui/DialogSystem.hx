
package aleiiioa.systems.ui;


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
    public function new() {
        ca = App.ME.controller.createAccess();
		ca.lockCondition = Game.isGameControllerLocked;
        dial = new DialogText('res/yarn/Example.yarn');
        dial.start();
		//conf = ca.input.pad.config;
    }

    @u function updateDialog(){
        
        var state = dial.dialogue.get_executionState();

        if(ca.isPressed(Blow)){
            if(dial.dialogue.isActive() && state == ExecutionState.WaitingForContinue)
                dial.dialogue.resume();
           // var t  = dial.getComposedTextForLine(dial.);
           // UIBuild.dialog('$t',2);
        }

        if(ca.isPressed(Jump)){
            if(dial.dialogue.isActive() && state == ExecutionState.WaitingOnOptionSelection)
                dial.dialogue.setSelectedOption(0);
           // UIBuild.dialog("I am the fisrt",1);
        }
    }

    
}


class DialogText {
	var storage = new MemoryVariableStore();
	public var dialogue:Dialogue;
	var stringTable:Map<String, StringInfo>;
	var testPlan:Navigator;

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

		
		if (testPlanFile != null && StringTools.trim(testPlanFile).length > 0)
			testPlan = new Navigator(testPlanFile);

		var job = CompilationJob.createFromFiles([yarnFile], dialogue.library);
		var compilerResults = Compiler.compile(job);
		stringTable = compilerResults.stringTable;

		dialogue.addProgram(compilerResults.program);
	}

	public function start() {
		dialogue.setNode("Start");
        dialogue.resume();
/*      
		do {
			dialogue.resume();
		} while (dialogue.isActive()); */
	}

	function setUp(fileName:String) {}

	public function logDebugMessage(message:String):Void {
		trace('DEBUG: $message');
	}

	public function logErrorMessage(message:String):Void {
		trace('Error: $message');
	}
    // ovverride? 
	public function lineHandler(line:Line):HandlerExecutionType {
		var text = getComposedTextForLine(line);
		//trace('$text');
        
       
        UIBuild.dialog('$text',2);
        

		return HandlerExecutionType.ContinueExecution;
	}

	public function optionsHandler(options:OptionSet) {
		var optionCount = options.options.length;
		var optionText = new Array<String>();

		//trace("Options:");
		for (option in options.options) {
			var text = getComposedTextForLine(option.line);
			optionText.push(text);
            UIBuild.option('$text');
            //trace(' - $text');
		}

	}

	public function getComposedTextForLine(line:Line):String {
		var substitutedText = Dialogue.expandSubstitutions(stringTable[line.id].text, line.substitutions);

		var markup = dialogue.parseMarkup(substitutedText);

		return markup.text;
	}

	public function commandHandler(command:Command) {
		trace('Command: ${command.text}');

		if (testPlan != null) {
			testPlan.next();
			if (testPlan.nextExpectedType != StepType.Command) {
				throw new Exception('Recieved command ${command.text}, but wasn\'t expecting to select one (was expecting ${testPlan.nextExpectedType.getName()})');
			} else {
				assertString(testPlan.nextExpectedValue, command.text);
			}
		}
	}

	public function nodeCompleteHandler(nodeName:String) {}

	public function nodeStartHandler(nodeName:String) {}

	public function dialogueCompleteHandler() {
		if (testPlan != null) {
			testPlan.next();

			if (testPlan.nextExpectedType != StepType.Stop) {
				throw new Exception('Stopped dialogue,  but wasn\'t expecting to select one (was expecting ${testPlan.nextExpectedType.getName()})');
			}

			logDebugMessage('${testPlan.path} test passed!');
		}
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
