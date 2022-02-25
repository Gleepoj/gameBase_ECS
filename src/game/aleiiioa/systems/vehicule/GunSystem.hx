package aleiiioa.systems.vehicule;

import aleiiioa.builders.Builders;
import aleiiioa.components.core.GridPosition;
import aleiiioa.components.core.VelocityAnalogSpeed;
import aleiiioa.components.BulletComponent;
import aleiiioa.components.vehicule.GunComponent;
import aleiiioa.systems.vehicule.GunCommand;

class GunSystem extends echoes.System {
    var commands = new InstancedGunCommands();
    public function new() {
       
    }

    @a function onBulletAdded(vas:VelocityAnalogSpeed,bul:BulletComponent) {
        vas.xSpeed = Math.cos(bul.ang)*bul.speed;
        vas.ySpeed = Math.sin(bul.ang)*bul.speed;
    }
    
    @a function onGunAdded(gun:GunComponent) {
        gun.currentCommand = commands.primary;
        gun.currentCommand.execute(gun);        
    }

    @u function updateGunComponent(gun:GunComponent,gp:GridPosition){
        gun.cd.update(1);
        
        if(gun.onFire)
            if(!gun.cd.has("fire"))
                fireBullet(gun,gp);
    }

    function fireBullet(gun:GunComponent,gp:GridPosition) {
        //gun.cd.setS("fire",gun.fireRate);
        gun.cd.setF("fire",gun.fireRate);
        if(!gun.friendly)
            Builders.ennemyBullet(gp,gun);
        if(gun.friendly)
            Builders.friendlyBullet(gp,gun);
    }
}