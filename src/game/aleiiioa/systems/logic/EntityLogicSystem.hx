package aleiiioa.systems.logic;

import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.particules.EmitterComponent;
import aleiiioa.components.logic.InteractiveComponent;
import aleiiioa.components.flags.BombFlag;
import aleiiioa.builders.FxBuilders;
import aleiiioa.components.flags.collision.IsDiedFlag;

class EntityLogicSystem  extends echoes.System{
    public function new() {
        
    }

    
    @u function bombBehavior(en:echoes.Entity,bomb:BombFlag,ic:InteractiveComponent,em:EmitterComponent,gp:GridPosition){
        
        
        if(ic.isGrabbed && !ic.cd.has("countdown")){
            ic.cd.setS("countdown",3);
        }
        
        if(ic.cd.has("countdown")){
            if(ic.cd.getRatio("countdown") <= 0.05){
             FxBuilders.bombSmoke(em,gp);
             en.add(new IsDiedFlag());
            }
        }

    }
}