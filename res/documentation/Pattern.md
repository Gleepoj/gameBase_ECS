:: Building Worlds ::
::   Use Sprite    :: 
:: Use Collisions  :: 
:: Use Particules  ::
:: Use Interaction :: 

::     Use UI      ::
-Define UIObject / UISelectable / UISelector / 

::  Use Collisions  :: 

- Level collision are based on bounding box 
The present collision work as is : 

- Grid Position is the pivot point of the sprite 

- By default the grid position is set on the "foot" of the sprite and is offset by minus half Const.GRID (grid cell size) with that you can have basic but robust placeholder physics to start prototyping plateformer or top down game. With spr.wid = Const.GRID and spr.hei = Const.GRID, the bounding box is centered in (8px,8px).  

- Level Collisions are handled during the addition of the OnPreStepX/OnPreStepY flag in GridPositionActualizer system, all collisions are handled with 0.5 ratio so when there is a wall/floor on next case the grid position is stucked at 0.5 x or y ratio of the cell. 
The logic is easily accessible on the adding event @:a (en:Entity,add:OnPreStepX),so you can easyly filter the reaction of the specific entity, it is a continuous collision detection so if the dt step is large it could occur multiple time a frame, it could be (really) hard to handle multiple case collision on both X and Y, that why i keep the bounding box based on grid cell size and the anchor point on grid position (sprite pivot) if you need more precise collision the best way is probably to rewrite the whole logic.
You can draw the bounding box with /bounds command in the console  

- Coordinates system work as this : World are divided by chunk of 32x32 grid cell 
- Based on world coordinates of the entity (gp.cx && gp.cy) the chunk system add a local collision mask to the entity as a component (dn.LevelMark), the local collision position is obtained with a modulo of 32 from world coord 
- gp.iw  && gp.jw  are the chunk coordinates
- gp.lcx && gp.lcy are the local grid coordinates of the entity in the current chunk from the 1,1 left top case 
- gp.cx  && gp.cy  are the world grid cell coordinates of the entity 
- gp.xr  && gp.yr  are the grid cell position in ratio 0 is left, 1 is right on x 0 is top and 1 is bottom on y 

So the World pixel coordinates == gp.cx*Const.GRID + gp.xr*Const.GRID etc... you can get it on Vector format by calling gpToVector().

- CollisionSensor component is here for handling logic not collision detect onLand , recently on ground etc...
It it use for sprite animation, fx, sfx, data are easily accessible by adressing cl.onGround, cl.onLand etc... 
Detection occurs in CollisionSensorSystem