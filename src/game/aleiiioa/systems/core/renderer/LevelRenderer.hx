package aleiiioa.systems.core.renderer;

import aleiiioa.components.core.physics.velocity.body.KinematicBodyFlag;
import aleiiioa.components.core.physics.collision.affects.CollisionLayer_Wall;
import echoes.View;
import aleiiioa.components.core.physics.position.GridPosition;
import aleiiioa.components.logic.qualia.PlayerFlag;
import aleiiioa.builders.entity.local.UIBuilders;
import aleiiioa.components.core.level.LevelComponent;
import aleiiioa.components.core.level.ChunkCollisionLayer;


class LevelRenderer extends echoes.System {
    var ALL_LEVELS:View<LevelComponent>;

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

        local_pos_x = gp.lcx;
        local_pos_y = gp.lcy;

        level_chunk_x = gp.iw;
        level_chunk_y = gp.jw;
    }

    @u function clearRenderer(){
        Game.ME.scroller.removeChildren();
    }

    @a function addChunkCollisionMask(en:echoes.Entity,gp:GridPosition,k:KinematicBodyFlag){
        var head = ALL_LEVELS.entities.head;

        while(head != null){
            var level = head.value.get(LevelComponent);


            if(level.i == gp.iw && level.j == gp.jw)
                en.add(new ChunkCollisionLayer(level.marks,level.i,level.j));

            head = head.next;
        }
    }

    @u function swapChunkCollisionMask(en:echoes.Entity,gp:GridPosition,c:ChunkCollisionLayer){
        if(gp.iw != c.i || gp.jw != c.j){
            //trace("swap collision");
            var head = ALL_LEVELS.entities.head;
            en.remove(ChunkCollisionLayer);
            while(head != null){
                var level = head.value.get(LevelComponent);
                if(level.i == gp.iw && level.j == gp.jw){
                    en.add(new ChunkCollisionLayer(level.marks,level.i,level.j));
                    //trace("i:"+level.i+" j:"+level.j+"");
                }
                head = head.next;
            }
        }
    }

    @a function traceC(c:ChunkCollisionLayer){
        //trace("ok add chunk");
    }

    @u function levelRendering(level:LevelComponent){
        
/*         var current_level_x = player_world_cx%32;
        var current_level_y = player_world_cy%32;

        var chunk_x:Int = Math.floor(player_world_cx/32);
        var chunk_y:Int = Math.floor(player_world_cy/32);

        level_chunk_x = chunk_x;
        level_chunk_y = chunk_y;

        // get level chunk reference from level component
        local_pos_x = current_level_x;
        local_pos_y = current_level_y; */

        level.render();
    }
}