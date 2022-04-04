package aleiiioa.systems.solver;

import aleiiioa.components.core.position.FluidPosition;
import aleiiioa.components.solver.CellComponent;
import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.core.velocity.VelocityAnalogSpeed;
import aleiiioa.components.ScrollerComponent;
import aleiiioa.builders.Builders;

class FluidScrollingSystem extends echoes.System {
    var level(get,never) : Level; inline function get_level() return Game.ME.level;

    var scrollPoint: echoes.Entity;
    var scrollGridPosition : GridPosition;
    var FLUID_CY_TO_LEVEL = level.cHei - Const.FLUID_MAX_HEIGHT;
    var currentSpeed:Float = 0;

    public function new() {
        scrollPoint = Builders.scroller(0,FLUID_CY_TO_LEVEL);
    }
    @u function updateSystem() {
        scrollGridPosition = scrollPoint.get(GridPosition);
    }

    @u function updateScroll(scr:ScrollerComponent,vas:VelocityAnalogSpeed,gp:GridPosition){
        vas.ySpeed = scr.scrollSpeed;
        currentSpeed = vas.ySpeed;
    }
    
    @u function cellUpdate(cc:CellComponent,vas:VelocityAnalogSpeed,gpos:GridPosition){
        gpos.cy = cc.j + scrollGridPosition.cy;
        gpos.yr = 0.5 + scrollGridPosition.yr;
    } 

    @u function updateFluidPos(fpos:FluidPosition, pos:GridPosition){
        var speedOffset = (4*Math.ceil(currentSpeed));
        //trace(offset);
        var p = scrollGridPosition;
        fpos.xr = pos.xr - p.xr;
        fpos.yr = pos.yr - p.yr;
        fpos.cx = pos.cx - p.cx;
        fpos.cy = pos.cy - p.cy -1- speedOffset; // find magic offset 
    }
}