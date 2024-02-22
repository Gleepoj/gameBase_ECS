package aleiiioa.systems.logic.object;

import aleiiioa.components.logic.qualia.*;
import aleiiioa.components.logic.object.BombComponent;
import aleiiioa.components.logic.interaction.catching.IsCatched;

import aleiiioa.builders.entity.local.VfxBuilders;
import aleiiioa.components.local.particules.EmitterComponent;
import aleiiioa.components.core.physics.position.GridPosition;


class BombLogicSystem  extends echoes.System{
    public function new() {
    }

    @:a function onAddIsCatchedLaunchCountDown(en:echoes.Entity,add:IsCatched,ic:BombComponent){
        ic.cd.setS("countdown",3);
    }

    @:u function updateInteractCooldown(dt:Float,ic:BombComponent) {
        ic.cd.update(dt);
    }

    @:u function bombBehavior(en:echoes.Entity,ic:BombComponent,em:EmitterComponent,gp:GridPosition){
  
        if(ic.cd.has("countdown")){
            if(ic.cd.getRatio("countdown") <= 0.05){
             VfxBuilders.bombSmoke(em,gp);
             en.add(new IsDiedFlag());
             //Game.ME.addSlowMo("bomb",0.5,0.7);
            }
        }

    }
}