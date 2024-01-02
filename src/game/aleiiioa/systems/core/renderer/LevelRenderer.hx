package aleiiioa.systems.core.renderer;

import aleiiioa.components.core.physics.position.GridPosition;
import aleiiioa.components.logic.qualia.PlayerFlag;
import aleiiioa.builders.entity.local.UIBuilders;
import aleiiioa.components.core.level.LevelComponent;

class LevelRenderer extends echoes.System {
    
    var player_world_cx:Float = 0.;
    var player_world_cy:Float = 0.;

    public function new (){
        UIBuilders.debugfloat("player_wcx",function()return player_world_cx,function(v) player_world_cx = v);
        UIBuilders.debugfloat("player_wcy",function()return player_world_cy,function(v) player_world_cy = v);
    }

    @u function updateWorldDebug(pl:PlayerFlag,gp:GridPosition){
    
        player_world_cx = gp.cx;
        player_world_cy = gp.cy;
    }

    @u function clearRenderer(){
        Game.ME.scroller.removeChildren();
    }
    
    @u function levelRendering(level:LevelComponent){

        level.render();
    }
}