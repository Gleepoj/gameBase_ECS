package aleiiioa.systems.solver;

import h2d.Bitmap;
import h3d.Vector;
import h2d.SpriteBatch.BatchElement;

import aleiiioa.builders.Builders;
import aleiiioa.components.solver.CellComponent;
import aleiiioa.components.solver.LayerComponent;

import aleiiioa.shaders.PressureShader;



class SolverDebugRendering extends echoes.System {
    
    var level(get,never) : Level; inline function get_level() return Game.ME.level;
    var width(get,never) : Int; inline function get_width() return Std.int(level.pxWid);
    var height(get,never): Int; inline function get_height()return Std.int(level.pxHei);
    
	
    // a resoudre solver manager pour les fonction de test de grille //
    var solver: FluidSolver;
    var sbDirections : Array<h2d.SpriteBatch.BatchElement>;
    var gameScroller:h2d.Layers;
    var sb : h2d.SpriteBatch;
    var bitmap:Bitmap;
    var shader:BitmapShader;
    

    public function new(_gameScroller:h2d.Layers,fluidSolver:FluidSolver) {
        this.gameScroller = _gameScroller;
        this.solver = fluidSolver;    
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
        var b = makePressureBitmap();
        lc.bitmap = new h2d.Bitmap(h2d.Tile.fromBitmap(b));
        lc.shader = new BitmapShader();
		lc.shader.texture = lc.bitmap.tile.getTexture();
		lc.bitmap.addShader(lc.shader);
        lc.bitmap.height = height;
        lc.bitmap.width  = width;
        this.gameScroller.add(lc.bitmap,Const.DP_BG);
    }

    @u function systemUpdate(){
        if( ui.Console.ME.hasFlag("grid")){
            sb.visible = true;
        } 
        if(!ui.Console.ME.hasFlag("grid"))
            sb.visible = false;
    }

    @u function refreshLayer(lc:LayerComponent){
        var pressure = makePressureBitmap();
        lc.bitmap = new h2d.Bitmap(h2d.Tile.fromBitmap(pressure));
        lc.shader.texture = lc.bitmap.tile.getTexture();
    }

    @u function rotateVectorElement(cc:CellComponent){
        if(sb.visible)
            sbDirections[cc.index].rotation = Math.atan2(cc.v,cc.u);   
    }

    @r function onLayerRemoved(lc:LayerComponent){
        lc.bitmap.remove();
    }


    private function makePressureBitmap(){
        var bitmapPressure = new hxd.BitmapData(level.cWid, level.cHei);
        for( j in 0...level.cWid ){
        	for( i in 0...level.cHei){
                var index = solver.getIndexForCellPosition(i,j);
                var vec = solver.getUVVectorForIndexPosition(index);
                var uvl = vec.length();
                var color = new Vector(uvl*0.5,0,1-uvl*0.5,0.5);
                bitmapPressure.setPixel(i, j,color.toColor());
            }
        }
        return bitmapPressure;
    }
    
    private function makeSpriteBatchVectorElement(i:Int,j:Int){
        var vec = new BatchElement(Assets.tiles.getTile(D.tiles.vector12));
        vec.x = i*Const.GRID + Const.GRID/2;
        vec.y = j*Const.GRID + Const.GRID/2;
        vec.rotation = 0;
        return vec;
    }
 

}
