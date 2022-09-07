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
            emitParticule(em,gp);
            em.nbParticules += 1;
        }
    }

    @u function deletePart(dt:Float,en:echoes.Entity,p:ParticulesComponent) {
        p.cd.update(dt);
        //shrink part 
        
        p.scaleX -= 0.0001;
        p.scaleY -= 0.0001;
        p.alpha  -= p.shrink;

        if(!p.cd.has("alive")){
            p.bitmap.remove();
            en.destroy();
        }
    }

    private function emitParticule(em:EmitterComponent,gp:GridPosition){
       var e = Builders.particule(gp);
       em.addParticule(e);
    }

}