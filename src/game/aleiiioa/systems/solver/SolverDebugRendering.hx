package aleiiioa.systems.solver;

import aleiiioa.components.solver.CellSpriteBatch;
import aleiiioa.components.solver.CellComponent;

import h3d.Vector;
import h2d.SpriteBatch.BatchElement;


class SolverDebugRendering extends echoes.System {
    private var game(get,never) : Game; inline function get_game() return Game.ME;
	
    // a resoudre solver manager pour les fonction de test de grille //
    var solver: FluidSolver;
   // var selectedCells:Array<Int>;
    
    var gameScroller:h2d.Layers;
    var sb : h2d.SpriteBatch;
    var sbCells : Array<h2d.SpriteBatch.BatchElement>;
    var sbDirections : Array<h2d.SpriteBatch.BatchElement>;
    
    

    public function new(_gameScroller:h2d.Layers,_fluidSolver:FluidSolver) {
        this.gameScroller = _gameScroller;
        this.solver = _fluidSolver;
        //fillDebugSpriteBatch();  
        this.sbCells = [];
        this.sbDirections = [];
        this.sb = new h2d.SpriteBatch(h2d.Tile.fromColor(Color.makeColorRgb(1,1,1),Const.GRID,Const.GRID));
        
        this.gameScroller.add(sb,Const.DP_SOLVER);
        sb.blendMode = Add;
        sb.hasUpdate = true;
        sb.hasRotationScale = true;
        sb.visible = true;
        createCellComponents();
    }
    
    public function renderDebugGrid() {
        
        if( ui.Console.ME.hasFlag("grid")){
            sb.visible = true;
            
            for(index in 0...sbCells.length){
                //var uvl = new Vector(solver.u[index],solver.v[index]).lengthSq();
                //colorizePressure(index,uvl);
                //rotateVectorElement(index,uvl);
            }
            
            //lightSelectedCells();
            
        } 
        if(!ui.Console.ME.hasFlag("grid"))
            sb.visible = false;
    }

    @u public function renderCells() {
    }

    @r public function dispose(csb:CellSpriteBatch) {
        sb.remove();
        sbCells = [];
        sbDirections = [];
    }

    private function createCellComponents() {
        for(j in 0...solver.height) {
			for(i in 0...solver.width) {
                var cc = new CellComponent(i,j);
                new echoes.Entity().add(cc);
            }
        }
    }

    @a private function onCellComponentAdded(cc:CellComponent) {
        var cellBatchElement = makeSpriteBatchCellElement(cc.i,cc.j);
        sb.add(cellBatchElement);
        sbCells.push(cellBatchElement);
        var vectorBatchElement = makeSpriteBatchVectorElement(cc.i,cc.j);
        sb.add(vectorBatchElement);
        sbDirections.push(vectorBatchElement);

    }
    
    private function makeSpriteBatchCellElement(i:Int,j:Int){
        var squareCell = new BatchElement(h2d.Tile.fromColor(Color.makeColorRgb(1,1,1),Const.GRID-1,Const.GRID-1));
                squareCell.x = i*Const.GRID;
                squareCell.y = j*Const.GRID;
                squareCell.a = 0.3;
        return squareCell;      
    }

    private function makeSpriteBatchVectorElement(i:Int,j:Int){
        var vec = new BatchElement(Assets.tiles.getTile(D.tiles.vector12));
        vec.x = i*Const.GRID + Const.GRID/2;
        vec.y = j*Const.GRID + Const.GRID/2;
        vec.rotation = 0;
        return vec;
    }

    private function makeSpriteCellElement(i:Int,j:Int){
        var squareCell = new BatchElement(h2d.Tile.fromColor(Color.makeColorRgb(1,1,1),Const.GRID-1,Const.GRID-1));
                squareCell.x = i*Const.GRID;
                squareCell.y = j*Const.GRID;
                squareCell.a = 0.3;
        return squareCell;      
    }

    private function makeSpriteVectorElement(i:Int,j:Int){
        var vec = new BatchElement(Assets.tiles.getTile(D.tiles.vector12));
        vec.x = i*Const.GRID + Const.GRID/2;
        vec.y = j*Const.GRID + Const.GRID/2;
        vec.rotation = 0;
        return vec;
    }

    /* private function rotateVectorElement(index:Int,lenghtUV:Float) {
        sbDirections[index].rotation = Math.atan2(solver.v[index],solver.u[index]);
        sbDirections[index].a = lenghtUV;     
    }
    
    private function colorizePressure(index:Int,lenghtUV:Float){
        sbCells[index].r = lenghtUV;
        sbCells[index].g = 0;
        sbCells[index].b = 1-lenghtUV;
    }

    private function turnOffCellVisibility(index:Int) {
        sbCells[index].visible = false;
    }

    private function lightSelectedCells() {
        
        for (index in selectedCells){
            if(solver.checkIfIndexIsInArray(index)){
                sbCells[index].r = 1;
                sbCells[index].g = 1;
                sbCells[index].b = 1;
            }
        }
    }
 */
}