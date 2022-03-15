package aleiiioa.systems.renderer;

import hxd.BitmapData;
import h2d.Bitmap;
import h3d.Vector;
import h2d.SpriteBatch.BatchElement;

import aleiiioa.builders.Builders;
import aleiiioa.components.solver.CellComponent;
import aleiiioa.components.solver.LayerComponent;

import aleiiioa.shaders.PressureShader;



class SolverDebugRenderer extends echoes.System {
    
    var level(get,never) : Level; inline function get_level() return Game.ME.level;
    var width(get,never) : Int; inline function get_width() return Std.int(level.pxWid);
    var height(get,never): Int; inline function get_height()return Std.int(level.pxHei);
    
    var sbDirections : Array<h2d.SpriteBatch.BatchElement>;
    var gameScroller:h2d.Layers;
    var sb : h2d.SpriteBatch;
    var pressureBitmap:BitmapData;
    var bitmap:Bitmap;
    var shader:BitmapShader;
    

    public function new(_gameScroller:h2d.Layers) {
        this.gameScroller = _gameScroller;    
        this.sbDirections = [];
        this.sb = new h2d.SpriteBatch(h2d.Tile.fromColor(Color.makeColorRgb(1,1,1),Const.GRID,Const.GRID));
        this.sb.hasRotationScale = true;
        this.gameScroller.add(sb,Const.DP_FRONT);
        Builders.layerComponent(new BitmapShader());        
    }

    
    @a private function onCellComponentAdded(cc:CellComponent) {
        var vectorBatchElement = makeSpriteBatchVectorElement(cc.i,cc.j);
        sb.add(vectorBatchElement);
        sbDirections.push(vectorBatchElement);
    }

    @a function onLayerAdded(lc:LayerComponent){
        pressureBitmap = new hxd.BitmapData(level.cWid, level.cHei);
        lc.bitmap = new h2d.Bitmap(h2d.Tile.fromBitmap(pressureBitmap));
        lc.shader = new BitmapShader();
		lc.shader.texture = lc.bitmap.tile.getTexture();
		lc.bitmap.addShader(lc.shader);
        lc.bitmap.scaleX = width/level.cWid;
        lc.bitmap.scaleY = height/level.cHei;
        this.gameScroller.add(lc.bitmap,Const.DP_BG);
    }

    @u function systemUpdate(){
        if( ui.Console.ME.hasFlag("grid")){
            sb.visible = true;
        } 
        if(!ui.Console.ME.hasFlag("grid"))
            sb.visible = false;
    }

    @u function updatePressureBitmap(cc:CellComponent) {
        var uv  = new Vector(cc.u,cc.v);
        var uvl = uv.length();
        var col = new Vector(uvl*0.5,0,1-uvl*0.5,0.5);
        pressureBitmap.setPixel(cc.i, cc.j,col.toColor());

        if(sb.visible)
            sbDirections[cc.index].rotation = Math.atan2(cc.v,cc.u);   
    }

    @u function refreshLayer(lc:LayerComponent){
        lc.bitmap = new h2d.Bitmap(h2d.Tile.fromBitmap(pressureBitmap));
        lc.shader.texture = lc.bitmap.tile.getTexture();
    }

    @r function onLayerRemoved(lc:LayerComponent){
        lc.bitmap.remove();
    }


    
    private function makeSpriteBatchVectorElement(i:Int,j:Int){
        var vec = new BatchElement(Assets.tiles.getTile(D.tiles.vector12));
        vec.x = i*Const.GRID + Const.GRID/2;
        vec.y = j*Const.GRID + Const.GRID/2;
        vec.rotation = 0;
        return vec;
    }
 

}
