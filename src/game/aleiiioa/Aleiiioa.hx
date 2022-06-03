package aleiiioa;


import aleiiioa.components.ui.UIDialogComponent;
import aleiiioa.builders.*;
import aleiiioa.components.core.position.GridPosition;


import aleiiioa.systems.ui.*;
import aleiiioa.systems.core.*;
import aleiiioa.systems.renderer.*;
import aleiiioa.systems.solver.*;
import aleiiioa.systems.modifier.*;
import aleiiioa.systems.collisions.*;
import aleiiioa.systems.vehicule.*;

import echoes.Workflow;

class Aleiiioa extends Game {
	var game(get,never) : Game; inline function get_game() return Game.ME;

	public function new() {
		super();
		Workflow.reset();
		
		
		
		var cameraPoint = level.data.l_Entities.all_CameraPoint[0];
		var cameraFocus = Builders.cameraFocus(cameraPoint.cx,cameraPoint.cy);
		var cameraFocusPosition = cameraFocus.get(GridPosition);

		Game.ME.camera.trackEntityGridPosition(cameraFocusPosition,true,1);
		Game.ME.camera.centerOnGridTarget();		
		Game.ME.camera.clampToLevelBounds = false;
		
		
		// ECS //
		
		
		//Collision
		Workflow.addSystem(new GarbageCollectionSystem());
		Workflow.addSystem(new CollisionsListenerActualizer());
		
		//Object
		Workflow.add60FpsSystem(new VelocitySystem());
		Workflow.add60FpsSystem(new GridPositionActualizer());
		
		
		//Graphics
		Workflow.add60FpsSystem(new SpriteExtensionFx());
		Workflow.add60FpsSystem(new SpriteRenderer(Game.ME.scroller,Game.ME));
		
		//Helpers
		Workflow.add60FpsSystem(new UIHelperSystem());
		Workflow.add60FpsSystem(new UIDialogSystem());
		Workflow.add60FpsSystem(new DialogSystem());
	
		//Input
		Workflow.add60FpsSystem(new InputSystem());

	
		//UIBuild.dialog("this is my funny textfpjfspejfpsjofsepfofjspoefspojfpsjpodsjsofkskpoeskfposkfposekfposkfpokespofkseofkposekfposkfpokspofkposekfposkpofksepofkposkfpoksepofksepokfposkfposkfposkefpoksepofkosekfposkefposkepofkspofekspoefkposekfposkfpokspofkspoekfposkfposkfposkfposekfpsoek");
		//UIBuild.dialog("this is my second funny tex;xjjspofthjjhjhhjhhhjhjhjhjhjhjhjijijijijijijijyuyuyuyuyuyuy uyuyuyuuyyugugyyugyugyugyugygyg ijijijijij ijiijijij ijijijiji oijjoijioji iojoij ioj  oijoii oijoi jjijoi joijoijoijoi oi joij oij oijoi joij oij oij oijoijoijoi joi o o jiojoijoi joij oij uyuyuyuuyyugugyyugyugyugyugygyg ijijijijij ijiijijij ijijijiji oijjoijioji iojoij ioj  oijoii oijoi jjijoi joijoijoijoi oi joij oij oijoi joij oij oij oijoijoijoi joi o o jiojoijoi joij oijuyuyuyuuyyugugyyugyugyugyugygyg ijijijijij ijiijijij ijijijiji oijjoijioji iojoij ioj  oijoii oijoi jjijoi joijoijoijoi oi joij oij oijoi joij oij oij oijoijoijoi joi o o jiojoijoi joij oij");
		//UIBuild.dialog("this is my second funny text");
		//trace(Workflow.entities.length);
	}


	override function fixedUpdate() {
		super.fixedUpdate();
		Workflow.update(tmod);
	}

	override function postUpdate() {
		super.postUpdate();
		Workflow.postUpdate(tmod);
	}


}
	

