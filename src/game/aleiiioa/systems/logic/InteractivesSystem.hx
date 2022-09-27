package aleiiioa.systems.logic;

import aleiiioa.components.flags.logic.CatchableFlag;
import echoes.Entity;
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
    var ALL_CATCHABLE:View<CatchableFlag,InteractiveComponent>;
    
    public function new() {
        
    }
    @u function bombBehavior(dt:Float,cl:CollisionsListener,bf:BombFlag,ic:InteractiveComponent,em:EmitterComponent,gp:GridPosition){
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

    @u function playerGrabObject(pl:PlayerFlag,cl:CollisionsListener,inp:InputComponent,ac:ActionComponent) {
        if(cl.onInteract && inp.ca.isPressed(ShapeWind)){
            ac.query = true;
        }
    }


    @u function playerThrowObject(pl:PlayerFlag,inp:InputComponent,ac:ActionComponent,vc:VelocityComponent){
        if(ac.grab && inp.ca.isPressed(ShapeWind)){
            var head = ALL_CATCHABLE.entities.head;

            while (head != null){
                var catchable = head.value;
                var catchableIc = catchable.get(InteractiveComponent);
                if(catchableIc.isGrabbed){
                    unlinkObject(catchable);
                    throwObject(catchable,vc);
                }
                head = head.next;
            }
        }
    }

    @u function catchableIsGrabbedByPlayer(en:echoes.Entity,catchable:CatchableFlag,cl:CollisionsListener) {
        if(cl.onInteract){
            var head = ALL_PLAYERS.entities.head;
    
            while (head != null){
                var player = head.value;
                var playerAc:ActionComponent  = player.get(ActionComponent);

                if(playerAc.query){  
                    var mgp = player.get(MasterGridPosition);
                    linkObject(en,mgp);
                    playerAc.grab = true;
                    playerAc.query= false;
                }
                head = head.next;
            }
        }
    }
    

    function linkObject(en:echoes.Entity,mgp:MasterGridPosition) {
        en.add(new GridPositionOffset(0,-1));
        en.add(mgp);
        en.add(new ChildFlag());
        en.get(InteractiveComponent).isGrabbed = true;           
    }

    function unlinkObject(en:echoes.Entity) {
        en.get(InteractiveComponent).isGrabbed = false;
        en.remove(MasterGridPosition);
        en.remove(GridPositionOffset);
        en.remove(ChildFlag);
    }

    function throwObject(en:echoes.Entity,vc:VelocityComponent){ 
        en.get(VelocityAnalogSpeed).xSpeed = vc.dx * 20;
        en.get(VelocityAnalogSpeed).ySpeed = -2;
    }

}