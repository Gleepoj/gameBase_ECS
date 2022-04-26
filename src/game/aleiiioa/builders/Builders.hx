package aleiiioa.builders;

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
        var mpos  = new MasterGridPosition(cx,cy);
        var tpos  = new TargetGridPosition(cx,cy);
        var wi = new WingsSharedComponent();
        
        var inp   = new InputComponent();
        
        //Individual Component
        var pos   = new GridPosition(mpos.cx,mpos.cy);
        var suv   = new SolverUVComponent();
        var bb    = new BoundingBox();

        var se   = new SpriteExtension();
        var spr  = new SpriteComponent(D.tiles.fxCircle15);
        
        var vc   = new VelocityComponent();
        var sw   = new SteeringWheel();
        sw.windSensitivity = 0 ; 
        var gun  = new GunComponent(true);
        var cl   = new CollisionsListener();

        var fl_pl  = new PlayerFlag();
        var fl_mst = new MasterFlag();
        var fl_bo  = new BodyFlag();
       
        var player = new echoes.Entity().add(mpos,wi,pos,suv,spr,inp,se,bb,vc,sw,gun,cl,fl_pl,fl_mst,fl_bo);
        //Wing Master 
        
        var fl_wi_ms = new WingsMasterFlag();
        var fl_wi_ch = new ChildFlag();// for garbage collection
        
        new echoes.Entity().add(inp,wi,mpos,fl_wi_ms,fl_wi_ch);
        //Wing Left

        var pos_wl    = new GridPosition(mpos.cx,mpos.cy);
        var offpos_wl = new GridPositionOffset(0,0);
        //offpos_wl.setXYratio(0,0);
        
        var spr_wl  = new SpriteComponent(D.tiles.wing);
        var se_wl   = new SpriteExtension();
        se_wl.sprScaleY = -1;

        var fl_ch_wl = new ChildFlag();
        var fl_wi_wl = new WingLeftFlag();
        var dbl_angL = new DebugLabel();

        new echoes.Entity().add(mpos,wi,pos_wl,offpos_wl,spr_wl,se_wl,fl_ch_wl,fl_wi_wl,dbl_angL);

        //Wing right

        var pos_wr    = new GridPosition(mpos.cx,mpos.cy);
        var offpos_wr = new GridPositionOffset(0,0);
        //offpos_wr.setXYratio(0.5,-0.3);
        
        var spr_wr  = new SpriteComponent(D.tiles.wing);
        var se_wr   = new SpriteExtension();
        se_wr.sprScaleX = -1;
        se_wr.sprScaleY = -1;

        var fl_ch_wr = new ChildFlag();
        var fl_wi_wr = new WingRightFlag();
        var dbl_angR = new DebugLabel();
        new echoes.Entity().add(mpos,wi,pos_wr,offpos_wr,spr_wr,se_wr,fl_ch_wr,fl_wi_wr,dbl_angR);
        return player;
    }

    public static function basicHunter(cx:Int,cy:Int,path:Array<ldtk.Point>,sec:Int) {
        var pos = new GridPosition(cx,cy);
        var spr = new SpriteComponent(D.tiles.fxCircle15);
        var se  = new SpriteExtension();
        var vc  = new VelocityComponent();
        var bb  = new BoundingBox();
       
        var sw   = new SteeringWheel();
        var suv   = new SolverUVComponent();
        var path = new PathComponent(path);

        var gun  = new GunComponent(false);
        var cl   = new CollisionsListener();
      /*   var mod  = new ModifierComponent();
        mod.areaEquation = EqConverge; */
       
        var tflag = new SpawnTimeComponent(sec);
        var flag  = new VesselFlag();
        var bflag = new BodyFlag();
        
        new echoes.Entity().add(pos,spr,se,vc,bb,sw,suv,path,gun,cl,flag,tflag,bflag);
    }

    public static function basicElement(cx:Int,cy:Int,sec:Int) {
        var pos = new GridPosition(cx,cy);
        var spr = new SpriteComponent(D.tiles.fxCircle15);
        var se  = new SpriteExtension();
        var vc  = new VelocityComponent();
       
        var sw   = new SteeringWheel();
        var suv   = new SolverUVComponent();
        var cl   = new CollisionsListener();
        
        var tflag = new SpawnTimeComponent(sec);
        var flag  = new VesselFlag();
        var bflag = new BodyFlag();
        
        new echoes.Entity().add(pos,spr,se,vc,sw,suv,cl,flag,tflag,bflag);
    }

//////BULLET//////////////////////
    public static function ennemyBullet(gGp:GridPosition,gun:GunComponent) {
        var pos = new GridPosition(gGp.cx,gGp.cy,gGp.xr,gGp.yr);
        var spr = new SpriteComponent(D.tiles.fxCircle7);
        var se  = new SpriteExtension();
        var vc  = new VelocityComponent();

        var vas = new VelocityAnalogSpeed();
        var bul = new BulletComponent(gun);
        var flBody = new BodyFlag();
        var flag = new EnnemyFlag();
        
        new echoes.Entity().add(pos,spr,se,vc,vas,bul,flag,flBody);
    }

    public static function friendlyBullet(gGp:GridPosition,gun:GunComponent) {
        var pos = new GridPosition(gGp.cx,gGp.cy,gGp.xr,gGp.yr);
        var spr = new SpriteComponent(D.tiles.fxCircle7);
        var se  = new SpriteExtension();
        var vc  = new VelocityComponent();
        
        var vas = new VelocityAnalogSpeed();
        var bul = new BulletComponent(gun);
        var flag = new FriendlyFlag();  
        var flBody = new BodyFlag();
        
        new echoes.Entity().add(pos,spr,se,vc,vas,bul,flag,flBody);
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

