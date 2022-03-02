package aleiiioa.systems.vehicule;

import aleiiioa.components.vehicule.SteeringWheel;
import aleiiioa.components.vehicule.PathComponent;
import aleiiioa.components.core.position.GridPosition;

import echoes.System;

class PathActualizer extends System {
    public function new() {
        
    }

    @a function onPathComponentAdded(pc:PathComponent){
        if(pc.path.length == 1){
            pc.startIndex = 0;
            pc.endIndex = 0;
        }
        if(pc.path.length>1){
            pc.startIndex = 0;
            pc.endIndex = 1;
        }        
        pc.currentStart = pc.path[pc.startIndex];
        pc.currentEnd   = pc.path[pc.endIndex];
        //swapPathDebugPoint(pc);
    }

    @u private function updatePathStatus(sw:SteeringWheel,pc:PathComponent) {
        if(checkIfBoidHadReachEnd(pc,sw))
            setNextSegmentOnPath(pc);
    }

    @r private function onRemovePathComponent(pc:PathComponent) {
        //pc.startDebug.destroy();
        //pc.endDebug.destroy();
    }

    private function swapPathDebugPoint(pc:PathComponent) {
        pc.startDebug.remove(GridPosition);
        var gp = new GridPosition(pc.currentStart.cx,pc.currentStart.cy);
        pc.startDebug.add(gp);
        pc.endDebug.remove(GridPosition);
        var egp = new GridPosition(pc.currentEnd.cx,pc.currentEnd.cy);
        pc.endDebug.add(egp);
    }

    private function setNextSegmentOnPath(pc:PathComponent) {
        if (pc.endIndex < pc.path.length-1){
            pc.startIndex += 1;
            pc.endIndex += 1;
            pc.currentStart = pc.path[pc.startIndex];
            pc.currentEnd = pc.path[pc.endIndex];
        }
        //swapPathDebugPoint(pc);
    }
    
    private function checkIfBoidHadReachEnd(pc:PathComponent,sw:SteeringWheel){
        var ce = pc.currentEnd.gpToVector();
        var dist = ce.distance(sw.location);
    
        if(dist < 10 )
            return true;
        return false;
    }    
}
