package aleiiioa;

import solv.Modifier;
import aleiiioa.ICommand;

class Invoker {

    var puppet:Modifier;
    public var curl:Curl;
    public var diverge:Diverge;
    public var converge:Converge;

    public function new(m:Modifier) {
        puppet = m;
        curl = new Curl(puppet);
        diverge = new Diverge(puppet);
        converge = new Converge(puppet);
        
    }

}