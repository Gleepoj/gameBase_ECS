package aleiiioa.systems.utils;

import aleiiioa.components.core.level.Focused_Entity;
import echoes.View;

import aleiiioa.components.core.physics.velocity.body.KinematicBodyFlag;
import aleiiioa.components.core.physics.position.GridPosition;
import aleiiioa.components.core.level.LevelComponent;
import aleiiioa.components.core.level.ChunkCollisionLayer;
import aleiiioa.components.core.level.Focused_Chunk;
import aleiiioa.components.core.level.Focused_Entity;

import aleiiioa.components.logic.qualia.PlayerFlag;
import aleiiioa.builders.entity.local.UIBuilders;


class TemporarySystem extends echoes.System {
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
        UIBuilders.debugfloat("current_chunk_i",function()return local_pos_x,function(v) local_pos_x = v);
        UIBuilders.debugfloat("current_chunk_j",function()return local_pos_y,function(v) local_pos_y = v);
    }

    @u function updateWorldDebug(pl:PlayerFlag,gp:GridPosition){
        player_world_cx = gp.cx;
        player_world_cy = gp.cy;

        local_pos_x = gp.iw;
        local_pos_y = gp.jw;

        level_chunk_x = gp.lcx;
        level_chunk_y = gp.lcy;
    }

    @a function addChunkCollisionMask(en:echoes.Entity,gp:GridPosition,k:KinematicBodyFlag){
        var head = ALL_LEVELS.entities.head;
        while(head != null){
            var level = head.value.get(LevelComponent);
            if(level.i == gp.iw && level.j == gp.jw){
                en.add(new ChunkCollisionLayer(level.marks,level.i,level.j));
                //trace("add collision layer");
                if(en.exists(Focused_Entity)){
                    trace("add new focus chunk at ch.i :"+ level.i+" ch.j"+level.j+"");
                    head.value.add(new Focused_Chunk());
                }
            }
            head = head.next;
        }
    }

    @a function onEntityFocusChangeChunk(en:echoes.Entity,gp:GridPosition,f:Focused_Entity,c:ChunkCollisionLayer){
        var head = ALL_LEVELS.entities.head;
        while(head != null){
            var level = head.value.get(LevelComponent);
            if(level.i == gp.iw && level.j == gp.jw){
                if(!head.value.exists(Focused_Chunk)){
                    trace("add new focus chunk at ch.i :"+ level.i+" ch.j"+level.j+"");
                    head.value.add(new Focused_Chunk());
                }
            }
            head = head.next;
        }
    }

    @u function swapChunkCollisionMask(en:echoes.Entity,gp:GridPosition,c:ChunkCollisionLayer){
        if(gp.iw != c.i || gp.jw != c.j){
            
            var head = ALL_LEVELS.entities.head;
            while(head != null){
                var level = head.value.get(LevelComponent);
                if(level.i == gp.iw && level.j == gp.jw){
                    en.remove(ChunkCollisionLayer);
                    en.add(new ChunkCollisionLayer(level.marks,level.i,level.j));
                    trace("swap collision to i:"+ level.i + " j: "+ level.j+"");
                }
                head = head.next;
            }
        }
    }

    @u function drawFocusedEntityChunk(focus:Focused_Entity) {
        
    }

}