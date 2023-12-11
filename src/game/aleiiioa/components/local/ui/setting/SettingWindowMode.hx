package aleiiioa.components.local.ui.setting;

import hxd.Window;


class SettingWindowMode implements ISettingComponent {

    public var current_display_value:String = "bannane plantain";
    public var current_key:Int;
    public var display_text:String = "..";
    public var mapped_values:Map<String, Dynamic> = new Map();
    public var keys:Array<String> = [];
    public var currentIndex:Int = 0;
    public var callback:Void->Void;

    public function new(){
        
        addResolution("Windowed", Windowed);
        addResolution("Borderless", Borderless);
        addResolution("Fullscreen", Fullscreen);
        
        updateDisplayValue();

        callback = function(){      
            var mode = mapped_values.get(keys[currentIndex]);
            var w = hxd.Window.getInstance();
            w.displayMode = mode;
            //w.applyDisplay();
        };
    }

    public function addResolution(key:String, value:DisplayMode) {
        mapped_values.set(key, value);
        keys.push(key);
    }

    public function next(){
        currentIndex ++;
        updateDisplayValue();
        callback(); 
    }

    public function prev(){
        currentIndex --;
        updateDisplayValue();
        callback();
    }

    private function updateDisplayValue():Void {
        
        if (currentIndex < 0) {
            currentIndex = keys.length - 1;
        } else if (currentIndex >= keys.length) {
            currentIndex = 0;
        }

        var key = keys[currentIndex];
        current_display_value = '$key';
        display_text = current_display_value;
    }

    public function getDisplayText():String {
        return display_text;
    }

}