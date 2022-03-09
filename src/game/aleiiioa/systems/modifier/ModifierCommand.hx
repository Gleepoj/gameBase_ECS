package aleiiioa.systems.modifier;

import aleiiioa.components.solver.ModifierComponent;


interface ModifierCommand {
    public  function execute(mod:ModifierComponent):Void;
}


class Curl implements  ModifierCommand {
    public function new() {
    }

    public function execute(mod:ModifierComponent) {
        mod.changeEquationType(EqCurl);
        mod.activateModifier();
        
    }
}

class Converge implements  ModifierCommand {
    public function new() {
        
    }
    public function execute(mod:ModifierComponent) {
        mod.changeEquationType(EqCurl);
        mod.activateModifier();
    }
}

class Diverge implements  ModifierCommand {
    
    public function new() {
        
    }

    public function execute(mod:ModifierComponent) {
        mod.changeEquationType(EqDiverge);
        mod.activateModifier();
    }
}


class Repel implements  ModifierCommand {
    
    public function new() {
        
    }

    public function execute(mod:ModifierComponent) {
        mod.changeEquationType(EqRepel);
        mod.activateModifier();
    }
}
class TurnOn implements  ModifierCommand {
    
    public function new() {
        
    }

    public function execute(mod:ModifierComponent) {
        mod.changeEquationType(mod.areaEquation);
        mod.activateModifier();
    }
}

class TurnOff implements  ModifierCommand {
    
    public function new() {
        
    }
    
    public function execute(mod:ModifierComponent) {
        mod.deactivateModifier();
    }
}

class InstancedCommands {
    
    public var curl    :Curl;
    public var diverge :Diverge;
    public var converge:Converge;
	public var repel   :Repel;
	public var turnOff :TurnOff;
    public var turnOn  :TurnOn;

    public function new() {
        curl     = new Curl();
        diverge  = new Diverge();
        converge = new Converge();
        repel    = new Repel();
        turnOff  = new TurnOff();
        turnOn   = new TurnOn();
    }
    
}