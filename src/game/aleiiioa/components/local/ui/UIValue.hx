package aleiiioa.components.local.ui;

import h2d.Text;
import haxe.ds.Map;

class UIValue {
    //public var parameters:Map<Dynamic<>,Int> = new Map();
    public var current_key:Int = 0;
    public var text:Text;

    public function new(txt){
        text = txt;
    }
}