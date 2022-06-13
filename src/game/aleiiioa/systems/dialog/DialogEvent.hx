package aleiiioa.systems.dialog;

import aleiiioa.components.dialog.YarnDialogListener;
// enum instead of string ? 

interface DialogEvent {
    public function send(dl:YarnDialogListener):Void;    
}

class Event_End implements  DialogEvent {
    public function new() {
    }

    public function send(dl:YarnDialogListener) {
        dl.cd.setS("end",0.2);
        //trace("end");
    }
}

class Event_Speak implements  DialogEvent {
    public function new() {
    }

    public function send(dl:YarnDialogListener) {
        dl.cd.setS("speak",0.2);
        //trace("speak"); 
    }
}

class Event_Ask implements  DialogEvent {
    public function new() {
    }
    
    public function send(dl:YarnDialogListener) {
        //dl.lastEvent = dl.newEvent; 
        dl.cd.setS("ask",0.2); 
        //trace("ask");
    }
}


class InstancedDialogEvent {
    public var ask   :Event_Ask;
    public var speak :Event_Speak;
    public var end   :Event_End;

    public function new() {
        speak = new Event_Speak();
        end   = new Event_End();
        ask   = new Event_Ask();
    }
    
}