package aleiiioa.builders;


//import aleiiioa.components.flags.vessel.VvehiculeFlag;
import h3d.Vector;
import aleiiioa.components.core.camera.FluidScrollerComponent;
import aleiiioa.components.tool.PerlinNoiseComponent;
import aleiiioa.components.solver.SolverUVComponent;
import echoes.Entity;

import aleiiioa.components.InputComponent;
import aleiiioa.components.flags.hierarchy.ChildFlag;
import aleiiioa.shaders.PressureShader.BitmapShader;

import aleiiioa.components.core.collision.*;
import aleiiioa.components.core.camera.*;
import aleiiioa.components.core.rendering.*;
import aleiiioa.components.core.velocity.*;
import aleiiioa.components.core.position.*;

import aleiiioa.components.solver.*;
import aleiiioa.components.gun.*;
import aleiiioa.components.vehicule.*;


import aleiiioa.components.flags.hierarchy.*;
import aleiiioa.components.flags.collision.*;
import aleiiioa.components.flags.vessel.*;



class Builders {
    
////////ACTORS////////////////
    public static function basicModifier(cx:Int,cy:Int,areaEq:AreaEquation) {
        var pos  = new GridPosition(cx,cy);
        var fpos = new FluidPosition(cx,cy);
        var spr  = new SpriteComponent(D.tiles.Square);
        var se   = new SpriteExtension();
        var mod  = new ModifierComponent();
        var per  = new PerlinNoiseComponent();
        mod.areaEquation = areaEq;
        
        new echoes.Entity().add(pos,fpos,spr,se,mod,per);
    }

    

    public static function basicPlayer(cx:Int,cy:Int) {
        //Shared Component
        var mpos      = new MasterGridPosition(cx,cy);
        var tpos      = new TargetGridPosition(cx,cy-2);
        var paddle_sh = new PaddleSharedComponent();
        var inp       = new InputComponent();
        
        //Individual Component
        var pos   = new GridPosition(mpos.cx,mpos.cy);
        var fpos  = new FluidPosition(mpos.cx,mpos.cy);
        var suv   = new SolverUVComponent();
        var bb    = new BoundingBox();

        var se   = new SpriteExtension();
        var spr  = new SpriteComponent(D.tiles.kayak);
        spr.pivot.setCenterRatio(0.5,0.5);
        
        var vc   = new VelocityComponent();
        var sw   = new SteeringWheel();
        sw.windSensitivity = 0 ; 
        var cl   = new CollisionsListener();

        var fl_pl  = new PlayerFlag();
        var fl_mst = new MasterFlag();
        var fl_bo  = new BodyFlag();
       
        var player = new echoes.Entity().add(mpos,fpos,tpos,pos,suv,paddle_sh,spr,inp,se,bb,vc,sw,cl,fl_pl,fl_mst,fl_bo);
       
        //Paddle
        
        var pos_pad    = new GridPosition(mpos.cx,mpos.cy);
        var offpos_pad = new GridPositionOffset(0,0);
        offpos_pad.setXYratio(0,-1.5);
        
        var spr_pad  = new SpriteComponent(D.tiles.pagaye);
        var se_pad   = new SpriteExtension();
        
        var fl_ch_pad = new ChildFlag();
       
        new echoes.Entity().add(mpos,paddle_sh,pos_pad,offpos_pad,spr_pad,se_pad,fl_ch_pad);

        //debug vector 
        //DESIRED//
        var v_pos = new GridPosition(mpos.cx,mpos.cy);
        var v_opod = new GridPositionOffset(0,0);

        var v_spr  = new SpriteComponent(D.tiles.fxTail0);
        v_spr.setCenterRatio(0,0.5);
        var v_se   = new SpriteExtension();
        v_se.baseColor = new Vector(1,0,0);
        var v_ch = new ChildFlag();
        var debug_fl = new DebugVectorFlag();
        var desired_fl = new VdesiredFlag();

        new echoes.Entity().add(mpos,v_pos,v_opod,v_spr,v_se,v_ch,sw,debug_fl,desired_fl);

        //DESIRED//
        var v2_pos = new GridPosition(mpos.cx,mpos.cy);
        var v2_opod = new GridPositionOffset(0,0);

        var v2_spr  = new SpriteComponent(D.tiles.fxTail0);
        v2_spr.setCenterRatio(0,0.5);
        var v2_se   = new SpriteExtension();
        v2_se.baseColor = new Vector(1,1,0);
        var v2_ch = new ChildFlag();
        var v2_debug_fl = new DebugVectorFlag();
        var v2_steering_fl = new VsteeringFlag();

        new echoes.Entity().add(mpos,v2_pos,v2_opod,v2_spr,v2_se,v2_ch,sw,v2_debug_fl,v2_steering_fl);

        //Other//
        var v1_pos = new GridPosition(mpos.cx,mpos.cy);
        var v1_opod = new GridPositionOffset(0,0);

        var v1_spr  = new SpriteComponent(D.tiles.fxTail0);
        v1_spr.setCenterRatio(0,0.5);
        var v1_se   = new SpriteExtension();
        v1_se.baseColor = new Vector(1,0,1);
        var v1_ch = new ChildFlag();
        var v1_debug_fl = new DebugVectorFlag();
        var v1_steering_fl = new VvehiculeFlag();

        new echoes.Entity().add(mpos,v1_pos,v1_opod,v1_spr,v1_se,v1_ch,sw,v1_debug_fl,v1_steering_fl);
        
        // steering target 
/*      var tar_gp    = new GridPosition(tpos.cx,tpos.cy);
        var tar_spr   = new SpriteComponent(D.tiles.fxCircle15);
        var tar_se    = new SpriteExtension();
        var tar_vc    = new VelocityComponent();
        var tar_vas   = new VelocityAnalogSpeed();
        var tar_flag  = new TargetedFlag();
        var tar_sflag = new SteeringPointFlag();

         */
        
        
        //new echoes.Entity().add(tpos,paddle_sh,tar_spr,tar_gp,tar_vas,tar_vc,tar_se,tar_flag,tar_sflag);
        //new echoes.Entity().add(tpos,paddle_sh,tar_gp,tar_vas,tar_vc,tar_se,tar_flag,tar_sflag);
        return player;
    }

