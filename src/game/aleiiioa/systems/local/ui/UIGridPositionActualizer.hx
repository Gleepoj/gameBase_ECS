package aleiiioa.systems.local.ui;

import h3d.Vector;
import aleiiioa.components.core.rendering.SpriteComponent;
import aleiiioa.components.local.ui.Alg_CurrentlySelected;
import h2d.ScaleGrid;
import aleiiioa.components.core.physics.position.GridPosition;

class UIGridPositionActualizer extends echoes.System {
    public function new (){

    }

    @a function syncUIButton(gp:GridPosition,sc:ScaleGrid){
        var pos = sc.getAbsPos();
        gp.setPosPixel(pos.x,pos.y+sc.height/2);
    }

    @a function colorize(u:Alg_CurrentlySelected,s:ScaleGrid){
        s.color = new Vector(0.7,0.3,0.3);
        //trace("add");
    }

    @r function uncolorize(rem:Alg_CurrentlySelected,s:ScaleGrid){
        s.color = new Vector(1,1,1);
        //trace("rem");
    }

    
    @r function removeSc(sc:ScaleGrid){
        //sc.clear();
        sc.remove();
        //trace("clear scale grid");
    }
}