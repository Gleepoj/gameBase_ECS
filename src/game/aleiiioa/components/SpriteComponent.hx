package aleiiioa.components;


@:forward
abstract SpriteComponent(HSprite) from HSprite to HSprite {
     
    public inline function new() {
        this = new HSprite(Assets.tiles);
    }
/* 
    public inline function setColor():HSprite {
        this.colorize(0x00ff00);
        return this;
    } */

}
