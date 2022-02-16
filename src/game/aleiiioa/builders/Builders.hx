package aleiiioa.builders;


import aleiiioa.components.vehicule.SteeringWheel;
import aleiiioa.systems.shaders.PressureShader.BitmapShader;
import aleiiioa.components.core.*;
import aleiiioa.components.solver.*;


class Builders {
    
    public static function basicObject(cx,cy) {
        var spr = new SpriteComponent();
        var se  = new SpriteExtension();
        var pos = new GridPosition(cx,cy);
        var bb  = new BoundingBox(pos.attachX,pos.attachY);
        var vc  = new VelocityComponent();
        var sw  = new SteeringWheel();
        new echoes.Entity().add(spr,se,pos,bb,vc,sw);
    }

    public static function basicModifier(cx:Int,cy:Int) {
        var pos = new GridPosition(cx,cy);
        var mod = new ModifierComponent();
        var vc = new VelocityComponent();
        new echoes.Entity().add(pos,mod,vc);
    }

    public static function layerComponent(shader:BitmapShader) {
        var layer = new LayerComponent(shader);
        new echoes.Entity().add(layer);
    }
}