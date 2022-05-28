package aleiiioa.builders;


import h3d.Vector;
import echoes.Entity;

import aleiiioa.components.InputComponent;
import aleiiioa.components.flags.hierarchy.ChildFlag;
import aleiiioa.components.core.camera.*;
import aleiiioa.components.core.rendering.*;
import aleiiioa.components.core.velocity.*;
import aleiiioa.components.core.position.*;


class Builders {    

    public static function cameraFocus(cx:Int,cy:Int) {
        
        var foc = new CameraFocusComponent();
        var gp  = new GridPosition(cx,cy);
        var spr = new SpriteComponent(D.tiles.Square);
        var se  = new SpriteExtension();
        se.baseColor = new Vector(0,0.3,1,1);
        var vas = new VelocityAnalogSpeed();
        var vc  = new VelocityComponent();

        vas.ySpeed = foc.cameraScrollingSpeed;
        var focus = new echoes.Entity().add(foc,gp,vas,vc,spr,se);
        return focus;
    }

}

