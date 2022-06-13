package aleiiioa.components.dialog;

import h2d.Layers;

class UIOption{
    public var layer:h2d.Layers;// new layer not flow 
    public var flow:h2d.Flow;
    
        
    public function new() {
        layer = new h2d.Layers();
        Game.ME.root.add(layer,Const.DP_UI);
		layer.name = "Option Layer";
    }
}
