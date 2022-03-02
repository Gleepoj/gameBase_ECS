package aleiiioa.builders;

import aleiiioa.components.flags.hierarchy.ChildFlag;
import aleiiioa.components.flags.hierarchy.MasterFlag;
import aleiiioa.shaders.PressureShader.BitmapShader;

import aleiiioa.components.*;
import aleiiioa.components.core.*;
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
        var pos   = new GridPosition(mpos.cx,mpos.cy);

        var se   = new SpriteExtension();
        var spr  = new SpriteComponent(D.tiles.Square);
        
        var vc   = new VelocityComponent();
        var vas  = new VelocityAnalogSpeed();
        var bb   = new BoundingBox();
       
        var mod  = new ModifierComponent();
        var inp  = new InputComponent();
        
        var gun  = new GunComponent(true);
        var cl   = new CollisionsListener();

        var flag  = new PlayerFlag();
        var mflag = new MasterFlag();
        var tflag = new TargetedFlag();
        var bflag = new BodyFlag();
       
        new echoes.Entity().add(mpos,tpos,pos,spr,se,vc,bb,mod,inp,vas,gun,flag,mflag,cl,bflag,tflag);

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
        var veflag = new VeilFlag();
        
        new echoes.Entity().add(mpos,tpos,pos2,spr2,se2,vc,off,cl2,flag2,gun2,inp,sw2,vc2,bflag2,veflag);
        
        var spr3  = new SpriteComponent(D.tiles.fxCircle15);
        var se3   = new SpriteExtension();
        var pos3  = new GridPosition(mpos.cx,mpos.cy);
        var off   = new GridPositionOffset(-1,1);

        var cl3   = new CollisionsListener();
        var gun3  = new GunComponent(true);

        var flag3  = new PlayerFlag();
        var bflag3 = new BodyFlag();
        var cflag2 = new ChildFlag();
        
        new echoes.Entity().add(mpos,pos3,spr3,se3,vc,off,cl3,gun3,inp,bflag3,cflag2);
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

    public static function basicObject(cx,cy) {
        var spr = new SpriteComponent(D.tiles.fxCircle15);
        var se  = new SpriteExtension();
        var pos = new GridPosition(cx,cy);
        var bb  = new BoundingBox();
        var vc  = new VelocityComponent();
        var sw  = new SteeringWheel();
        new echoes.Entity().add(spr,se,pos,bb,vc,sw);
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