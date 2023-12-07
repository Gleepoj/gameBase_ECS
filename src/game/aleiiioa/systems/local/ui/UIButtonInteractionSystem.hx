package aleiiioa.systems.local.ui;
import echoes.View;
import h2d.ScaleGrid;
import h2d.Interactive;

import aleiiioa.components.local.ui.UIButton;

import aleiiioa.components.local.ui.algo.Currently_Hovered;
import aleiiioa.components.core.physics.position.GridPosition;
import aleiiioa.components.local.ui.UISelectorFlag;
import aleiiioa.components.local.ui.algo.On_Targeted_Selectable;
import aleiiioa.components.core.physics.position.TransformPositionComponent;
import aleiiioa.components.core.rendering.*;
import aleiiioa.components.core.input.MouseComponent;
import aleiiioa.components.local.ui.UISignalPressSelect;

import aleiiioa.components.core.input.InputComponent;
import aleiiioa.components.local.ui.algo.Currently_Hovered;
import aleiiioa.components.local.ui.UISignalPressSelect;
import aleiiioa.components.local.ui.UIButton;
import dn.Cooldown;
import aleiiioa.components.local.ui.UISelectorFlag;

class UIButtonInteractionSystem extends echoes.System {
    var inputAnyKey:Bool = false;
    
    var PREVIOUSLY_SELECTED:View<Currently_Hovered>;

    public function new (){
 
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

    @u function UIButtonUpdate(b:UIButton,addOnClick:UISignalPressSelect){
        interact(b.event);
    }

    function interact(button_event : UI_Button_Event){
        switch button_event{
            case GameState_Play : Aleiiioa.ME.startPlay();
            case GameState_Load : Aleiiioa.ME.startPlay();
            case GameState_Quit : App.ME.exit();
            case GameState_Menu : Aleiiioa.ME.goToMenu();
            case GameState_Save :
            case GameState_Settings : Aleiiioa.ME.goToSetting();
            case Order_Next:
            case Order_Previous:
            case Order_Undefined:
        }
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