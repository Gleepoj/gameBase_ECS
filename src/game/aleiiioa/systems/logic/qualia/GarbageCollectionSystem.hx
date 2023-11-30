package aleiiioa.systems.logic.qualia;

//Bullets are destroy in various collisions systems 
import echoes.System;
import echoes.Entity;


import aleiiioa.components.core.physics.position.MasterGridPosition;

import aleiiioa.components.core.physics.position.flags.*;
import aleiiioa.components.logic.*;
import aleiiioa.components.logic.qualia.*;



class GarbageCollectionSystem extends System {
    public function new() {
        
    }
    
    @r function onRemoveMasterGridPos(en:Entity,mgp:MasterGridPosition,mf:MasterPositionFlag) {
        mgp.isMasterAlive = false;
    }

    @u function flagChild(en:Entity,cflag:ChildPositionFlag,mgp:MasterGridPosition){
        if(!en.get(MasterGridPosition).isMasterAlive){
            en.add(new IsDiedFlag()); 
        }
    }

    @u function destroyEntity(en:Entity,dflag:IsDiedFlag) {
        en.destroy();
    }

}