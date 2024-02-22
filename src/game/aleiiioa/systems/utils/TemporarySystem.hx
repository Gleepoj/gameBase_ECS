package aleiiioa.systems.utils;

import aleiiioa.components.core.level.Chunk_Active;
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
    var ALL_LEVELS:View<LevelComponent> = getLinkedView(LevelComponent);
    var ALL_ACTIVE_LEVELS:View<LevelComponent,Chunk_Active> = getLinkedView(LevelComponent,Chunk_Active);

    var player_world_cx:Float = 0.;
    var player_world_cy:Float = 0.;
    
    var local_pos_x:Float = 0.;
    var local_pos_y:Float = 0.;

    var level_chunk_x:Float =0.;
    var level_chunk_y:Float =0.;
    var last_position:String = "unknown";

    public function new (){
        UIBuilders.debugfloat("player_wcx",function()return player_world_cx,function(v) player_world_cx = v);
        UIBuilders.debugfloat("player_wcy",function()return player_world_cy,function(v) player_world_cy = v);
        UIBuilders.debugfloat("level_chunk_x",function()return level_chunk_x,function(v) level_chunk_x = v);
        UIBuilders.debugfloat("level_chunk_y",function()return level_chunk_y,function(v) level_chunk_y = v);
        UIBuilders.debugfloat("current_chunk_i",function()return local_pos_x,function(v) local_pos_x = v);
        UIBuilders.debugfloat("current_chunk_j",function()return local_pos_y,function(v) local_pos_y = v);
    }

    @:u function updateWorldDebug(pl:PlayerFlag,gp:GridPosition,f:Focused_Entity){
        player_world_cx = gp.cx;
        player_world_cy = gp.cy;

        local_pos_x = gp.iw;
        local_pos_y = gp.jw;

        level_chunk_x = gp.lcx;
        level_chunk_y = gp.lcy;
    }

    @:a function addChunkCollisionMask(en:echoes.Entity,gp:GridPosition,k:KinematicBodyFlag){
        var levels = ALL_LEVELS.entities;
        for(head in levels){
            var level = head.get(LevelComponent);
            if(level.i == gp.iw && level.j == gp.jw){
                en.add(new ChunkCollisionLayer(level.marks,level.i,level.j));
                //trace("add collision layer");
                if(en.exists(Focused_Entity)){
                    //trace("add new focus chunk at ch.i :"+ level.i+" ch.j"+level.j+"");
                    head.add(new Focused_Chunk());
                }
            }
            //head = head.next;
        }
    }

    @:a function onEntityFocusChangeChunk(en:echoes.Entity,gp:GridPosition,f:Focused_Entity,c:ChunkCollisionLayer){
        var levels = ALL_LEVELS.entities;
        for(head in levels){
            var level = head.get(LevelComponent);
            if(level.i == gp.iw && level.j == gp.jw){
                if(!head.exists(Focused_Chunk)){
                    //trace("add new focus chunk at ch.i :"+ level.i+" ch.j"+level.j+"");
                    head.add(new Focused_Chunk());
                }
            }
            //head = head.next;
        }
    }

    @:u function removeFocusOnFocusedEntityOut(en:echoes.Entity,level:LevelComponent,f:Focused_Chunk){
        if(level.i != local_pos_x || level.j != local_pos_y)
            en.remove(Focused_Chunk);
    }

    @:u function getPositionString():String {
        var topleft:Bool = level_chunk_x < Const.CHUNK_SIZE/2 && level_chunk_y < Const.CHUNK_SIZE/2;
        var topright:Bool = level_chunk_x >= Const.CHUNK_SIZE/2 && level_chunk_y < Const.CHUNK_SIZE/2;
        var bottomleft:Bool = level_chunk_x < Const.CHUNK_SIZE/2 && level_chunk_y >= Const.CHUNK_SIZE/2;
        var bottomright:Bool = level_chunk_x >= Const.CHUNK_SIZE/2 && level_chunk_y >= Const.CHUNK_SIZE/2;
    
        if(topleft) {
            return "topleft";
        } else if(topright) {
            return "topright";
        } else if(bottomleft) {
            return "bottomleft";
        } else if(bottomright) {
            return "bottomright";
        } else {
            return "unknown";
        }
    }

    @:u function checkNeighbours(level:LevelComponent, focus:Focused_Chunk) {
        
        var position = getPositionString();

        if(position != last_position){
            removeActiveFlag();
            getNeighbours(position);
        }

        last_position = position; 
    }

    function removeActiveFlag() {
        var active_levels = ALL_ACTIVE_LEVELS.entities;
        for(head in active_levels){
            if(!head.exists(Focused_Chunk)){
                head.remove(Chunk_Active);
            }
           // head = head.next;
        }
    }

    function getNeighbours(position:String){
        var positions = [];
    
        switch(position) {
            case "topleft":
                positions = ["north", "west", "northwest"];
            case "topright":
                positions = ["north", "east", "northeast"];
            case "bottomleft":
                positions = ["south", "west", "southwest"];
            case "bottomright":
                positions = ["south", "east", "southeast"];
        }
    
        for(position in positions) {
            var i = local_pos_x;
            var j = local_pos_y;
    
            switch(position) {
                case "north":
                    j--;
                case "south":
                    j++;
                case "west":
                    i--;
                case "east":
                    i++;
                case "northwest":
                    i--;
                    j--;
                case "northeast":
                    i++;
                    j--;
                case "southwest":
                    i--;
                    j++;
                case "southeast":
                    i++;
                    j++;
            }
    
            var all_levels = ALL_LEVELS.entities;
            for (head in all_levels){
                var neighbour = head.get(LevelComponent);
                if(neighbour.i == i && neighbour.j == j){
                   head.add(new Chunk_Active());
                }
                //head = head.next;
            }
        }
    }

    @:u function swapChunkCollisionMask(en:echoes.Entity,gp:GridPosition,c:ChunkCollisionLayer){
        if(gp.iw != c.i || gp.jw != c.j){
            var levels = ALL_LEVELS.entities;
            for(head in levels){
                var level = head.get(LevelComponent);
                if(level.i == gp.iw && level.j == gp.jw){
                    en.remove(ChunkCollisionLayer);
                    en.add(new ChunkCollisionLayer(level.marks,level.i,level.j));
                    //trace("swap collision to i:"+ level.i + " j: "+ level.j+"");
                }
            //head = head.next;
            }
        }
    }
}