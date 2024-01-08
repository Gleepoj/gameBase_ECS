package aleiiioa.builders.entity.topdown;

import dn.FileTools;
import sys.FileSystem;
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

class TopDownEntity {    

    public static function pnj(cx:Int,cy:Int,filepath:String) {
        //Physics Component
        var pos = new GridPosition(cx,cy);
        var vas = new AnalogSpeedComponent(0,0);
        var vc  = new VelocityComponent();
        var cl  = new CollisionSensor();
        
        //Rendering Component
        var spr = new SpriteComponent(D.tiles.fxCircle15);
        var sq  = new SquashComponent();
        var se  = new SpriteExtension();
        se.baseColor = new Vector(0.3,0.8,0.6);

        //Logic and Dialog Component
        //var ic    = new InteractiveComponent();
        var em    = new EmitterComponent();
        var il    = new InteractionListener();
     
      

        var yarn  = new DialogReferenceComponent(filepath,pos.attachX,pos.attachY);
        
        //Flags
        var pnj   = new PNJDialogFlag();
        //var body  = new BodyFlag();   
        var kinematic = new KinematicBodyFlag();
        
        var f = new FrictionSensitiveAffects();
        var w = new CollisionLayer_Wall();

        var catchable = new CatchableCollection();
        
        
        new echoes.Entity().add(pos,vas,vc,cl,spr,sq,se,em,il,pnj,catchable,yarn,kinematic,f,w);
        // Uncomment next entity creation and comment previous one to remove catchable behavior 
        // new echoes.Entity().add(pos,vas,vc,cl,spr,sq,se,ic,em,yarn,pnj,body);
    }

    public static function chouxPeteur(cx:Int,cy:Int) {

        //Physics Component
        var pos = new GridPosition(cx,cy);
        var vas = new AnalogSpeedComponent(0,0);
        var vc  = new VelocityComponent();
        var cl  = new CollisionSensor();
        
        //Rendering Component
        var spr = new SpriteComponent(D.tiles.fxCircle15);
        var sq  = new SquashComponent();
        var se  = new SpriteExtension();
        se.baseColor = new Vector(0.3,0.2,0.8);

        //Logic and Dialog Component
        var il    = new InteractionListener();
        var ic    = new BombComponent();
        var em    = new EmitterComponent();
        
        //Flags
       // var body = new BodyFlag(); 
        //var bomb = new BombFlag();
        var kinematic = new KinematicBodyFlag();
        
        var f = new FrictionSensitiveAffects();
        //var w = new CollisionLayer_Wall();

        var catchable = new CatchableCollection();
        
        
        new echoes.Entity().add(pos,vas,vc,cl,spr,sq,il,ic,se,em,catchable,kinematic,f);
    }

    public static function player(cx:Int,cy:Int) {
        
        //Physics Component
        var pos = new GridPosition(cx,cy);
        var vas = new AnalogSpeedComponent(0,0);
        var vc  = new VelocityComponent();
        var cl  = new CollisionSensor();
        
        //Hierarchy Component and Flag (to attach any entity depending on player position)
        var mpos   = new MasterGridPosition(cx,cy);
        var master = new MasterPositionFlag();

        //Rendering Component
        var spr = new SpriteComponent(D.tiles.fxCircle15);
        var sq  = new SquashComponent();
        var se  = new SpriteExtension();
        se.sprScaleX = 2;
        se.sprScaleY = 4;
        //se.setScale(2);
        se.baseColor = new Vector(0.5,0.2,0.6);

        var bb  = new BoundingBox();

        var em = new EmitterComponent();
        var il    = new InteractionListener();
        var inp   = new InputComponent();
        
        //Ability
        var catcher   = new Catcher(); 
        
        //Physics
        var kinematic = new KinematicBodyFlag();
        var f = new FrictionSensitiveAffects();
        var w = new CollisionLayer_Wall();

        //Qualia
        var player  = new PlayerFlag();
        var speaker = new PlayerDialogFlag();
        //var camera  = new CameraFocusComponent();

        
        new echoes.Entity().add(pos,vas,vc,cl,mpos,bb,spr,sq,se,em,inp,il,player,master,speaker,catcher,kinematic,f,w);
    }

    


}

