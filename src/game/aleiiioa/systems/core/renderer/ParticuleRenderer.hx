package aleiiioa.systems.core.renderer;

import aleiiioa.components.local.particules.BitmapComponent;
import aleiiioa.components.local.particules.ParticulesComponent;

import aleiiioa.components.core.physics.position.GridPosition;

class ParticuleRenderer extends echoes.System {
    public function new (){

    }
    
    @a function onParticuleAdded(p:ParticulesComponent,bmp:BitmapComponent) {      
        bmp.bitmap.scaleX *= p.scaleX;
        bmp.bitmap.scaleY *= p.scaleY;
    }

    @u function updateParticule(bmp:BitmapComponent,p:ParticulesComponent){
        
        bmp.bitmap.rotation += p.rotation;
        
        bmp.bitmap.scaleX *= p.scaleX;
        bmp.bitmap.scaleY *= p.scaleY;
    }

    @u function actualizeBitmapPos(bmp:BitmapComponent,gp:GridPosition) {
        bmp.bitmap.x = gp.attachX;
        bmp.bitmap.y = gp.attachY;
    }
    
}

