package aleiiioa.components.solver;

import format.abc.Data.IName;
import hxd.BitmapData;

class BitmapComponent {
    public var solverBmp:BitmapData;
    public var gridWidth:Int;
    public var gridHeight:Int;
    public var gridScale = Const.GRID;

    public function new(bmpData:BitmapData,levelWidth:Int, levelHeight:Int) {
        solverBmp = bmpData;
        gridWidth  = levelWidth;
        gridHeight = levelHeight;
        
    }

}