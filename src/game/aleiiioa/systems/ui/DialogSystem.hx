
package aleiiioa.systems.ui;


import aleiiioa.components.InputComponent;
import aleiiioa.components.core.collision.CollisionsListener;
import aleiiioa.components.core.dialog.DialogReferenceComponent;
import aleiiioa.components.flags.PNJFlag;
import aleiiioa.components.flags.PlayerFlag;
import echoes.View;

import aleiiioa.builders.UIBuild;
import aleiiioa.components.ui.UIDialogComponent;
import aleiiioa.components.ui.DialogComponent;
import aleiiioa.components.flags.collision.IsDiedFlag;
import aleiiioa.components.ui.UIOptionComponent;

import echoes.Entity;
import hxyarn.program.VirtualMachine.ExecutionState;

class DialogSystem extends echoes.System {
	
	var ALL_DIALOG_TEXT:View<DialogComponent>;

    var ca : ControllerAccess<GameAction>;
	var previousState :ExecutionState;
	var state : ExecutionState; // getters to add
	
	var optionSelect:Int;
	var selector:Int = 1;
	var dialogIsStreaming:Bool = false;

	var currentDialog:String = null;

    public function new() {
        ca = App.ME.controller.createAccess();
		ca.lockCondition = Game.isGameControllerLocked;

    }

	function clearDialog(){
		var head = ALL_DIALOG_TEXT.entities.head;
        head.value.destroy();
	}

	@u function getCurrentDialog(pnj:PNJFlag,yarn:DialogReferenceComponent,cl:CollisionsListener) {
		if(yarn.reference != currentDialog)
			if(cl.onArea)
				currentDialog = yarn.reference;

	}

	@u function updateSystem(p:PlayerFlag,cl:CollisionsListener,gameInput:InputComponent){
		if(cl.onArea){
			if(gameInput.ca.isPressed(Blow)){
				UIBuild.textDialog('$currentDialog');
				gameInput.ca.lock();
			}
		}

		if(!dialogIsStreaming){
			gameInput.ca.unlock();
			currentDialog = null;
		}
			
		
	}

	@a function onDialogAdded(dc:DialogComponent){
		
		if(ALL_DIALOG_TEXT.entities.head != ALL_DIALOG_TEXT.entities.tail)
			clearDialog();

		dc.start();
		state = dc.dialogue.get_executionState();
		previousState = state;
		optionSelect = 0;
		dialogIsStreaming = true;
	}


    @u function updateDialog(entity:echoes.Entity,dc:DialogComponent){
        
    	state = dc.dialogue.get_executionState();
		previousState = state;
		var maxSelector = dc.optionCount;

		optionSelect = selector-1;

        if(ca.isPressed(Blow)){
            if(dc.dialogue.isActive()){
				
				if(state == ExecutionState.WaitingForContinue)
					dc.dialogue.resume();

				if(state == ExecutionState.WaitingOnOptionSelection){
					dc.dialogue.setSelectedOption(optionSelect);
					state = dc.dialogue.get_executionState();
					dc.dialogue.resume();
					selector = 1; 
				}
				
               
			}
        }
		
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

		if(dc.isComplete == true)
			entity.add(new IsDiedFlag());
		
		//handle selector skip bug 
		if(selector < 1 || selector > maxSelector )
			selector = 1;
    }

	@r function onDialogRemove(dc:DialogComponent){
		dialogIsStreaming = false;
	}
	
	@u function bubbleWindowUpdate(entity:Entity,udc:UIDialogComponent){
		if(!dialogIsStreaming)
			entity.add(new IsDiedFlag());
	}

	@u function optionWindowUpdate(entity:Entity,uoc:UIOptionComponent){

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

