package aleiiioa.components.flags;

class TimeFlag {
    public var SPAWN_SEC:Int;
    public function new() {
        SPAWN_SEC = Math.floor(10*Math.random());
    }
}