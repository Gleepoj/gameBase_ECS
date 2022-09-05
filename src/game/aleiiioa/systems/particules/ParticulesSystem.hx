package aleiiioa.systems.particules;

import aleiiioa.components.particules.EmitterComponent;
import aleiiioa.builders.Builders;
import h2d.SpriteBatch.BatchElement;
import aleiiioa.components.particules.ParticulesComponent;


class ParticulesSystem extends echoes.System {
    
    public function new() {
              
        Builders.emitter();
    }
    
    @u private function updateEmitter(dt:Float,em:EmitterComponent){
        em.cd.update(dt);

        if(!em.cd.has("tick")){
            em.cd.setS("tick",0.1);
            emitParticule(em);
        }
        

    }

    private function emitParticule(em:EmitterComponent){
       var be = makeTile();
       em.addParticule(be);
    }

    private function makeTile(){
        var sq = new BatchElement(Assets.tiles.getTile(D.tiles.Square));

        sq.x = M.frand()*100;
        sq.y = M.frand()*100;
        sq.rotation =  M.frand()*Math.PI;
        
        sq.a = 0.4;
        return sq;
    }
 


}