package aleiiioa.systems.core.renderer;

//import aleiiioa.components.core.SpriteExtension;
import aleiiioa.components.logic.interaction.InteractionListener;
import aleiiioa.components.core.collision.CollisionSensor;
import aleiiioa.components.core.rendering.*;
import echoes.System;

class SpriteExtensionFx extends System {
    public function new() {
        
    }
    @a function onAdded(spr:SpriteComponent,se:SpriteExtension) {
        if(se.baseColor != null)
            spr.colorize(se.baseColor.toColor());
    }

    @u function collideDebug(spr:SpriteComponent,se:SpriteExtension,cl:CollisionSensor,il:InteractionListener) {
        spr.colorize(se.baseColor.toColor());
        
        if(il.onArea){
            spr.colorize(0xFF0000);
        }

        if(il.onInteract){
            spr.colorize(0x01AA74);
        }
/*  
        if(cl.onGround){
            spr.colorize(0x3566D5);
        }
        if(cl.onRight){
            spr.colorize(0xbae1ff);
        }
        if(cl.onLeft){
            spr.colorize(0xbaffc9);
        }
        if(cl.onCeil){
            spr.colorize(0xeea990);
        } */
    }
   
}