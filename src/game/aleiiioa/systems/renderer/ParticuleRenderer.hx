package aleiiioa.systems.renderer;

import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.particules.ParticulesComponent;

class ParticuleRenderer extends echoes.System {
    
    public function new (){

    }
    @u function actualizeBitmapPos(p:ParticulesComponent,gp:GridPosition){
        p.bitmap.x = gp.attachX;
        p.bitmap.y = gp.attachY;
        
        p.bitmap.rotation += p.rotation;
        
        p.bitmap.scaleX *= p.scaleX;
        p.bitmap.scaleY *= p.scaleY;

    }
}

