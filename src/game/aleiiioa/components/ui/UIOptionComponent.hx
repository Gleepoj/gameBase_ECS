package aleiiioa.components.ui;

import dn.heaps.FlowBg;


class UIOptionComponent {
    
    
    public var text:String;
    public var isSelected:Bool;
    public var id:Int;
    public var flowObject:FlowBg;
 
    public function new(_text : String, _id:Int) {
        text = _text; 
        id   = _id;
        isSelected = false;
        flowObject = null;
    }
}