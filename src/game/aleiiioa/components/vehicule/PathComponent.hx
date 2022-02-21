package aleiiioa.components.vehicule;

import aleiiioa.builders.Builders;
import aleiiioa.components.core.SpriteComponent;
import aleiiioa.components.core.GridPosition;

class PathComponent {
    public var path:Array<GridPosition>;

    public var currentStart:GridPosition;
    public var currentEnd:GridPosition;
    public var endIndex:Int;
    public var startIndex:Int;

    //for temporary debug purpose ONLY cause major entity removal issue 
    public var startDebug:echoes.Entity;
    public var endDebug:echoes.Entity;

    public var loop:Bool;

    public function new(_path:Array<ldtk.Point>) {
        path = [];
        
        for(pt in _path){
            var newPathPoint = new GridPosition(pt.cx,pt.cy);
            path.push(newPathPoint);
        }
        //startDebug = Builders.pointDebugger(0,0,false);
        //endDebug = Builders.pointDebugger(0,0,true);
    }
}