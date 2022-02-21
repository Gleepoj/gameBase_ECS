package aleiiioa.systems.collisions;

import aleiiioa.components.InputComponent;
import aleiiioa.components.core.GridPosition;
import echoes.View;
import aleiiioa.components.BulletComponent;
import aleiiioa.components.core.VelocityAnalogSpeed;


class BulletCollisionSystem extends echoes.System {
    var ALL_BULLETS:View<GridPosition,BulletComponent>;
    public function new() {
        
    }
    @a function onBulletAdded(vas:VelocityAnalogSpeed,bul:BulletComponent) {
        vas.xSpeed = Math.cos(bul.ang)*bul.speed;
        vas.ySpeed = Math.sin(bul.ang)*bul.speed;
    }
    @u function bulletCollideWithPlayer(inp:InputComponent,gp:GridPosition) {
        
        var head = ALL_BULLETS.entities.head;
        var vecPos = gp.gpToVector();
        while (head != null){
            var bullet = head.value;
            var friendBullet = bullet.get(BulletComponent).friendly;
            if (!friendBullet){
                var vecBullet = bullet.get(GridPosition).gpToVector();
                if(vecPos.distance(vecBullet)<20){
                    trace("player collide with ennemy bullet");
                }
            }
            head = head.next;
        }
    }
}