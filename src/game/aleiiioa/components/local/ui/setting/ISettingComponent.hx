package aleiiioa.components.local.ui.setting;

interface ISettingComponent {
    function next():Void;
    function prev():Void;
    function getCurrentDisplayValue():String;
    function setCurrentDisplayValue(value:String):Void;
    function getCurrentKey():Int;
    function setCurrentKey(value:Int):Void;
    function getDisplayText():String;
    function setDisplayText(value:String):Void;
    function getMappedValues():Map<String, Dynamic>;
    function setMappedValues(value:Map<String, Dynamic>):Void;
    function getKeys():Array<String>;
    function setKeys(value:Array<String>):Void;
    function getCurrentIndex():Int;
    function setCurrentIndex(value:Int):Void;
    function getCallback():Void->Void;
    function setCallback(value:Void->Void):Void;
}