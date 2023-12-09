package aleiiioa.components.local.ui.setting;

class SettingResolution implements ISettingComponent {
    
    public var current_display_value:String = "bannane plantain";
    public var current_key:Int;
    public var display_text:String = "..";
    public var mapped_values:Map<String, Dynamic> = new Map();
    public var keys:Array<String> = [];
    public var currentIndex:Int = 0;
    public var callback:Void->Void;

    public function new(){
        
        addResolution("800x600", {width: 800, height: 600});
        addResolution("1024x768", {width: 1024, height: 768});
        addResolution("HD", {width: 1280, height: 720});
        addResolution("Full HD", {width: 1920, height: 1080});
        addResolution("2K", {width: 2560, height: 1440});
        addResolution("4K", {width: 3840, height: 2160});
 
        updateDisplayValue();

        callback = function(){      
            var resolution = mapped_values.get(keys[currentIndex]);
            var w = hxd.Window.getInstance();
            w.resize(resolution.width, resolution.height);
        };
    }

    public function addResolution(key:String, value:{width:Int, height:Int}):Void {
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
        var resolution = mapped_values.get(key);
        current_display_value = '${resolution.width}x${resolution.height}';
        display_text = current_display_value;
    }

    public function getCurrentDisplayValue():String {
        return current_display_value;
    }

    public function setCurrentDisplayValue(value:String):Void {
        current_display_value = value;
    }

    public function getCurrentKey():Int {
        return current_key;
    }

    public function setCurrentKey(value:Int):Void {
        current_key = value;
    }

    public function getDisplayText():String {
        return display_text;
    }

    public function setDisplayText(value:String):Void {
        display_text = value;
    }

    public function getMappedValues():Map<String, Dynamic> {
        return mapped_values;
    }

    public function setMappedValues(value:Map<String, Dynamic>):Void {
        mapped_values = value;
    }

    public function getKeys():Array<String> {
        return keys;
    }

    public function setKeys(value:Array<String>):Void {
        keys = value;
    }

    public function getCurrentIndex():Int {
        return currentIndex;
    }

    public function setCurrentIndex(value:Int):Void {
        currentIndex = value;
    }

    public function getCallback():Void->Void {
        return callback;
    }

    public function setCallback(value:Void->Void):Void {
        callback = value;
    }

}