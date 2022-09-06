package aleiiioa.components.particules;

import ldtk.Entity;
import h2d.Bitmap;
import h2d.SpriteBatch.BatchElement;
import h2d.Tile;

class EmitterComponent {
    
    public var cd:dn.Cooldown;
    public var tick:Bool = false;

    public var layer  : h2d.Layers;
    public var nbParticules:Int = 0;
    public var maxParticules:Int = 50 ;

    public function new() {
        cd = new dn.Cooldown(Const.FPS);

        layer = new h2d.Layers();
        Game.ME.root.add(layer,Const.DP_BG);
		layer.name = "VFX";    

    }

    public function addParticule(en:echoes.Entity) {
        var pc = en.get(ParticulesComponent);
        layer.add(pc.bitmap);
    }

}