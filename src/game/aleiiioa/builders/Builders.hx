package aleiiioa.builders;


import hxd.BitmapData;
import aleiiioa.components.core.*;
import aleiiioa.components.solver.*;

class Builders {
    
    public static function basicObject(cx,cy) {
        var spr = new SpriteComponent();
        var se  = new SpriteExtension();
        var pos = new GridPosition(cx,cy);
        var bb  = new BoundingBox(pos.attachX,pos.attachY);
        var vc  = new VelocityComponent();
        new echoes.Entity().add(spr,se,pos,bb,vc);
    }

    public static function bitmapComponent(bmpData:BitmapData,width:Int,height:Int) {
        var bmpComponent = new BitmapComponent(bmpData,width,height);
        new echoes.Entity().add(bmpComponent);
    }
}