package aleiiioa.systems.logic;

import aleiiioa.builders.FxBuilders;
import aleiiioa.components.particules.EmitterComponent;
import aleiiioa.components.core.velocity.VelocityComponent;
import echoes.View;
import aleiiioa.components.flags.BombFlag;
import aleiiioa.components.core.position.MasterGridPosition;
import aleiiioa.components.core.position.GridPositionOffset;
import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.logic.*;
import aleiiioa.components.flags.PlayerFlag;
import aleiiioa.components.flags.hierarchy.*;
import aleiiioa.components.core.velocity.VelocityAnalogSpeed;

import aleiiioa.components.InputComponent;
import aleiiioa.components.core.collision.CollisionsListener;

class InteractivesSystem extends echoes.System {
    var ALL_PLAYERS :View<GridPosition,PlayerFlag>;
    var ALL_BOMB:View<BombFlag>;
    
    public function new() {
        
    }
    @u function unsetStatus(dt:Float,cl:CollisionsListener,bf:BombFlag,ic:InteractiveComponent,em:EmitterComponent,gp:GridPosition){
        ic.cd.update(dt);
        
        if(ic.isGrabbed && !ic.cd.has("countdown")){
            ic.cd.setS("countdown",3);
            //trace("set cd");
        }
        
        if(ic.cd.has("countdown")){
            //trace(ic.cd.getRatio("countdown"));
            if(ic.cd.getRatio("countdown") <= 0.05){
             FxBuilders.bombSmoke(em,gp);
            }
        }

    }

    @u function playerGrabBomb(cl:CollisionsListener,inp:InputComponent,pl:PlayerFlag,ac:ActionComponent) {
        if(cl.onInteract && inp.ca.isPressed(ShapeWind)){
            ac.query = true;
        }
    }

    
    @u function throwBomb(en:echoes.Entity,cl:CollisionsListener,inp:InputComponent,pl:PlayerFlag,ac:ActionComponent,vc:VelocityComponent){
        if(ac.grab && inp.ca.isPressed(ShapeWind)){
            var head = ALL_BOMB.entities.head;

            while (head != null){
                var bomb = head.value;
                var bombIc = bomb.get(InteractiveComponent);
                if(bombIc.isGrabbed){
                    bomb.get(InteractiveComponent).isGrabbed = false;
                    bomb.get(VelocityAnalogSpeed).xSpeed = vc.dx * 20;
                    bomb.get(VelocityAnalogSpeed).ySpeed = -2;
                    bomb.remove(MasterGridPosition);
                    bomb.remove(GridPositionOffset);
                    bomb.remove(ChildFlag);
                    en.remove(MasterFlag);
                    en.remove(MasterGridPosition);
                }
                head = head.next;
            }
        }
    }

    @u function BombIsGrabbedByPlayer(en:echoes.Entity,cl:CollisionsListener,b:BombFlag) {
        
        if(cl.onInteract){
            var head = ALL_PLAYERS.entities.head;
        
    
            while (head != null){
                var player = head.value;
                var playerPos:GridPosition = player.get(GridPosition);
                var playerAc:ActionComponent  = player.get(ActionComponent);
                var playerInteract = player.get(ActionComponent).query;
                if(playerInteract){
                    en.add(new GridPositionOffset(0,-1));
                    var mgp = new MasterGridPosition(playerPos.cx,playerPos.cy);
                    en.add(mgp);
                    en.add(new ChildFlag());
                    en.get(InteractiveComponent).isGrabbed = true;
                    player.add(new MasterFlag());
                    player.add(mgp);
                    playerAc.grab = true;
                    playerAc.query= false;
                    
                }
                
                head = head.next;
            }
        }
    }

}