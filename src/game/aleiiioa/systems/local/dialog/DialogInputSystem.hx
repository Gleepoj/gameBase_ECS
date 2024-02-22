package aleiiioa.systems.local.dialog;

import aleiiioa.components.logic.interaction.InteractionListener;
import aleiiioa.components.local.dialog.YarnDialogListener;
import aleiiioa.components.core.physics.position.GridPosition;
import aleiiioa.components.core.input.InputComponent;
import aleiiioa.components.core.physics.collision.CollisionSensor;
import aleiiioa.components.local.dialog.DialogReferenceComponent;

import aleiiioa.components.local.dialog.flag.*;
import aleiiioa.components.logic.qualia.*;


import aleiiioa.builders.entity.local.UIBuilders;

import aleiiioa.components.local.dialog.YarnDialogConponent;

import echoes.Entity;
import hxyarn.program.VirtualMachine.ExecutionState;

class DialogInputSystem extends echoes.System {
	
    var ca : ControllerAccess<GameAction>;
	var previousState :ExecutionState;
	var state : ExecutionState; 

	var optionSelect:Int;
	var selector:Int = 1;
	var dialogIsStreaming:Bool = false;

	var currentDialog:DialogReferenceComponent = null;

    public function new() {
        ca = App.ME.controller.createAccess();
		ca.lockCondition = Game.isGameControllerLocked;

    }

	@:u function getCurrentDialog(pnj:PNJDialogFlag,yarn:DialogReferenceComponent,il:InteractionListener) {
		if(yarn != currentDialog)
			if(il.onArea)
				currentDialog = yarn;

	}

	@:u function updateSystem(p:PlayerDialogFlag,il:InteractionListener,gameInput:InputComponent,gp:GridPosition){
		if(il.onArea){
			if(gameInput.ca.isPressed(Interaction)){
				currentDialog.attachX = gp.attachX;
				currentDialog.attachY = gp.attachY;
				UIBuilders.dialogEntity(currentDialog);
				gameInput.ca.lock();
				ca.unlock();
			}
		}

		if(!dialogIsStreaming){
			gameInput.ca.unlock();
			ca.lock();
			currentDialog = null;
		}
				
	}

	@:a function onDialogAdded(dc:YarnDialogConponent){

		state = dc.dialogue.get_executionState();
		previousState = state;
		optionSelect = 0;
		dialogIsStreaming = true;
	}


    @:u function updateDialog(entity:echoes.Entity,dc:YarnDialogConponent,yl:YarnDialogListener){
        
    	state = dc.dialogue.get_executionState();
		previousState = state;
		
		var maxSelector = dc.optionCount;
		optionSelect = selector-1;
		yl.selector = optionSelect;
		
        if(ca.isPressed(Interaction)){
            if(dc.dialogue.isActive()){
				
				if(state == ExecutionState.WaitingForContinue)
					dc.dialogue.resume();

				if(state == ExecutionState.WaitingOnOptionSelection){
					dc.dialogue.setSelectedOption(optionSelect);
					state = dc.dialogue.get_executionState();
					dc.dialogue.resume();
					selector = 1; 
					yl.cd.setS("answer",0.1);
				}               
			}
        }
		
		if(ca.isDown(MoveLeft)){
			selector -=1;

			if(selector < 1)
				selector = 0;
			
			ca.unlock();
			ca.lock(0.12);
		}

		if(ca.isDown(MoveRight)){
			selector +=1;
			
			if(selector > maxSelector)
				selector = maxSelector;
			
			ca.unlock();
			ca.lock(0.12);	
		}
		
		//handle selector skip bug 
		if(selector < 1 || selector > maxSelector )
			selector = 1;

		// delete dialog if complete
		if(dc.isComplete == true)
			entity.add(new IsDiedFlag());
		
    }

	@:r function onDialogRemove(dc:YarnDialogConponent){
		dialogIsStreaming = false;
	}
	
}

