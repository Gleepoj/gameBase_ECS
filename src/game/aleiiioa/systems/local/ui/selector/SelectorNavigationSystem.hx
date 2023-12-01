package aleiiioa.systems.tactical;


import aleiiioa.components.core.physics.position.GridPosition;
import aleiiioa.components.core.local.ui.UINearestFlag;
import aleiiioa.components.local.ui.layers.UISelectableFlag;
import aleiiioa.components.core.local.ui.UISelectorFlag;
import echoes.System;
import echoes.View;
/* import aleiiioa.flags.ui.*;
import aleiiioa.components.localui.*;
import aleiiioa.components.core.position.GridPosition;
import aleiiioa.components.core.position.TransformPositionComponent; */

class SelectorNavigationSystem extends echoes.System {
	var SELECTOR:View<UISelectorFlag>;
	var SELECTABLE:View<UISelectableFlag>;

	var dist_to_player:Float = 500;
	var current_category:UISelectableType = Category_None;

	public function new() {}

	@u function initDistance() {
		dist_to_player = 5000.;
		current_category = Category_None;
	}


	@u function preCastNearestInSelectorIntent(en:echoes.Entity, s:UISelectableFlag, gp:GridPosition) {
		var dist = 10000.;
		var select = false;
		var selector_i = SELECTOR.entities.head;
		
		if (selector_i != null) {
			var selector = selector_i.value;

			if (selector.exists(UIMoveIntentComponent) && !selector.exists(TransformPositionComponent)) {
				var select_int = selector.get(UIMoveIntentComponent);
				var select_gp  = selector.get(GridPosition);
			
				if (select_int.y < 0) {
					if (gp.cy+1 < select_gp.cy) {
						select = true;
						dist = M.dist(gp.cx, gp.cy, select_gp.cx, select_gp.cy);
					}
				}

				if (select_int.y > 0) {
					if (gp.cy -1 > select_gp.cy) {
						select = true;
						dist = M.dist(gp.cx, gp.cy, select_gp.cx, select_gp.cy);
					}
				}

				if (select_int.x < 0) {
					if (gp.cx < select_gp.cx) {
						select = true;
						dist = M.dist(gp.cx, gp.cy, select_gp.cx, select_gp.cy);
					}
				}

				if (select_int.x > 0) {
					if (gp.cx > select_gp.cx) {
						select = true;
						dist = M.dist(gp.cx, gp.cy, select_gp.cx, select_gp.cy);
					}
				}
			}

			if (select) {
				en.add(new UINearestFlag(dist));
				if (dist < dist_to_player)
					dist_to_player = dist;
			}
		}
	}
	
	@u function removeNoneNearest(en:echoes.Entity, near:UINearestFlag) {
		if (near.distance > dist_to_player) {
			en.remove(UINearestFlag);
		}
	}

	@u function convertNearestToTargeted(en:echoes.Entity, near:UINearestFlag){

		en.add(new UITargetedObject());
		en.remove(UINearestFlag);
	}

	@a function updateNearest(en:echoes.Entity, add:UITargetedObject, s:UISelectableFlag, gp:GridPosition) {

		var selector = SELECTOR.entities.head.value;
		if(!selector.exists(TransformPositionComponent)){
			var duration:Float = 0.1;
			var tar = gp.gpToVector();
			var ori = selector.get(GridPosition).gpToVector();
			selector.remove(UIMoveIntentComponent);
			selector.add(new TransformPositionComponent(ori,tar,duration,TBurnOut));
		}
		en.remove(UITargetedObject);
	}

}
