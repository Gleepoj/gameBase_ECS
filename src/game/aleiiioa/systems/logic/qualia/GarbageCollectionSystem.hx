package aleiiioa.systems.logic.qualia;

import aleiiioa.components.core.physics.position.MasterGridPosition;

import aleiiioa.components.core.physics.position.flags.*;
import aleiiioa.components.logic.qualia.*;

class GarbageCollectionSystem extends echoes.System {
    public function new() {
        
    }
    
    @r function onRemoveMasterGridPos(en:echoes.Entity,mgp:MasterGridPosition,mf:MasterPositionFlag) {
        mgp.isMasterAlive = false;
    }

    @u function flagChild(en:echoes.Entity,cflag:ChildPositionFlag,mgp:MasterGridPosition){
        if(!en.get(MasterGridPosition).isMasterAlive){
            en.add(new IsDiedFlag()); 
        }
    }

    @u function destroyEntity(en:echoes.Entity,dflag:IsDiedFlag) {
        en.destroy();
    }

}