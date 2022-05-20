package aleiiioa.systems.renderer;

import aleiiioa.components.flags.cell.OnScreenFlag;
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
    var vectorLayer :h2d.Layers;
    var sb : h2d.SpriteBatch;
    var inOff = Const.FLUID_OFFSCREEN_TOP * Game.ME.level.cWid; // index offset for onscreen vector batch update

    public function new() {
          
        
        vectorLayer = new h2d.Layers();
        Game.ME.root.add(vectorLayer,Const.DP_FRONT);
		vectorLayer.name = "Vector Solver Debug";
        
        this.sbDirections = [];
        this.sb = new h2d.SpriteBatch(h2d.Tile.fromColor(Color.makeColorRgb(1,1,1),Const.GRID,Const.GRID));
        this.sb.hasRotationScale = true;
       
        vectorLayer.add(sb,Const.DP_FRONT);
        vectorLayer.setPosition(Game.ME.scroller.x,0);   
     }

    
    @a private function onCellComponentAdded(cc:CellComponent,onScreen:OnScreenFlag) {
        var vectorBatchElement = makeSpriteBatchVectorElement(cc.i,cc.j-Const.FLUID_OFFSCREEN_TOP);
        sb.add(vectorBatchElement);
        sbDirections.push(vectorBatchElement);
    }


    
    @u function systemUpdate(){
        vectorLayer.setPosition(Game.ME.scroller.x,0);  
        if( ui.Console.ME.hasFlag("grid")){
            sb.visible = true;
        } 
        if(!ui.Console.ME.hasFlag("grid"))
            sb.visible = false;
    }

    @u function updateSpriteBatchDebug(cc:CellComponent,onScreen:OnScreenFlag) {
        if( ui.Console.ME.hasFlag("grid")){
            if(sb.visible && cc.index-inOff < sbDirections.length){
                sbDirections[cc.index-inOff].rotation = Math.atan2(cc.v,cc.u);
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
