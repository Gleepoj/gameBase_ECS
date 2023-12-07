package aleiiioa.systems.utils;

import aleiiioa.components.core.physics.position.GridPosition;
import aleiiioa.components.core.rendering.*;
import aleiiioa.components.core.input.MouseComponent;


class MouseSystem extends echoes.System {
    var window = hxd.Window.getInstance();
    var freeMove:Bool = false;

    public function new (){
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