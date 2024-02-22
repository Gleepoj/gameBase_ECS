package aleiiioa.systems.local.ui;

import h3d.Vector4;
import h2d.ScaleGrid;

import aleiiioa.components.local.ui.algo.Currently_Hovered;
import aleiiioa.components.core.physics.position.GridPosition;

class UIGridPositionActualizer extends echoes.System {
    public function new (){
    }

    @:a function syncUIButton(gp:GridPosition,sc:ScaleGrid){
        var pos = sc.getAbsPos();
        gp.setPosPixel(pos.x,pos.y+sc.height/2);
    }

    @:a function colorize(u:Currently_Hovered,s:ScaleGrid){
        s.color = new Vector4(0.7,0.3,0.3);
    }

    @:r function uncolorize(rem:Currently_Hovered,s:ScaleGrid){
        s.color = new Vector4(1,1,1);
    }

    @:r function removeSc(sc:ScaleGrid){
        sc.remove();
    }

}