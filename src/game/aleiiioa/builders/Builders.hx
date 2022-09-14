package aleiiioa.builders;


import aleiiioa.components.logic.ActionComponent;
import aleiiioa.shaders.PressureShader.SmokeShader;
import h3d.Vector;
import echoes.Entity;

import aleiiioa.components.InputComponent;

import aleiiioa.components.flags.*;
import aleiiioa.components.flags.collision.*;

import aleiiioa.components.particules.*;
import aleiiioa.components.dialog.*;

import aleiiioa.components.core.camera.*;
import aleiiioa.components.core.rendering.*;
import aleiiioa.components.core.velocity.*;
import aleiiioa.components.core.position.*;
import aleiiioa.components.core.collision.*;



class Builders {    

    public static function pnj(cx:Int,cy:Int,yarnDialogName:String) {
        var pos = new GridPosition(cx,cy);
        var spr = new SpriteComponent(D.tiles.fxCircle15);
        var sq  = new SquashComponent();
        var vas = new VelocityAnalogSpeed(0,0);
        var se  = new SpriteExtension();
        var vc  = new VelocityComponent(true);
        var pnj = new PNJFlag();
        var cl   = new CollisionsListener();
        var bflag = new BodyFlag();
        var yarn = new DialogReferenceComponent(yarnDialogName,pos.attachX,pos.attachY);   
        var em     = new EmitterComponent();
        se.baseColor = new Vector(0.3,0.8,0.6);
        
        new echoes.Entity().add(pos,spr,se,sq,vc,vas,pnj,cl,bflag,yarn);
    }

    public static function chouxPeteur(cx:Int,cy:Int) {
        var pos = new GridPosition(cx,cy);
        var spr = new SpriteComponent(D.tiles.fxCircle15);
        var sq  = new SquashComponent();
        var se  = new SpriteExtension();
        var vc  = new VelocityComponent(true);
        var vas = new VelocityAnalogSpeed(0,0);
        var cl     = new CollisionsListener();
        var bflag  = new BodyFlag();
        var bomb   = new BombFlag();
        var em     = new EmitterComponent();
        
        se.baseColor = new Vector(0.3,0.2,0.8);
        
        new echoes.Entity().add(pos,spr,sq,se,vas,vc,cl,bflag,em,bomb);
    }

    public static function player(cx:Int,cy:Int) {
        var pos = new GridPosition(cx,cy);
        var spr = new SpriteComponent(D.tiles.fxCircle15);
        var sq  = new SquashComponent();
        var se  = new SpriteExtension();
        var vc  = new VelocityComponent(true);
        var vas = new VelocityAnalogSpeed(0,0);
        var cl     = new CollisionsListener();
        var bflag  = new BodyFlag();
        var player = new PlayerFlag();
        var inp    = new InputComponent();
        var em     = new EmitterComponent();
        var ac     = new ActionComponent();
        
        se.baseColor = new Vector(0.5,0.2,0.6);

        new echoes.Entity().add(pos,spr,sq,se,vas,vc,inp,cl,bflag,player,em,ac);
    }

    
    public static function cameraFocus(cx:Int,cy:Int) {
        
        var foc = new CameraFocusComponent();
        var gp  = new GridPosition(cx,cy);
        var spr = new SpriteComponent(D.tiles.Square);
        var se  = new SpriteExtension();
        se.baseColor = new Vector(0,0.3,1,1);
        var vas = new VelocityAnalogSpeed(0,0);
        var vc  = new VelocityComponent();

        vas.ySpeed = foc.cameraScrollingSpeed;
        var focus = new echoes.Entity().add(foc,gp,vas,vc,spr,se);
        return focus;
    }

}

