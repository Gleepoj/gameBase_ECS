package aleiiioa.builders.entity;


import aleiiioa.components.logic.interaction.InteractionListener;
import aleiiioa.components.core.physics.collision.affects.*;
import aleiiioa.components.core.physics.velocity.body.*;
import aleiiioa.components.logic.interaction.catching.CatchableCollection;
import aleiiioa.components.logic.interaction.catching.Catcher;

import aleiiioa.components.core.physics.position.flags.MasterPositionFlag;
import aleiiioa.components.logic.object.BombComponent;

import h3d.Vector;
import echoes.Entity;

import aleiiioa.components.core.input.InputComponent;
import aleiiioa.components.flags.logic.*;
import aleiiioa.components.logic.*;
import aleiiioa.components.logic.qualia.*;

import aleiiioa.components.local.particules.*;
import aleiiioa.components.local.dialog.*;
import aleiiioa.components.local.dialog.flag.*;

import aleiiioa.components.utils.camera.*;
import aleiiioa.components.core.rendering.*;
import aleiiioa.components.core.physics.velocity.*;
import aleiiioa.components.core.physics.position.*;
import aleiiioa.components.core.physics.collision.*;

class CoreEntity { 
       
    public static function cameraFocus(cx:Int,cy:Int) {
        
        var pos  = new GridPosition(cx,cy);
        var vas = new AnalogSpeedComponent(0,0);
        var vc  = new VelocityComponent();


        var spr = new SpriteComponent(D.tiles.Square);
        var se  = new SpriteExtension();
        se.baseColor = new Vector(1,0,0,1);
    
        
        var foc = new CameraFocusComponent();
        vas.ySpeed = foc.cameraScrollingSpeed;

        var focus = new echoes.Entity().add(foc,pos,vas,vc,spr,se);
        return focus;
    }
   
}
