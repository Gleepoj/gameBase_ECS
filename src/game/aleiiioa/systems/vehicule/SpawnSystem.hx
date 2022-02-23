package aleiiioa.systems.vehicule;

import echoes.Entity;
import echoes.View;
import echoes.System;
import aleiiioa.components.flags.*;

class SpawnSystem extends System{
    
    var ALL_VESSELS:View<VesselFlag>;
    var TIME:Float;
    var INACTIVE_VESSELS:Array<Entity>;

    public function new() {
        TIME = 0 ; 
        INACTIVE_VESSELS = [];
    }

    @a function onVesselAdded(en:Entity,vf:VesselFlag,tf:TimeFlag) {
        INACTIVE_VESSELS.push(en);
        en.deactivate();
    }

    @u function spawnUpdate(dt:Float) {
       TIME = Game.ME.stime;

        for(en in INACTIVE_VESSELS){
                if(TIME > en.get(TimeFlag).SPAWN_SEC)
                    reactivateEntity(en);
            
        }
    } 

    function reactivateEntity(en:Entity){
        en.remove(TimeFlag);
        en.activate();
        INACTIVE_VESSELS.remove(en);
    }
}