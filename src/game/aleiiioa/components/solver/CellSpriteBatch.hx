package aleiiioa.components.solver;

class CellSpriteBatch {
    public var sb : h2d.SpriteBatch;
    public var sbCells : Array<h2d.SpriteBatch.BatchElement>;
    public var sbDirections : Array<h2d.SpriteBatch.BatchElement>;
    
    public function new(){
        sbCells = [];
        sbDirections = [];
        sb = new h2d.SpriteBatch(h2d.Tile.fromColor(Color.makeColorRgb(1,1,1),Const.GRID,Const.GRID));

    }
}