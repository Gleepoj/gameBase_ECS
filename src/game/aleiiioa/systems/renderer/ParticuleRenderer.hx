package aleiiioa.systems.renderer;

import aleiiioa.components.particules.BitmapComponent;
import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.particules.ParticulesComponent;

class ParticuleRenderer extends echoes.System {
    // switch to bitmap renderer
    public function new (){

    }
    @a function onParticuleAdded(p:ParticulesComponent,bmp:BitmapComponent) {      
        p.bitmap.scaleX *= p.scaleX;
        p.bitmap.scaleY *= p.scaleY;
    }
    @u function actualizeBitmapPos(bmp:BitmapComponent,gp:GridPosition) {
        bmp.bitmap.x = gp.attachX;
        bmp.bitmap.y = gp.attachY;
    }
    @u function updateParticule(bmp:BitmapComponent,p:ParticulesComponent){
        
        bmp.bitmap.rotation += p.rotation;
        
        bmp.bitmap.scaleX *= p.scaleX;
        bmp.bitmap.scaleY *= p.scaleY;
    }
    // to remove
    @u function actualizeBitmapPosOld(p:ParticulesComponent,gp:GridPosition){
        p.bitmap.x = gp.attachX;
        p.bitmap.y = gp.attachY;
        
        p.bitmap.rotation += p.rotation;
        
        p.bitmap.scaleX *= p.scaleX;
        p.bitmap.scaleY *= p.scaleY;
    }
}

