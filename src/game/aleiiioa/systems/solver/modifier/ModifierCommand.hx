/* package aleiiioa.systems.solver.modifier;


interface ModifierCommand {
    public  function execute(m:Modifier):Void;
}


class Curl implements  ModifierCommand {
    public function new() {
    }

    public function execute(m:Modifier) {
        m.changeEquationType(EqCurl);
        m.activateModifier();
        
    }
}

class Converge implements  ModifierCommand {
    public function new() {
        
    }
    public function execute(m:Modifier) {
        m.changeEquationType(EqCurl);
        m.activateModifier();
    }
}

class Diverge implements  ModifierCommand {
    
    public function new() {
        
    }

    public function execute(m:Modifier) {
        m.changeEquationType(EqDiverge);
        m.activateModifier();
    }
}


class Repel implements  ModifierCommand {
    
    public function new() {
        
    }

    public function execute(m:Modifier) {
        m.changeEquationType(EqRepel);
        m.activateModifier();
    }
}

class TurnOff implements  ModifierCommand {
    
    public function new() {
        
    }
    
    public function execute(m:Modifier) {
        m.deactivateModifier();
    }
}

class InstancedCommands {
    
    public var curl:Curl;
    public var diverge:Diverge;
    public var converge:Converge;
	public var repel:Repel;
	public var turnOff:TurnOff;

    public function new() {
        curl     = new Curl();
        diverge  = new Diverge();
        converge = new Converge();
        repel    = new Repel();
        turnOff  = new TurnOff();
    }
    
} */