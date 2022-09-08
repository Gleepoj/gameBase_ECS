package aleiiioa.systems.particules;

import aleiiioa.builders.ParticulesBuilders;
import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.particules.*;


class ParticulesSystem extends echoes.System {

    public function new() {
        //Builders.emitter();
    }
    
    @a function onEmitterAdded(em:EmitterComponent,gp:GridPosition) {
    }

    @u private function updateEmitter(dt:Float,em:EmitterComponent,gp:GridPosition){
        em.cd.update(dt);

        if(!em.cd.has("tick") && em.nbParticules < em.maxParticules){
            em.cd.setS("tick",em.tick);
            for(p in 0...30){
                emitRandParticule(em,gp,1,2,true);
                em.nbParticules += 1;
            }
            emitParticule(em,gp,-6,-7,1,1,true);
            emitParticule(em,gp,-7.7,-6.5,1,1,true);
            emitParticule(em,gp,8.8,-5.5,1,1,true);
            emitParticule(em,gp,10.2,-7,1,1,true); 
            
            for (right in 0...5){
                var r = right*0.1;
                emitParticule(em,gp,-0.5-r,0,0.5,0);
            }
            for (left in 0...5){
                var l = left*0.1;
                emitParticule(em,gp,0.5+l,0,0.5,0);
            }
            
        }
    }

    @u function deletePart(dt:Float,en:echoes.Entity,p:ParticulesComponent,bmp:BitmapComponent) {
        p.cd.update(dt);
        
        p.scaleX -= 0.0001;
        p.scaleY -= 0.0001;
        p.alpha  -= p.shrink;

        if(!p.cd.has("alive")){
            bmp.bitmap.remove();
            en.destroy();
        }
    }

    private function emitParticule(em:EmitterComponent,gp:GridPosition,spx:Float,spy:Float,lifetime:Float,g:Float,?body:Bool = false){
       var e = ParticulesBuilders.smokeParticule(gp,spx,spy,lifetime,body,0,g);
       em.addBitmap(e);
    }
    private function emitRandParticule(em:EmitterComponent,gp:GridPosition,sprange:Float,lifetime:Float,?body:Bool = false){
        var e = ParticulesBuilders.randParticule(gp,sprange,lifetime,body);
        em.addBitmap(e);
    }

}