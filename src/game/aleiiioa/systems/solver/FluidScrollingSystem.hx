package aleiiioa.systems.solver;

import aleiiioa.components.vehicule.SteeringWheel;
import aleiiioa.components.core.velocity.VelocityComponent;
import aleiiioa.components.flags.vessel.PlayerFlag;
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
    var playerYSpeed:Float = 0;
    var playerGridPosition:GridPosition;

    public function new() {
        scrollPoint = Builders.scroller(0,FLUID_CY_TO_LEVEL);
        scrollGridPosition = scrollPoint.get(GridPosition);
    }

    @u function getPlayerSpeed(pl:PlayerFlag,gp:GridPosition,vc:VelocityComponent) {
        playerGridPosition = gp; 
        playerYSpeed = vc.dy;
    }
    @u function sharePlayerSpeed(scr:ScrollerComponent) {
        scr.scrollSpeed = playerYSpeed;
    }
    @u function updateSystem() {
        scrollGridPosition.cy = playerGridPosition.cy-50;
        scrollGridPosition.yr = playerGridPosition.yr;
    }
    
    @u function cellPositionOffset(cc:CellComponent,gpos:GridPosition){
        gpos.cy = cc.j + scrollGridPosition.cy;
        gpos.yr = 0.5  + scrollGridPosition.yr;
    } 

    @u function updateFluidPosition(fpos:FluidPosition, pos:GridPosition){
        var speedOffset = 1;//(Math.ceil(playerYSpeed));
        var p = scrollGridPosition;
        fpos.xr = pos.xr - p.xr;
        fpos.yr = pos.yr - p.yr;
        fpos.cx = pos.cx - p.cx;
        fpos.cy = pos.cy - p.cy + speedOffset; // find magic offset 
    }

}