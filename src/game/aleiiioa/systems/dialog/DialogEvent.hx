package aleiiioa.systems.dialog;

import aleiiioa.components.dialog.YarnDialogListener;


interface DialogEvent {
    public function send(dl:YarnDialogListener):Void;    
}

class Event_End implements  DialogEvent {
    public function new() {
    }

    public function send(dl:YarnDialogListener) {
        dl.lastEvent = dl.newEvent; 
        dl.newEvent = "end";
    }
}

class Event_Speak implements  DialogEvent {
    public function new() {
    }

    public function send(dl:YarnDialogListener) {
        dl.lastEvent = dl.newEvent; 
        dl.newEvent = "speak"; 
    }
}

class Event_Ask implements  DialogEvent {
    public function new() {
    }
    
    public function send(dl:YarnDialogListener) {
        dl.lastEvent = dl.newEvent;  
        dl.newEvent = "ask";
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