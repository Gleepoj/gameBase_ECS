package aleiiioa.systems.renderer;

import hxd.Math;
import h2d.SpriteBatch.BatchElement;

import echoes.Entity;

import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.solver.CellComponent;




class SolverDebugRenderer extends echoes.System {
    
    var level(get,never) : Level; inline function get_level() return Game.ME.level;
    var game(get,never) : Game; inline function get_game() return Game.ME;

    var width(get,never) : Int; inline function get_width() return Std.int(level.pxWid);
    var height(get,never): Int; inline function get_height()return Std.int(level.pxHei);
    
    var sbDirections : Array<h2d.SpriteBatch.BatchElement>;
    var gameScroller:h2d.Layers;
    var sb : h2d.SpriteBatch;
   

    public function new(_gameScroller:h2d.Layers) {
        this.gameScroller = _gameScroller;    
        this.sbDirections = [];
        this.sb = new h2d.SpriteBatch(h2d.Tile.fromColor(Color.makeColorRgb(1,1,1),Const.GRID,Const.GRID));
        this.sb.hasRotationScale = true;
        this.gameScroller.add(sb,Const.DP_FRONT);
    }

    
    @a private function onCellComponentAdded(cc:CellComponent) {
        var vectorBatchElement = makeSpriteBatchVectorElement(cc.i,cc.j);
        sb.add(vectorBatchElement);
        sbDirections.push(vectorBatchElement);
    }
    
    @u function systemUpdate(){
        
        if( ui.Console.ME.hasFlag("grid")){
            sb.visible = true;
        } 
        if(!ui.Console.ME.hasFlag("grid"))
            sb.visible = false;
    }

    @u function updateSpriteBatchDebug(cc:CellComponent,gp:GridPosition) {
        
        if( ui.Console.ME.hasFlag("grid")){
            if(sb.visible && cc.index < sbDirections.length){
                sbDirections[cc.index].rotation = Math.atan2(cc.v,cc.u);
                sbDirections[cc.index].y = gp.attachY;
            }
        }    
    }

    
    private function makeSpriteBatchVectorElement(i:Int,j:Int){
        var vec = new BatchElement(Assets.tiles.getTile(D.tiles.vector12));
        vec.x = i*Const.GRID + Const.GRID/2;
        vec.y = j*Const.GRID + Const.GRID/2;
        vec.rotation = 0;
        return vec;
    }
 

}
