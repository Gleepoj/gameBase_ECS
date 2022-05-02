package aleiiioa.components.gun;

import aleiiioa.components.gun.GunComponent;

class BulletComponent {
    public var ang:Float;
    public var speed:Float;
    public var friendly:Bool;
    public var radius:Int;
    
    public function new(gun:GunComponent) {
        ang = gun.ang;
        speed = gun.fireSpeed;
        friendly = gun.friendly;
        radius = gun.bulletRadius;
    }
}