package aleiiioa.systems.vehicule;
//Dont know for the moment if keeping time flag as flag instead of spawncoponent
import echoes.Entity;
import echoes.View;
import echoes.System;
import aleiiioa.components.core.position.SpawnTimeComponent;
import aleiiioa.components.flags.vessel.*;


class SpawnSystem extends System{
    
    var ALL_VESSELS:View<VesselFlag>;
    var TIME:Int;
    var INACTIVE_VESSELS:Array<Entity>;

    public function new() {
        TIME = 0 ; 
        INACTIVE_VESSELS = [];
    }

    @a function onVesselAdded(en:Entity,vf:VesselFlag,stc:SpawnTimeComponent) {
        INACTIVE_VESSELS.push(en);
        en.deactivate();
    }

    @u function spawnUpdate(dt:Float) {
       TIME = Math.floor(Game.ME.stime);

        for(en in INACTIVE_VESSELS){
                if(TIME >= en.get(SpawnTimeComponent).SPAWN_SEC)
                    reactivateEntity(en);
            
        }
    } 

    function reactivateEntity(en:Entity){
        en.remove(SpawnTimeComponent);
        en.activate();
        INACTIVE_VESSELS.remove(en);
    }
}