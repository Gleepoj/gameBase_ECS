package aleiiioa.builders;

import aleiiioa.components.*;

class Builders {
    
    public static function basicObject(cx,cy) {
        var spr = new SpriteComponent();
        var pos = new GridPosition(cx,cy);
        new echoes.Entity().add(spr,pos);
    }
}