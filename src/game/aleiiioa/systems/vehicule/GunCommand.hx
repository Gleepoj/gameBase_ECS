package aleiiioa.systems.vehicule;

import aleiiioa.components.gun.GunComponent;


interface GunCommand {
    public  function execute(gun:GunComponent):Void;
}


class PrimaryFire implements  GunCommand {
    public function new() {
    }

    public function execute(gun:GunComponent) {
        gun.setFireOn();
    }
}

class SecondaryFire implements GunCommand {
    public function new() {
        
    }

    public function execute(gun:GunComponent) {
        //gun.fireBullet();
    }
}
class TurnOffGun implements  GunCommand {
    public function new() {
    }

    public function execute(gun:GunComponent) {
        gun.setFireOff();
    }
}



class InstancedGunCommands {
    
    public var primary   :PrimaryFire;
    public var secondary :SecondaryFire;
    public var turnOff   :TurnOffGun;
   

    public function new() {
        primary     = new PrimaryFire();
        secondary   = new SecondaryFire();
        turnOff     = new TurnOffGun();
       
    }
    
}