    public static function basicHunter(cx:Int,cy:Int,path:Array<ldtk.Point>,sec:Int) {
        
        var pos = new GridPosition(cx,cy);
        var spr = new SpriteComponent(D.tiles.fxCircle15);
        var se  = new SpriteExtension();
        var vc  = new VelocityComponent();
        var bb  = new BoundingBox();
       
        var sw   = new SteeringWheel();
        var suv  = new SolverUVComponent();
        var cl   = new CollisionsListener();

      /*   var mod  = new ModifierComponent();
        mod.areaEquation = EqConverge; */
       
        var tflag = new SpawnTimeComponent(sec);
        var flag  = new VesselFlag();
        var bflag = new BodyFlag();
        
        new echoes.Entity().add(pos,spr,se,vc,bb,sw,suv,cl,flag,tflag,bflag);
    }

    public static function basicElement(cx:Int,cy:Int,sec:Int) {
        var pos = new GridPosition(cx,cy);
        var spr = new SpriteComponent(D.tiles.fxCircle15);
        var se  = new SpriteExtension();
        var vc  = new VelocityComponent();
       
        var sw   =  new SteeringWheel();
        var suv  =  new SolverUVComponent();
        var cl   =  new CollisionsListener();
        
        var tflag = new SpawnTimeComponent(sec);
        var flag  = new VesselFlag();
        var bflag = new BodyFlag();
        
        new echoes.Entity().add(pos,spr,se,vc,sw,suv,cl,flag,tflag,bflag);
    }


    public static function layerComponent(shader:BitmapShader) {
        var layer = new LayerComponent(shader);
        new echoes.Entity().add(layer);
    }

    public static function solverCell(i:Int,j:Int,index:Int) {
        var cc = new CellComponent(i,j,index);
        var gp = new GridPosition(i,j,0.5,0.5);
        var vc = new VelocityComponent();
        var vas = new VelocityAnalogSpeed();
        new echoes.Entity().add(cc,gp,vc,vas);
    }

    public static function fluidScroller(cx:Int,cy:Int) {
        var scr = new FluidScrollerComponent();
        var gp  = new GridPosition(cx,cy);
        var fluidScroller = new echoes.Entity().add(scr,gp);
        return fluidScroller;
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

