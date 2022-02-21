package aleiiioa.systems.vehicule;

import aleiiioa.builders.Builders;
import aleiiioa.components.core.GridPosition;
import aleiiioa.components.core.VelocityAnalogSpeed;
import aleiiioa.components.BulletComponent;
import aleiiioa.components.vehicule.GunComponent;

class GunSystem extends echoes.System {
    
    public function new() {
        
    }
    @a function onBulletAdded(vas:VelocityAnalogSpeed,bul:BulletComponent) {
        vas.ySpeed = -1;
    }
    @a function onGunAdded(gun:GunComponent) {
        gun.cd.setS("fire",gun.fireRate);
    }
    @u function updateCooldown(dt:Float,gun:GunComponent,gp:GridPosition){
        gun.cd.update(dt);
        
        if(!gun.cd.has("fire"))
            fireBullet(gun,gp);
    }

    function fireBullet(gun:GunComponent,gp:GridPosition) {
        gun.cd.setS("fire",gun.fireRate);
        Builders.bullet(gp.cx,gp.cy,gp.xr,gp.yr);
    }
}