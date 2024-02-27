package aleiiioa.components.local.ui.setting;

class SettingSfx implements ISettingComponent{

    public var current_display_value:String = "bannane plantain";
    public var current_key:Int;
    public var display_text:String = "..";
    public var mapped_values:Map<String, Dynamic> = new Map();
    public var keys:Array<String> = [];
    public var currentIndex:Int = 2;
    public var callback:Void->Void;

    public function new(){
        
        addResolution("800", 1);
        addResolution("108",2);
        addResolution("H", 3);
        addResolution("llH",4);
        addResolution("ss",5);
     
 
        updateDisplayValue();

        callback = function(){      
            var partenule = mapped_values.get(keys[currentIndex]);
        
        };
    }
 
    public function addResolution(key:String, value:Int):Void {
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
            currentIndex = 0;
        } else if (currentIndex > keys.length-1) {
            currentIndex = keys.length-1;
        }

        var key = keys[currentIndex];
        var resolution = mapped_values.get(key);
        current_display_value = '$resolution';
        display_text = current_display_value;
    }

 
    public function getDisplayText():String {
        return display_text;
    }


}