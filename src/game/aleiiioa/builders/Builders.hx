package aleiiioa.builders;

import aleiiioa.components.*;

class Builders {
    
    public static function basicObject(x,y) {
        var spr = new SpriteComponent();
        var pos = new PixelPosition(x,y);
        new echoes.Entity().add(spr,pos);
    }
}