package aleiiioa.systems.logic.behavior;

import aleiiioa.components.logic.interaction.catching.IsCatched;
import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.particules.EmitterComponent;
import aleiiioa.components.logic.InteractiveComponent;
import aleiiioa.components.logic.qualia.*;
import aleiiioa.builders.VfxBuilders;
import aleiiioa.components.logic.IsDiedFlag;

class BombLogicSystem  extends echoes.System{
    public function new() {
        
    }
    @a function onAddIsCatchedLaunchCountDown(en:echoes.Entity,add:IsCatched,ic:InteractiveComponent){
            ic.cd.setS("countdown",3);
    }

    
    @u function updateInteractCooldown(dt:Float,ic:InteractiveComponent) {
        ic.cd.update(dt);
    }

    @u function bombBehavior(en:echoes.Entity,bomb:BombFlag,ic:InteractiveComponent,em:EmitterComponent,gp:GridPosition){
  
        if(ic.cd.has("countdown")){
            if(ic.cd.getRatio("countdown") <= 0.05){
             VfxBuilders.bombSmoke(em,gp);
             en.add(new IsDiedFlag());
            }
        }

    }
}