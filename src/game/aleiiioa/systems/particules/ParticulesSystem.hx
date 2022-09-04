package aleiiioa.systems.particules;

import aleiiioa.components.particules.EmitterComponent;
import aleiiioa.builders.Builders;
import h2d.SpriteBatch.BatchElement;
import aleiiioa.components.particules.ParticulesComponent;


class ParticulesSystem extends echoes.System {
    /* 
    var sbParticules : Array<h2d.SpriteBatch.BatchElement>;
    var layer  : h2d.Layers;
    var sb     : h2d.SpriteBatch; */
    
    public function new() {
              
        Builders.emitter();
    }

    /* 
    @a private function onPartAdded(part:ParticulesComponent) {
        var tile = makeTile();
        sb.add(tile);
        sbParticules.push(tile);
    } */
    
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
/* 
    @u private function up() {

        for (p in sbParticules){
            p.rotation += Math.PI/50;
            //p.x += 0.8;
            p.g -= M.frand()*0.01;
            p.b -= M.frand()*0.01;
            p.a -= 0.002;
        }
    } */

    private function makeTile(){
        var sq = new BatchElement(Assets.tiles.getTile(D.tiles.Square));
        sq.x = M.frand()*100;
        sq.y = M.frand()*100;
        sq.rotation =  M.frand()*Math.PI;
        
        return sq;
    }
 


}