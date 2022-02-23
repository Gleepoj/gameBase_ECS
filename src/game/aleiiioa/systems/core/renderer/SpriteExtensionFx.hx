package aleiiioa.systems.core.renderer;

import aleiiioa.components.solver.ModifierComponent;
import aleiiioa.components.CollisionsListener;
import aleiiioa.components.core.SpriteExtension;
import aleiiioa.components.core.SpriteComponent;
import echoes.System;

class SpriteExtensionFx extends System {
    public function new() {
        
    }
/*     @u function colorizeModifier(spr:SpriteComponent,mod:ModifierComponent) {
		if (mod.isBlowing)
			spr.colorize(mod.activeColor);
		if (!mod.isBlowing)
			spr.colorize(mod.idleColor);
    } */

    @u function colorizeSpriteOnHit(spr:SpriteComponent,se:SpriteExtension,cl:CollisionsListener) {
        spr.colorize(0xffffff);
        if(cl.onBulletHit)
            spr.colorize(0xff0000);
        if(cl.onVesselHit)
            spr.colorize(0x00ff00);
    }

}