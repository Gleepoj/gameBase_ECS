package aleiiioa.builders;


import aleiiioa.components.flags.PlayerFlag;
import aleiiioa.components.flags.PNJFlag;
import aleiiioa.components.flags.collision.BodyFlag;
import aleiiioa.components.core.collision.CollisionsListener;
import h3d.Vector;
import echoes.Entity;

import aleiiioa.components.InputComponent;
import aleiiioa.components.flags.hierarchy.ChildFlag;

import aleiiioa.components.core.dialog.*;
import aleiiioa.components.core.camera.*;
import aleiiioa.components.core.rendering.*;
import aleiiioa.components.core.velocity.*;
import aleiiioa.components.core.position.*;

import aleiiioa.components.dialog.*;


class Builders {    

    public static function pnj(cx:Int,cy:Int,yarnDialogName:String) {
        var pos = new GridPosition(cx,cy);
        var spr = new SpriteComponent(D.tiles.fxCircle15);
        var sq  = new SquashComponent();
        var vas = new VelocityAnalogSpeed();
        var se  = new SpriteExtension();
        var vc  = new VelocityComponent();
        var pnj = new PNJFlag();
        var cl   = new CollisionsListener();
        var bflag = new BodyFlag();
        var yarn = new DialogReferenceComponent(yarnDialogName,pos.attachX,pos.attachY);
        
        se.baseColor = new Vector(0.3,0.8,0.6);
        
        new echoes.Entity().add(pos,spr,se,sq,vc,vas,pnj,cl,bflag,yarn);
    }

    public static function player(cx:Int,cy:Int) {
        var pos = new GridPosition(cx,cy);
        var spr = new SpriteComponent(D.tiles.fxCircle15);
        var sq  = new SquashComponent();
        var se  = new SpriteExtension();
        var vc  = new VelocityComponent();
        var vas = new VelocityAnalogSpeed();
        var cl    = new CollisionsListener();
        var bflag = new BodyFlag();
        var player = new PlayerFlag();
        var inp = new InputComponent();
        
        se.baseColor = new Vector(0.9,0.2,0.6);

        new echoes.Entity().add(pos,spr,sq,se,vas,vc,inp,cl,bflag,player);
    }


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

