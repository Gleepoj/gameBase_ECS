package aleiiioa.systems.core;
import aleiiioa.components.core.*;

class GridPositionActualizer extends echoes.System {
    
    public function new() {
        
    }

    @a function onGridPositionAdded(gp:GridPosition) {
       setPosCase(gp,gp.cx,gp.cy); 
    }
    
    @u inline function ActualizeGridComponent(gp:GridPosition){
		updateLastFixedUpdatePos(gp);
    }

	function setPosCase(gp:GridPosition,_cx:Int,_cy:Int) {
		gp.cx = _cx;
		gp.cy = _cy;
		gp.xr = 0.5;
		gp.yr = 1;
		onPosManuallyChanged(gp);
	}

    function setPosPixel(gp:GridPosition,x:Float, y:Float) {
		gp.cx = Std.int(x/Const.GRID);
		gp.cy = Std.int(y/Const.GRID);
		gp.xr = (x-gp.cx*Const.GRID)/Const.GRID;
		gp.yr = (y-gp.cy*Const.GRID)/Const.GRID;
		onPosManuallyChanged(gp);
	}

	function onPosManuallyChanged(gp:GridPosition) {
		if( M.dist(gp.attachX,gp.attachY,gp.prevFrameattachX,gp.prevFrameattachY) > Const.GRID*2 ) {
			gp.prevFrameattachX = gp.attachX;
			gp.prevFrameattachY = gp.attachY;
		}
		updateLastFixedUpdatePos(gp);
	}

	function finalUpdate(gp:GridPosition) {
		gp.prevFrameattachX = gp.attachX;
		gp.prevFrameattachY = gp.attachY;
	}

    function updateLastFixedUpdatePos(gp:GridPosition) {
		gp.lastFixedUpdateX = gp.attachX;
		gp.lastFixedUpdateY = gp.attachY;
	}

}