package aleiiioa.components.local.ui;

import h2d.ScaleGrid;

class UIButton {
    
    public var scaleGrid:ScaleGrid;
    public var label:h2d.Text;
    
    public var event:UI_Button_Event;
    public var interactive:h2d.Interactive;
    
    public var embedded_function:Void->Void;

    public var onNext:Bool = false;
    public var onPrev:Bool = false;
    public var onUndefined:Bool = false;


    public function new(l:h2d.Text){
        
        label = l;
    }
}