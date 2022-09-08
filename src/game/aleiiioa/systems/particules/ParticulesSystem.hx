package aleiiioa.systems.particules;

import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.particules.EmitterComponent;
import aleiiioa.builders.Builders;
import h2d.SpriteBatch.BatchElement;
import aleiiioa.components.particules.ParticulesComponent;


class ParticulesSystem extends echoes.System {

    public function new() {
        //Builders.emitter();
    }
    
    @a function onEmitterAdded(em:EmitterComponent,gp:GridPosition) {
       // em.layer.setPosition(gp.attachX,gp.attachY);
    }

    @u private function updateEmitter(dt:Float,em:EmitterComponent,gp:GridPosition){
        em.cd.update(dt);

        if(!em.cd.has("tick") && em.nbParticules < em.maxParticules){
            em.cd.setS("tick",em.tick);
            for(p in 0...30){
                emitRandParticule(em,gp,1,2);
                em.nbParticules += 1;
            }
            emitParticule(em,gp,-2,-2,1,1);
            emitParticule(em,gp,-0.7,-1.5,1,1);
            emitParticule(em,gp,0.8,-1.5,1,1);
            emitParticule(em,gp,2.2,-1.8,1,1); 
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

    @u function deletePart(dt:Float,en:echoes.Entity,p:ParticulesComponent) {
        p.cd.update(dt);
        
        p.scaleX -= 0.0001;
        p.scaleY -= 0.0001;
        p.alpha  -= p.shrink;

        if(!p.cd.has("alive")){
            p.bitmap.remove();
            en.destroy();
        }
    }

    private function emitParticule(em:EmitterComponent,gp:GridPosition,spx:Float,spy:Float,lifetime:Float,g:Float){
       var e = Builders.particule(gp,spx,spy,lifetime,false,0,g);
       em.addParticule(e);
    }
    private function emitRandParticule(em:EmitterComponent,gp:GridPosition,sprange:Float,lifetime:Float){
        var e = Builders.randParticule(gp,sprange,lifetime);
        em.addParticule(e);
    }

}