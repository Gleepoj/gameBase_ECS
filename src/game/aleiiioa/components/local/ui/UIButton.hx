package aleiiioa.components.local.ui;

import h2d.ScaleGrid;

class UIButton {
    
    public var scaleGrid:ScaleGrid;
    public var label:h2d.Text;
    public var event:UI_Button_Event;
    
    public function new(l:h2d.Text){
        
        label = l;
    }
}