package aleiiioa.systems.local.ui;

import aleiiioa.components.core.level.CameraBisComponent;
import h3d.Vector4;
import h2d.ScaleGrid;

import aleiiioa.components.local.ui.algo.Currently_Hovered;
import aleiiioa.components.core.physics.position.GridPosition;

class UIGridPositionActualizer extends echoes.System {
    
    var camera_center_attach_x:Float = 0.;
    var camera_center_attach_y:Float = 0.;

    public function new (){
    }
    @:a function getCameraCenter(cam:CameraBisComponent,gp:GridPosition){
        camera_center_attach_x = gp.attachX;
        camera_center_attach_y = gp.attachY;
    }
    @:a function syncUIButton(gp:GridPosition,sc:ScaleGrid){
        var pos = sc.getAbsPos();
        gp.setPosPixel(camera_center_attach_x-sc.width/2-10,pos.y+sc.height);
        //gp.setPosPixel(-sc.x,sc.y);
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