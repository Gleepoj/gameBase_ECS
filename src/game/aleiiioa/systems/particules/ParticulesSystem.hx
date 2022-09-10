package aleiiioa.systems.particules;

import aleiiioa.components.core.collision.CollisionsListener;
import aleiiioa.builders.ParticulesBuilders;
import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.particules.*;


class ParticulesSystem extends echoes.System {

    public function new() {
        //Builders.emitter();
    }
    
    @a function onEmitterAdded(em:EmitterComponent,gp:GridPosition) {
    }

    @u private function updateEmitter(dt:Float,em:EmitterComponent,gp:GridPosition,cl:CollisionsListener){
        em.cd.update(dt);

        if(cl.onLanding && !em.cd.has("cooldown")){
            //em.cd.setS("tick",em.tick);
            em.cd.setS("cooldown",0.3);

            for(p in 0...100){
                emitRandParticule(em,gp,0.6,3,true,true);
            }
           // emitParticule(em,gp,-0.3,-0.3,1,1,true);
            //emitParticule(em,gp,0.1,-0.35,1,1,true);
            //emitParticule(em,gp,0.22,-0.4,1,1,true);
            //emitParticule(em,gp,0.44,-0.55,1,1,true); 
            
            for (right in 0...5){
                var r = right*0.1;
               // emitParticule(em,gp,-0.2-r,0,0.5,0,false,true);
            }
            for (left in 0...5){
                var l = left*0.1;
                //emitParticule(em,gp,0.2+l,0,0.5,0,false,true);
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
    @r function removeEmitterLayer(em:EmitterComponent){

    }

    private function emitParticule(em:EmitterComponent,gp:GridPosition,spx:Float,spy:Float,lifetime:Float,g:Float,?body:Bool = false,?customPhysics:Bool = false){
       var e = ParticulesBuilders.smokeParticule(gp,spx,spy,lifetime,body,customPhysics);
       em.addBitmap(e);
    }
    private function emitRandParticule(em:EmitterComponent,gp:GridPosition,sprange:Float,lifetime:Float,?body:Bool = false,?customPhysics:Bool = false){
        var e = ParticulesBuilders.randParticule(gp,sprange,lifetime,body,customPhysics);
        em.addBitmap(e);
    }

}