package aleiiioa.systems.local.ui;

import h3d.Vector4;
import h2d.ScaleGrid;

import aleiiioa.components.local.ui.algo.Currently_Hovered;
import aleiiioa.components.core.physics.position.GridPosition;
import aleiiioa.components.core.level.GameStateManager;
import aleiiioa.components.core.level.On_Resize_Event;

class UIGridPositionActualizer extends echoes.System {
    var reflow:Bool = false;
    public function new (){
        

    }

    @a function onAddResize(en:echoes.Entity, game:GameStateManager,add:On_Resize_Event){
        //wwid = window.width/2;
        //whei = window.height/2;
        //en.remove(On_Resize_Event);
        reflow = true;
        //trace("reflow UI ");

    }

    @u function requestReflow(flow:dn.heaps.FlowBg){
        if(reflow)
            flow.reflow();
        reflow = false;
    }

    @a function syncUIButton(gp:GridPosition,sc:ScaleGrid){
        var pos = sc.getAbsPos();
        gp.setPosPixel(pos.x,pos.y+sc.height/2);
    }

    @a function colorize(u:Currently_Hovered,s:ScaleGrid){
        s.color = new Vector4(0.7,0.3,0.3);
    }

    @r function uncolorize(rem:Currently_Hovered,s:ScaleGrid){
        s.color = new Vector4(1,1,1);
    }

    @r function removeSc(sc:ScaleGrid){
        sc.remove();
    }

}