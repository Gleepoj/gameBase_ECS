

import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.particules.ParticulesComponent;

class ParticulesRenderer extends echoes.System {
    public function new (){

    }

    @u function actualizeBitmapPos(p:ParticulesComponent,gp:GridPosition){
        p.bitmap.x = gp.attachX;
        p.bitmap.y = gp.attachY;

    }
}