package aleiiioa.systems.renderer;

//import aleiiioa.components.core.SpriteExtension;
import aleiiioa.components.core.rendering.*;
import echoes.System;

class SpriteExtensionFx extends System {
    public function new() {
        
    }
    @a function onAdded(spr:SpriteComponent,se:SpriteExtension) {
        if(se.baseColor != null)
            spr.colorize(se.baseColor.toColor());
    }

   
}