package  {
	import flash.geom.Rectangle;
	/**
	 * Stores data for rendering blitsprites
	 * @author MSGHero
	 */
	public class Animation {
		
		private var _rects:Vector.<Rectangle>;
		private var _fps:Number;
		private var _x:Vector.<int>;
		private var _y:Vector.<int>;
		
		/**
		 * Creates a new animation
		 * @param	frames The names of each json object which contains sprite data
		 * @param	fps The number of frames to play per second (game fps / fps = delay between frames)
		 * @param	json The json object which contains the spritesheet data
		 */
		public function Animation(frames:Array/*String*/, fps:int, json:Object, frameRate:uint = 30) {
			
			_rects = Vector.<Rectangle>([]);
			_x = Vector.<int>([]);
			_y = Vector.<int>([]);
			_fps = frameRate / fps;
			
			var s:String, o:Object, p:Object, r:Rectangle;
			for (var i:uint = 0; i < frames.length; i++) {
				
				o = json[frames[i] + ".png"].frame;
				p = json[frames[i] + ".png"].spriteSourceSize;
				
				_rects.push(new Rectangle(o.x, o.y, o.w, o.h));
				_x.push(p.x); _y.push(p.y);
			}
			
			_x.fixed = true;
			_y.fixed = true;
			_rects.fixed = true;
		}
		
		/**
		 * Creates a new blitcommand
		 * @param	i The current index of the animation to render
		 * @param	bx The x position to render to
		 * @param	by The y position to render to
		 * @return A blitcommand with one render call
		 */
		public function getBlitCommand(i:int, bx:int, by:int):BlitCommand {
			return new BlitCommand(_x[i] + bx, _y[i] + by, _rects[i]);
		}
		
		/**
		 * Returns the number of frames this animation contains
		 */
		public function get length():int {
			return _rects.length;
		}
		
		/**
		 * Returns the amount of time between frame changes
		 */
		public function get time():Number {
			return _fps;
		}
	}
}