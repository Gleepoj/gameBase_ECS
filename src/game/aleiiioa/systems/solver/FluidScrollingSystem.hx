package aleiiioa.systems.solver;

import aleiiioa.components.core.position.FluidPosition;
import aleiiioa.components.solver.CellComponent;
import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.core.velocity.VelocityAnalogSpeed;
import aleiiioa.components.ScrollerComponent;
import aleiiioa.builders.Builders;

class FluidScrollingSystem extends echoes.System {
    var scrollPoint: echoes.Entity;
    var scrollGridPosition : GridPosition;
    

    public function new() {
        scrollPoint = Builders.scroller(0,0);
    }
    @u function updateSystem() {
        scrollGridPosition = scrollPoint.get(GridPosition);
    }

    @u function updateScroll(scr:ScrollerComponent,vas:VelocityAnalogSpeed,gp:GridPosition){
        vas.ySpeed = scr.scrollSpeed;
    }
    
    @u function cellUpdate(cc:CellComponent,vas:VelocityAnalogSpeed,gpos:GridPosition){
        gpos.cy = cc.j + scrollGridPosition.cy;
        gpos.yr = 0.5 + scrollGridPosition.yr;
    } 

    @u function updateFluidPos(fpos:FluidPosition, pos:GridPosition){
        var p = scrollGridPosition;
        fpos.xr = pos.xr - p.xr;
        fpos.yr = pos.yr - p.yr;
        fpos.cx = pos.cx - p.cx;
        fpos.cy = pos.cy - p.cy -5; // find magic offset 
    }
}