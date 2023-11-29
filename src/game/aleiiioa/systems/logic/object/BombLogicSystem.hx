package aleiiioa.systems.logic.object;

import aleiiioa.components.logic.interaction.catching.IsCatched;
import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.local.particules.EmitterComponent;
import aleiiioa.components.logic.object.BombComponent;
import aleiiioa.components.core.qualia.*;
import aleiiioa.builders.VfxBuilders;

import aleiiioa.components.core.qualia.*;

class BombLogicSystem  extends echoes.System{
    public function new() {
    }

    @a function onAddIsCatchedLaunchCountDown(en:echoes.Entity,add:IsCatched,ic:BombComponent){
        ic.cd.setS("countdown",3);
    }

    @u function updateInteractCooldown(dt:Float,ic:BombComponent) {
        ic.cd.update(dt);
    }

    @u function bombBehavior(en:echoes.Entity,ic:BombComponent,em:EmitterComponent,gp:GridPosition){
  
        if(ic.cd.has("countdown")){
            if(ic.cd.getRatio("countdown") <= 0.05){
             VfxBuilders.bombSmoke(em,gp);
             en.add(new IsDiedFlag());
            }
        }

    }
}