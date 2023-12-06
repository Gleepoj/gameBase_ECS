package aleiiioa.systems.local.ui;

import h2d.ScaleGrid;
import aleiiioa.components.core.physics.position.GridPosition;

class UIGridPositionActualizer extends echoes.System {
    public function new (){

    }

    @a function syncUIButton(gp:GridPosition,sc:ScaleGrid){
        var pos = sc.getAbsPos();
        gp.setPosPixel(pos.x,pos.y+sc.height/2);
    }
}