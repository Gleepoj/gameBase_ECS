package aleiiioa.components;


@:forward
abstract SpriteComponent(HSprite) from HSprite to HSprite {
     
    public inline function new() {
        this = new HSprite(Assets.tiles);
    }

}
