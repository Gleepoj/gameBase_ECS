package aleiiioa.systems.local.ui.selector;

import echoes.View;
import h2d.ScaleGrid;
import aleiiioa.components.local.ui.UIButton;
import h2d.Interactive;
import aleiiioa.components.local.ui.InteractiveMouseComponent;
import aleiiioa.components.local.ui.On_UICurrentlySelected;
import aleiiioa.components.core.physics.position.GridPosition;
import aleiiioa.components.local.ui.UISelectorFlag;
import aleiiioa.components.local.ui.On_UITargetedObject;
import aleiiioa.components.core.physics.position.TransformPositionComponent;
import aleiiioa.components.core.rendering.*;
import aleiiioa.components.core.input.MouseComponent;


class MouseSystem extends echoes.System {
    var window = hxd.Window.getInstance();

    var onNewOver = false;
    var onOverInteractGp:GridPosition = new GridPosition(0,0,0,0);
    
    var mx:Int = 0;
    var my:Int = 0;

    var freeMove:Bool = false;

    var PREVIOUSLY_SELECTED:View<On_UICurrentlySelected>;

    public function new (){
    }


    @a function addButtonInteractive(en:echoes.Entity,interactive:InteractiveMouseComponent,u:UIButton,gp:GridPosition,spr:SpriteComponent,sc:ScaleGrid){
     
        interactive = new Interactive(sc.width,sc.height,sc);
   

        interactive.onOver = function(_) {
            clearCurrentlySelected();
            en.add(new On_UITargetedObject());
        }

        interactive.onOut = function(_){
            //sc.alpha = 1; 
        }
    }

    function clearCurrentlySelected(){
        // Remove On_UICurrentlySelected flag from PREVIOUSLY_SELECTED view
        var head = PREVIOUSLY_SELECTED.entities.head;

        while(head != null){
            var en = head.value;
            en.remove(On_UICurrentlySelected);
            head = head.next;
        }
    }

    @u function mouse_position_update(dt:Float,m:MouseComponent,gp:GridPosition,spr:SpriteComponent) {
        m.cd.update(dt);
        m.setLastPos(m.x,m.y);
        m.x = window.mouseX;
        m.y = window.mouseY;

        if(m.onMove && !m.cd.has("onMove"))
            m.cd.setMs("onMove",100);

        if(m.cd.has("onMove")){
            spr.colorize(0xff0000);
            freeMove = true;
        }

        if(!m.cd.has("onMove")){
            spr.uncolorize(); 
            freeMove = false;
        }

        gp.setPosPixel(m.x,m.y);      
    }
}