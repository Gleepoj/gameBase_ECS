package aleiiioa.builders;

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
        var bb  = new BoundingBox(pos.attachX,pos.attachY);
        var vc  = new VelocityComponent();
        var sw  = new SteeringWheel();
        new echoes.Entity().add(spr,se,pos,bb,vc,sw);
    }

    public static function basicModifier(cx:Int,cy:Int) {
        var pos  = new GridPosition(cx,cy);
        var mod  = new ModifierComponent();
        var vc   = new VelocityComponent();
        var vas  = new VelocityAnalogSpeed();
        var spr  = new SpriteComponent();
        var se   = new SpriteExtension();
        var inp  = new InputComponent();
        
        new echoes.Entity().add(pos,mod,vc,spr,se,inp,vas);
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