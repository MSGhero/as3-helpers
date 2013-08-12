package  {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * Example class to show the usage of the blitting helpers
	 * @author MSGHero
	 */
	public class Example extends Sprite {
		
		// assume these get instantiated somewhere
		private var json:Object;
		private var spriteSheet:BitmapData;
		
		private var hero:BlitSprite;
		private var weapon:BlitSprite;
		
		private var canvas:BitmapData;
		
		private const WIDTH:uint = 640;
		private const HEIGHT:uint = 480;
		
		public function Example() {
			
			hero = new BlitSprite(json, "", 10, 0); // arbitrary registration point
			weapon = new BlitSprite(json, "", 10, 0);
			
			hero.addAnimation("Attack", ["Swing 1", "Swing 2", "Swing 3", "Swing 4"], 4); // at 30 fps, 7.5 second delay before moving to the next frame
			weapon.addAnimation("Attack", ["Weapon Swing 1", "Weapon Swing 2", "Weapon Swing 3", "Weapon Swing 4"], 4); // mirrored for easier control of both sprites
			hero.addChild(weapon);
			
			hero.playAnimation("Attack", true); // will play hero's and weapon's attack animations
			hero.x = 200;
			hero.y = 200;
			
			addChild(new Bitmap(canvas = new BitmapData(WIDTH, HEIGHT)));
			
			addEventListener(Event.RENDER, onRender);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function render(e:Event):void {
			
			canvas.fillRect(canvas.rect, 0x0); // clears previous content
			
			var bc:BlitCommand = hero.render();
			
			for (var i:uint = 0; i < bc.length; i++) {
				canvas.copyPixels(spriteSheet, bc.rects[i], bc.pts[i], null, null, true); // blits hero and all its children
			}
		}
		
		public function onEnterFrame(e:Event):void {
			hero.update(true); // will advance each blitsprite's ticker and check if the next frame of animation should play
			stage.invalidate();
		}
	}
}