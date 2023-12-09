package aleiiioa.components.local.ui;

import hxd.Window;
import hxd.System;

class UIModalSetting {
 
    public var text:h2d.Text = new h2d.Text(hxd.res.DefaultFont.get());
  
    public function new(){
    
    }

    public function refresh(_text:String){
        text.text = _text;
    }

}