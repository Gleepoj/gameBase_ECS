package aleiiioa.components.core.input;

import hxd.Pad.PadConfig;


class InputComponent {
  public var ca : ControllerAccess<GameAction>;
  public var conf:PadConfig;
  public var cd :dn.Cooldown;
  
  // For UI Navigation 
  public var joy_down_ratio:Float = 0.;
  public var joy_up_ratio:Float   = 0.;
  public var joy_left_ratio:Float = 0.;
  public var joy_right_ratio:Float= 0.;

  public var isPressedDownAnalog(get,never) :Bool;inline function get_isPressedDownAnalog() return joy_down_ratio == 1;
  public var isPressedUpAnalog(get,never)   :Bool;inline function get_isPressedUpAnalog()   return joy_up_ratio == 1;
  public var isPressedRightAnalog(get,never):Bool;inline function get_isPressedRightAnalog()return joy_right_ratio == 1;
  public var isPressedLeftAnalog(get,never) :Bool;inline function get_isPressedLeftAnalog() return joy_left_ratio == 1;

  public function new() {
    
    cd = new dn.Cooldown(Const.FPS);
    ca = App.ME.controller.createAccess();
    ca.lockCondition = Game.isGameControllerLocked;
    conf = ca.input.pad.config;

  }
}