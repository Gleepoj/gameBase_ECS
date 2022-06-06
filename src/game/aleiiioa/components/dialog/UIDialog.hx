package aleiiioa.components.dialog;

class UIDialog {
    
    public var dialogLayer:h2d.Layers;

    public function new() {
        var dialogLayer = new h2d.Layers();
        Game.ME.root.add(dialogLayer,Const.DP_UI);
		dialogLayer.name = "Dialog system";
		
    }
}