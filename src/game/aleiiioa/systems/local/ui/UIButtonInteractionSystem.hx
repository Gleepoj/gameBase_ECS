package aleiiioa.systems.local.ui;

import aleiiioa.components.core.input.InputComponent;
import aleiiioa.components.local.ui.Alg_CurrentlySelected;
import aleiiioa.components.local.ui.On_UISelectInput;
import aleiiioa.components.local.ui.UIButton;
import dn.Cooldown;
import aleiiioa.components.local.ui.UISelectorFlag;

class UIButtonInteractionSystem extends echoes.System {
    var inputAnyKey:Bool = false;
    var cd:dn.Cooldown = new Cooldown(Const.FIXED_UPDATE_FPS);

    public function new (){
 
    }

    @u function selectorInteract(inp:InputComponent,selector:UISelectorFlag){
        if(inp.ca.isPressed(ActionX) && cd.has("select")){
            inputAnyKey == true;
            cd.setMs("select",100);
        }
    }

    @u function updateSystem(dt:Float){
        cd.update(dt);
    }

    @u function UIPadInput(en:echoes.Entity,b:UIButton,on:Alg_CurrentlySelected){
        if(inputAnyKey){
            en.add(new On_UISelectInput());
            inputAnyKey = false;
        }
    }

    @u function UIButtonUpdate(b:UIButton,addOnClick:On_UISelectInput){
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

}