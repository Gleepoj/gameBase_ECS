package aleiiioa;

import solv.Modifier;
//import aleiiioa.ICommand;
interface ICommand {
    public  function execute():Void;
}


class Curl implements  ICommand {
    var puppet:Modifier;
    public function new(e:Modifier) {
        puppet = e;
    }
    public function execute() {
        puppet.changeEquationType(EqCurl);
        puppet.activateModifier();
        
    }
}

class Converge implements  ICommand {
    var puppet:Modifier;
    public function new(e:Modifier) {
        puppet = e;
    }
    public function execute() {
        puppet.activateModifier();
    }
}
class Diverge implements  ICommand {
    var puppet:Modifier;
    public function new(e:Modifier) {
        puppet = e;
    }
    public function execute() {
        puppet.changeEquationType(EqDiverge);
        puppet.activateModifier();
        trace("ok diverge");
    }
}