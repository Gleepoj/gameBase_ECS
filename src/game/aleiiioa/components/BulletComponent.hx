package aleiiioa.components;

import aleiiioa.components.vehicule.GunComponent;

class BulletComponent {
    public var ang:Float;
    public var speed:Float;
    public var friendly:Bool;
    
    public function new(gun:GunComponent) {
        ang = gun.ang;
        speed = gun.fireSpeed;
        friendly = gun.friendly;
    }
}