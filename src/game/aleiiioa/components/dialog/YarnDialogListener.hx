package aleiiioa.components.dialog;

import aleiiioa.systems.dialog.DialogEvent;
import aleiiioa.systems.dialog.DialogEvent.Event_Speak;
import aleiiioa.systems.dialog.DialogEvent.Event_End;

class YarnDialogListener {
    
    public var lastEvent:String;
    public var newEvent:String;

    public var onAsk(get,never):Bool;
        inline function get_onAsk() return lastEvent == "ask" && lastEvent != newEvent ;

    public var onSpeak(get,never):Bool;
        inline function get_onSpeak() return lastEvent == "speak" && lastEvent != newEvent;

    public var onEnd(get,never):Bool;
        inline function get_onEnd() return lastEvent == "end" && lastEvent != newEvent;

    public function new() {
        lastEvent = null;
        newEvent = null;
    }
}