package aleiiioa;

import solv.Modifier;

interface ICommand {
    public  function execute(m:Modifier):Void;
}


class Curl implements  ICommand {
    public function new() {
    }

    public function execute(m:Modifier) {
        m.changeEquationType(EqCurl);
        m.activateModifier();
        
    }
}

class Converge implements  ICommand {
    public function new() {
        
    }
    public function execute(m:Modifier) {
        m.changeEquationType(EqCurl);
        m.activateModifier();
    }
}

class Diverge implements  ICommand {
    
    public function new() {
        
    }

    public function execute(m:Modifier) {
        m.changeEquationType(EqDiverge);
        m.activateModifier();
    }
}

class TurnOff implements  ICommand {
    
    public function new() {
        
    }
    
    public function execute(m:Modifier) {
        m.deactivateModifier();
    }
}