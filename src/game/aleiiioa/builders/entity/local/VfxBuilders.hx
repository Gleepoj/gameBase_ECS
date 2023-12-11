package aleiiioa.builders.entity.local;

import aleiiioa.components.core.physics.position.GridPosition;
import aleiiioa.components.local.particules.EmitterComponent;

class VfxBuilders {

    
    private static function emitParticule(em:EmitterComponent,gp:GridPosition,spx:Float,spy:Float,lifetime:Float,seed:Int){
        var e = ParticulesBuilders.smokeParticule(gp,spx,spy,lifetime,seed);
        em.addBitmap(e);
    }

        
    private static function emitSolidParticule(em:EmitterComponent,gp:GridPosition,spx:Float,spy:Float,lifetime:Float,seed:Int){
        var e = ParticulesBuilders.smokeSolidParticule(gp,spx,spy,lifetime,seed);
        em.addBitmap(e);
    }
    
    
    private static function emitRandParticule(em:EmitterComponent,gp:GridPosition,sprange:Float,lifetime:Float){
         var e = ParticulesBuilders.randParticule(gp,sprange,lifetime);
         em.addBitmap(e);
    }

    private static function emitRandSolidParticule(em:EmitterComponent,gp:GridPosition,sprange:Float,lifetime:Float){
        var e = ParticulesBuilders.randSolidParticule(gp,sprange,lifetime);
        em.addBitmap(e);
    }

    public static function landing(em:EmitterComponent,gp:GridPosition) {
        for(p in 0...5){
            //emitRandParticule(em,gp,0.2,1,true,true);
            emitRandSolidParticule(em,gp,0.2,1);
        }
        
        for (right in 0...2){
            var r = right*0.02;
            emitParticule(em,gp,-0.2-r,0,0.3,3);
        }
        
        for (left in 0...5){
            var l = left*0.02;
            emitParticule(em,gp,0.2+l,0,0.3,3);
        }
    }
    
    public static function bombSmoke(em:EmitterComponent,gp:GridPosition) {
        for(p in 0...100){
            emitRandSolidParticule(em,gp,0.6,3);
            
        }
        
        for (right in 0...5){
            var r = right*0.05;
            emitParticule(em,gp,-0.2-r,0,1,3);
        }
        
        for (left in 0...5){
            var l = left*0.05;
            emitParticule(em,gp,0.2+l,0,1,3);
        }
    }

    
}