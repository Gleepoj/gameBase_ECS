package aleiiioa.systems.core.renderer;

import aleiiioa.components.core.physics.position.GridPosition;
import aleiiioa.components.logic.qualia.PlayerFlag;
import aleiiioa.builders.entity.local.UIBuilders;
import aleiiioa.components.core.level.LevelComponent;

class LevelRenderer extends echoes.System {
    
    var player_world_cx:Float = 0.;
    var player_world_cy:Float = 0.;
    
    var local_pos_x:Float = 0.;
    var local_pos_y:Float = 0.;

    var level_chunk_x:Float =0.;
    var level_chunk_y:Float =0.;

    public function new (){
        UIBuilders.debugfloat("player_wcx",function()return player_world_cx,function(v) player_world_cx = v);
        UIBuilders.debugfloat("player_wcy",function()return player_world_cy,function(v) player_world_cy = v);
        UIBuilders.debugfloat("level_chunk_x",function()return level_chunk_x,function(v) level_chunk_x = v);
        UIBuilders.debugfloat("level_chunk_y",function()return level_chunk_y,function(v) level_chunk_y = v);
        UIBuilders.debugfloat("local_pos_x",function()return local_pos_x,function(v) local_pos_x = v);
        UIBuilders.debugfloat("local_pos_y",function()return local_pos_y,function(v) local_pos_y = v);
    }

    @u function updateWorldDebug(pl:PlayerFlag,gp:GridPosition){
    
        player_world_cx = gp.cx;
        player_world_cy = gp.cy;


    }

    @u function clearRenderer(){
        Game.ME.scroller.removeChildren();
    }
    
    @u function levelRendering(level:LevelComponent){
        
        var current_level_x = player_world_cx%32;
        var current_level_y = player_world_cy%32;

        var chunk_x:Int = Math.floor(player_world_cx / 32);
        var chunk_y:Int = Math.floor(player_world_cy / 32);

        level_chunk_x = chunk_x;
        level_chunk_y = chunk_y;

        // get level chunk reference from level component
        local_pos_x = current_level_x;
        local_pos_y = current_level_y;

        level.render();
    }
}