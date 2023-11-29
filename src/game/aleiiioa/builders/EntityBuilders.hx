package aleiiioa.builders;


import aleiiioa.components.logic.interaction.catching.CatchableCollection;
import aleiiioa.components.logic.interaction.catching.Catcher;

import aleiiioa.components.core.position.flags.MasterPositionFlag;
import aleiiioa.components.logic.BombComponent;

import h3d.Vector;
import echoes.Entity;

import aleiiioa.components.core.input.InputComponent;
import aleiiioa.components.flags.logic.*;
import aleiiioa.components.logic.*;
import aleiiioa.components.logic.qualia.*;

import aleiiioa.components.particules.*;
import aleiiioa.components.dialog.*;
import aleiiioa.components.dialog.flag.*;

import aleiiioa.components.camera.*;
import aleiiioa.components.core.rendering.*;
import aleiiioa.components.core.physics.*;
import aleiiioa.components.core.position.*;
import aleiiioa.components.core.collision.*;




class EntityBuilders {    

    public static function pnj(cx:Int,cy:Int,yarnDialogName:String) {
        //Physics Component
        var pos = new GridPosition(cx,cy);
        var vas = new VelocityAnalogSpeed(0,0);
        var vc  = new VelocityComponent(true);
        var cl  = new CollisionsListener();
        
        //Rendering Component
        var spr = new SpriteComponent(D.tiles.fxCircle15);
        var sq  = new SquashComponent();
        var se  = new SpriteExtension();
        se.baseColor = new Vector(0.3,0.8,0.6);

        //Logic and Dialog Component
        //var ic    = new InteractiveComponent();
        var em    = new EmitterComponent();
        var yarn  = new DialogReferenceComponent(yarnDialogName,pos.attachX,pos.attachY);
        
        //Flags
        var pnj   = new PNJDialogFlag();
        //var body  = new BodyFlag();   
        var catchable = new CatchableCollection();
        
        
        new echoes.Entity().add(pos,vas,vc,cl,spr,sq,se,em,yarn,pnj,catchable);
        // Uncomment next entity creation and comment previous one to remove catchable behavior 
        // new echoes.Entity().add(pos,vas,vc,cl,spr,sq,se,ic,em,yarn,pnj,body);
    }

    public static function chouxPeteur(cx:Int,cy:Int) {

        //Physics Component
        var pos = new GridPosition(cx,cy);
        var vas = new VelocityAnalogSpeed(0,0);
        var vc  = new VelocityComponent(true);
        var cl  = new CollisionsListener();
        
        //Rendering Component
        var spr = new SpriteComponent(D.tiles.fxCircle15);
        var sq  = new SquashComponent();
        var se  = new SpriteExtension();
        se.baseColor = new Vector(0.3,0.2,0.8);

        //Logic and Dialog Component
        var ic    = new BombComponent();
        var em    = new EmitterComponent();
        
        //Flags
       // var body = new BodyFlag(); 
        //var bomb = new BombFlag();
        var catchable = new CatchableCollection();
        
        
        new echoes.Entity().add(pos,vas,vc,cl,spr,sq,ic,se,em,catchable);
    }

    public static function player(cx:Int,cy:Int) {
        
        //Physics Component
        var pos = new GridPosition(cx,cy);
        var vas = new VelocityAnalogSpeed(0,0);
        var vc  = new VelocityComponent(true);
        var cl  = new CollisionsListener();
        
        //Hierarchy Component and Flag (to attach any entity depending on player position)
        var mpos   = new MasterGridPosition(cx,cy);
        var master = new MasterPositionFlag();

        //Rendering Component
        var spr = new SpriteComponent(D.tiles.fxCircle15);
        var sq  = new SquashComponent();
        var se  = new SpriteExtension();
        se.baseColor = new Vector(0.5,0.2,0.6);

        //Logic and Dialog Component
        //var ic = new InteractiveComponent();
        var em = new EmitterComponent();
        //var ac = new ActionComponent();
        var inp= new InputComponent();
        
        //Flags
        //var body   = new BodyFlag();  
        var catcher   = new Catcher(); 

        var player  = new PlayerFlag();
        var speaker = new PlayerDialogFlag();

        
        new echoes.Entity().add(pos,vas,vc,cl,mpos,spr,sq,se,em,inp,player,master,speaker,catcher);
    }

    
    public static function cameraFocus(cx:Int,cy:Int) {
        
        var pos  = new GridPosition(cx,cy);
        var vas = new VelocityAnalogSpeed(0,0);
        var vc  = new VelocityComponent(false,true);


        var spr = new SpriteComponent(D.tiles.Square);
        var se  = new SpriteExtension();
        se.baseColor = new Vector(1,0,0,1);
    
        
        var foc = new CameraFocusComponent();
        vas.ySpeed = foc.cameraScrollingSpeed;

        var focus = new echoes.Entity().add(foc,pos,vas,vc,spr,se);
        return focus;
    }

}

