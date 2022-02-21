package aleiiioa.builders;

import aleiiioa.components.vehicule.GunComponent;
import aleiiioa.components.vehicule.PathComponent;
import aleiiioa.components.vehicule.SteeringWheel;
import aleiiioa.shaders.PressureShader.BitmapShader;
import aleiiioa.components.*;
import aleiiioa.components.core.*;
import aleiiioa.components.solver.*;


class Builders {
    
    public static function basicObject(cx,cy) {
        var spr = new SpriteComponent();
        var se  = new SpriteExtension();
        var pos = new GridPosition(cx,cy);
        var bb  = new BoundingBox();
        var vc  = new VelocityComponent();
        var sw  = new SteeringWheel();
        new echoes.Entity().add(spr,se,pos,bb,vc,sw);
    }

    public static function bullet(gGp:GridPosition,angle:Float,speed:Float) {
        var spr = new SpriteComponent();
        var se  = new SpriteExtension();
        var pos = new GridPosition(gGp.cx,gGp.cy,gGp.xr,gGp.yr);
        var bb  = new BoundingBox();
        var vc  = new VelocityComponent();
        var vas = new VelocityAnalogSpeed();
        var bul = new BulletComponent(angle,speed);
        new echoes.Entity().add(spr,se,pos,bb,vc,vas,bul);
    }
    public static function basicHunter(cx:Int,cy:Int,path:Array<ldtk.Point>) {
        var spr = new SpriteComponent();
        var se  = new SpriteExtension();
        var pos = new GridPosition(cx,cy);
        var bb  = new BoundingBox();
        var vc  = new VelocityComponent();
        var sw  = new SteeringWheel();
        var path = new PathComponent(path);
        var gun = new GunComponent(false);
        new echoes.Entity().add(spr,se,pos,bb,vc,sw,path,gun);
    }

    public static function basicPlayer(cx:Int,cy:Int) {
        var pos  = new GridPosition(cx,cy);
        var mod  = new ModifierComponent();
        var vc   = new VelocityComponent();
        var vas  = new VelocityAnalogSpeed();
        var spr  = new SpriteComponent();
        var se   = new SpriteExtension();
        var inp  = new InputComponent();
        var gun  = new GunComponent(true);
    
        new echoes.Entity().add(pos,mod,vc,spr,se,inp,vas,gun);
    }

    public static function pointDebugger(cx:Int,cy:Int,endPoint:Bool) {
        var spr = new SpriteComponent();
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