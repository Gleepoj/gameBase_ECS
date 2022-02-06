package aleiiioa.builders;

import aleiiioa.components.*;

class Builders {
    
    public static function basicObject(cx,cy) {
        var spr = new SpriteComponent();
        var se  = new SpriteExtension();
        var pos = new GridPosition(cx,cy);
        var bb  = new BoundingBox(pos.attachX,pos.attachY);
        var vc  = new VelocityComponent();
        new echoes.Entity().add(spr,se,pos,bb,vc);
    }
}