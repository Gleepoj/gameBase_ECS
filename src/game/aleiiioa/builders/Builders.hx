package aleiiioa.builders;

import aleiiioa.components.flags.hierarchy.ChildFlag;
import aleiiioa.components.flags.hierarchy.MasterFlag;
import aleiiioa.shaders.PressureShader.BitmapShader;

import aleiiioa.components.*;
import aleiiioa.components.core.*;
import aleiiioa.components.core.position.*;
import aleiiioa.components.solver.*;
import aleiiioa.components.flags.*;
import aleiiioa.components.vehicule.*;


class Builders {
    
////////ACTORS////////////////
    public static function basicModifier(cx:Int,cy:Int,areaEq:AreaEquation) {
        var pos  = new GridPosition(cx,cy);
        var spr  = new SpriteComponent(D.tiles.Square);
        var se   = new SpriteExtension();
        var mod  = new ModifierComponent();
        mod.areaEquation = areaEq;
        
        new echoes.Entity().add(pos,spr,se,mod);
    }

    public static function basicPlayer(cx:Int,cy:Int) {
        //Shared Component
        var mpos  = new MasterGridPosition(cx,cy);
        var tpos  = new TargetGridPosition(cx,cy);
        
        //Individual Component
        var pos   = new GridPosition(mpos.cx,mpos.cy);
        var suv   = new SUVatCoordComponent();
        var bb    = new BoundingBox();

        var se   = new SpriteExtension();
        var spr  = new SpriteComponent(D.tiles.Square);
        
        var vc   = new VelocityComponent();
        var sw   = new SteeringWheel(); 
        var gun  = new GunComponent(true);
        var cl   = new CollisionsListener();

        var fl_pl  = new PlayerFlag();
        var fl_mst = new MasterFlag();
        var fl_bo  = new BodyFlag();
       
        new echoes.Entity().add(mpos,tpos,pos,suv,spr,se,bb,vc,sw,gun,cl,fl_pl,fl_mst,fl_bo);
        //input satelitte child entity
        
        var veil  = new VeilComponent();
        var inp   = new InputComponent();
        var bb_v  = new BoundingBox();
        
        var spr_v  = new SpriteComponent(D.tiles.fxCircle15);
        var se_v   = new SpriteExtension();
        
        var pos_v   = new GridPosition(mpos.cx,mpos.cy);
        var off_v   = new GridPositionOffset(0,0);


        var cl_v   = new CollisionsListener();
        var dbl_v   = new DebugLabel();


        var fl_pl_v   = new PlayerFlag();
        var fl_bo_v   = new BodyFlag();
        var fl_ch_v   = new ChildFlag();
        var fl_veil   = new VeilFlag();
        var fl_tar    = new TargetedFlag();

        new echoes.Entity().add(mpos,tpos,suv,pos_v,spr_v,se_v,off_v,bb_v,cl_v,dbl_v,veil,inp,fl_pl_v,fl_bo_v,fl_ch_v,fl_veil,fl_tar);
    }

    public static function basicHunter(cx:Int,cy:Int,path:Array<ldtk.Point>,sec:Int) {
        var pos = new GridPosition(cx,cy);
        var spr = new SpriteComponent(D.tiles.fxCircle15);
        var se  = new SpriteExtension();
        var vc  = new VelocityComponent();
        var bb  = new BoundingBox();
       
        var sw   = new SteeringWheel();
        var path = new PathComponent(path);
        var gun  = new GunComponent(false);
        var cl   = new CollisionsListener();
       
        var tflag = new TimeFlag(sec);
        var flag  = new VesselFlag();
        var bflag = new BodyFlag();
        
        new echoes.Entity().add(pos,spr,se,vc,bb,sw,path,gun,cl,flag,tflag,bflag);
    }

//////BULLET//////////////////////
    public static function ennemyBullet(gGp:GridPosition,gun:GunComponent) {
        var pos = new GridPosition(gGp.cx,gGp.cy,gGp.xr,gGp.yr);
        var spr = new SpriteComponent(D.tiles.fxCircle7);
        var se  = new SpriteExtension();
        var vc  = new VelocityComponent();

        var vas = new VelocityAnalogSpeed();
        var bul = new BulletComponent(gun);
        var flag = new EnnemyFlag();
        
        new echoes.Entity().add(pos,spr,se,vc,vas,bul,flag);
    }

    public static function friendlyBullet(gGp:GridPosition,gun:GunComponent) {
        var pos = new GridPosition(gGp.cx,gGp.cy,gGp.xr,gGp.yr);
        var spr = new SpriteComponent(D.tiles.fxCircle7);
        var se  = new SpriteExtension();
        var vc  = new VelocityComponent();
        
        var vas = new VelocityAnalogSpeed();
        var bul = new BulletComponent(gun);
        var flag = new FriendlyFlag();  
        
        new echoes.Entity().add(pos,spr,se,vc,vas,bul,flag);
    }

    ////// Others //
    public static function pointDebugger(cx:Int,cy:Int,endPoint:Bool) {
        var spr = new SpriteComponent(D.tiles.fxDot);
        var se  = new SpriteExtension();
        var pos = new GridPosition(cx,cy);
        spr.colorize(0xefef00);
        if(endPoint)
            spr.colorize(0x00efef);
        se.sprScaleX = 0.5;
        se.sprScaleY = 0.5;
        return new echoes.Entity().add(spr,pos,se);
    }

    public static function layerComponent(shader:BitmapShader) {
        var layer = new LayerComponent(shader);
        new echoes.Entity().add(layer);
    }

    public static function solverCell(i:Int,j:Int,index:Int) {
        var cc = new CellComponent(i,j,index);
        new echoes.Entity().add(cc);
    }
}

/* // steer sat
var spr2  = new SpriteComponent(D.tiles.fxCircle15);
var se2   = new SpriteExtension();

var pos2  = new GridPosition(mpos.cx,mpos.cy);        
var off   = new GridPositionOffset(1,1);
var cl2   = new CollisionsListener();

var gun2  = new GunComponent(true);
var sw2   = new SteeringWheel();
var vc2   = new VelocityComponent();

var flag2  = new PlayerFlag();
var bflag2 = new BodyFlag();
var chflag = new ChildFlag();
 */
//new echoes.Entity().add(mpos,tpos,pos2,spr2,se2,vc,off,cl2,flag2,gun2,inp,sw2,vc2,bflag2,chflag);
