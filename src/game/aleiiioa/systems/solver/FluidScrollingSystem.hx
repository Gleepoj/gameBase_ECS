package aleiiioa.systems.solver;


import aleiiioa.builders.Builders;

import aleiiioa.components.core.camera.CameraFocusComponent;
import aleiiioa.components.core.position.FluidPosition;
import aleiiioa.components.core.position.GridPosition;

import aleiiioa.components.solver.CellComponent;

class FluidScrollingSystem extends echoes.System {
    var level(get,never) : Level; inline function get_level() return Game.ME.level;
    
    var scrollPoint: echoes.Entity;
    var scrollGridPosition : GridPosition;
    var FLUID_CY_TO_LEVEL = level.cHei - Const.FLUID_MAX_HEIGHT;
   
    public function new() {
        scrollPoint = Builders.fluidScroller(0,FLUID_CY_TO_LEVEL);
        scrollGridPosition = scrollPoint.get(GridPosition);
    }
    
    @u function updateSystem(foc:CameraFocusComponent,focus:GridPosition) {
        scrollGridPosition.cy = focus.cy - Const.FLUID_OFFSCREEN_TOP;
        scrollGridPosition.yr = focus.yr;
    }
    
    @u function cellPositionActualizer(cc:CellComponent,gpos:GridPosition){
        gpos.cy = cc.j + scrollGridPosition.cy;
        gpos.yr = 0.5  + scrollGridPosition.yr;
    } 

    @u function updateEntityFluidPosition(fpos:FluidPosition, pos:GridPosition){     
        var p = scrollGridPosition;
        fpos.xr = pos.xr - p.xr;
        fpos.yr = pos.yr - p.yr;
        fpos.cx = pos.cx - p.cx;
        fpos.cy = pos.cy - p.cy;
    }

}