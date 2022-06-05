package aleiiioa.systems.renderer;

//import aleiiioa.components.core.SpriteExtension;
import aleiiioa.components.core.collision.CollisionsListener;
import aleiiioa.components.core.rendering.*;
import echoes.System;

class SpriteExtensionFx extends System {
    public function new() {
        
    }
    @a function onAdded(spr:SpriteComponent,se:SpriteExtension) {
        if(se.baseColor != null)
            spr.colorize(se.baseColor.toColor());
    }

    @u function collide(spr:SpriteComponent,se:SpriteExtension,cl:CollisionsListener) {
        spr.colorize(se.baseColor.toColor());
        
        if(cl.onArea){
            spr.colorize(0xFF0000);
        }
    }
   
}