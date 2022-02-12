package aleiiioa.builders;


import aleiiioa.systems.shaders.PressureShader.BitmapShader;
import hxd.BitmapData;
import aleiiioa.components.core.*;
import aleiiioa.components.solver.*;
import aleiiioa.systems.shaders.*;

class Builders {
    
    public static function basicObject(cx,cy) {
        var spr = new SpriteComponent();
        var se  = new SpriteExtension();
        var pos = new GridPosition(cx,cy);
        var bb  = new BoundingBox(pos.attachX,pos.attachY);
        var vc  = new VelocityComponent();
        new echoes.Entity().add(spr,se,pos,bb,vc);
    }

    public static function layerComponent(shader:BitmapShader) {
        var layer = new LayerComponent(shader);
        new echoes.Entity().add(layer);
    }
}