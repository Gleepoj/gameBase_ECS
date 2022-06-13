package aleiiioa.components.dialog;

import dn.Cooldown;
import aleiiioa.systems.dialog.DialogEvent.Event_Ask;
import aleiiioa.systems.dialog.DialogEvent;
import aleiiioa.systems.dialog.DialogEvent.Event_Speak;
import aleiiioa.systems.dialog.DialogEvent.Event_End;

class YarnDialogListener {
    
    //public var lastEvent:String;
    //public var newEvent:String;
    public var cd:Cooldown;

    public var events = new InstancedDialogEvent();
    public var lastEvent:DialogEvent;
    public var newEvent:DialogEvent;

    public var text:String;
    public var option:Array<String>;
    
    public var onAsk(get,never):Bool;
        inline function get_onAsk() return cd.has("ask") ;

    public var onSpeak(get,never):Bool;
        inline function get_onSpeak() return cd.has("speak");

    public var onEnd(get,never):Bool;
        inline function get_onEnd() return cd.has("end");
    
    public var onPause(get,never):Bool;
        inline function get_onPause() return  cd.has("pause");

    public function new() {
        lastEvent = null;
        newEvent = null;
        cd = new Cooldown(Const.FIXED_UPDATE_FPS);
    }
}

/* public var onAsk(get,never):Bool;
inline function get_onAsk() return newEvent == events.ask && lastEvent != newEvent ;

public var onSpeak(get,never):Bool;
inline function get_onSpeak() return newEvent == events.speak && lastEvent != newEvent;

public var onEnd(get,never):Bool;
inline function get_onEnd() return newEvent == events.end && lastEvent != newEvent;

public var onPause(get,never):Bool;
inline function get_onPause() return  lastEvent == newEvent;
 */