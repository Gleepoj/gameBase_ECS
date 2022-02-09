package aleiiioa.components.solver;

import h2d.SpriteBatch.BatchElement;
class CellSpriteBatch {
    public var sb : h2d.SpriteBatch;
    public var sbCells : Array<h2d.SpriteBatch.BatchElement>;
    public var sbDirections : Array<h2d.SpriteBatch.BatchElement>;
    public var cellBE:h2d.SpriteBatch.BatchElement;
    public var vectorBE:h2d.SpriteBatch.BatchElement;
    
    public function new(){
        sbCells = [];
        sbDirections = [];
        sb = new h2d.SpriteBatch(h2d.Tile.fromColor(Color.makeColorRgb(1,1,1),Const.GRID,Const.GRID));
        vectorBE = new BatchElement(Assets.tiles.getTile(D.tiles.vector12));
        cellBE = new BatchElement(h2d.Tile.fromColor(Color.makeColorRgb(1,1,1),Const.GRID-1,Const.GRID-1));
    }
}