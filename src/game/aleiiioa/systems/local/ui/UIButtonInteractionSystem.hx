package aleiiioa.systems.local.ui;

import echoes.View;

import h2d.ScaleGrid;
import h2d.Interactive;

import aleiiioa.components.core.input.InputComponent;
import aleiiioa.components.core.physics.position.GridPosition;

import aleiiioa.components.local.ui.UISelectorFlag;
import aleiiioa.components.local.ui.algo.On_Targeted_Selectable;
import aleiiioa.components.local.ui.algo.Currently_Hovered;
import aleiiioa.components.local.ui.UISignalPressSelect;
import aleiiioa.components.local.ui.UIButton;
import aleiiioa.components.local.ui.UISignal_OnNext;
import aleiiioa.components.local.ui.UISignal_OnPrevious;
import aleiiioa.components.local.ui.UISignal_OnUndefined;


class UIButtonInteractionSystem extends echoes.System {
    var inputAnyKey:Bool = false;
    
    var PREVIOUSLY_SELECTED:View<Currently_Hovered>;

    public function new (){
 
    }
    @a function addButtonFunction(en:echoes.Entity,b:UIButton){
        
        switch b.event {
            case GameState_Play : b.embedded_function =  function(){Aleiiioa.ME.startPlay();};
            case GameState_Load : b.embedded_function =  function(){Aleiiioa.ME.startPlay();};
            case GameState_Quit : b.embedded_function =  function(){App.ME.exit();};
            case GameState_Menu : b.embedded_function =  function(){Aleiiioa.ME.goToMenu();};
            case GameState_Save : 
            case GameState_Settings :b.embedded_function = function(){Aleiiioa.ME.goToSetting();};
            case Order_Next     : b.embedded_function = function(){ en.add(new UISignal_OnNext());};
            case Order_Previous : b.embedded_function = function(){ en.add(new UISignal_OnPrevious());};
            case Order_Undefined: b.embedded_function = function(){ en.add(new UISignal_OnUndefined());}
        }
    }

    @a function bitbol(u:UISignal_OnNext){
        trace("next");
    }

    @a function addButtonInteractive(en:echoes.Entity,u:UIButton,gp:GridPosition,sc:ScaleGrid){
        
        u.interactive = new Interactive(sc.width,sc.height,sc);
   
        u.interactive.onOver = function(_) {
            clearCurrentlySelected();
            en.add(new On_Targeted_Selectable());
        }

        u.interactive.onClick = function(_){
            en.add(new UISignalPressSelect());
        }
    }
    
    @u function padPressSelct(inp:InputComponent,selector:UISelectorFlag){
        if(inp.ca.isPressed(ActionX) && !inp.cd.has("select")){
            inputAnyKey = true;
            inp.cd.setMs("select",100);
        }
    }

    @u function orderPadInput(en:echoes.Entity,b:UIButton,on:Currently_Hovered){
        if(inputAnyKey){
            en.add(new UISignalPressSelect());
            inputAnyKey = false;
        }
    }

    @u function triggerButtonFunction(b:UIButton,addOnClick:UISignalPressSelect){
        b.embedded_function();
    }
        
    function clearCurrentlySelected(){

        var head = PREVIOUSLY_SELECTED.entities.head;

        while(head != null){
            var en = head.value;
            en.remove(Currently_Hovered);
            head = head.next;
        }
        
    }

}