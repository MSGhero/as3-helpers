package  {
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * A command to the renderer for multiple copyPixels calls
	 * @author MSGHero
	 */
	public class BlitCommand {
		
		/**
		 * Where each sprite will be rendered to (destPt of copyPixels)
		 */
		public var pts:Vector.<Point>;
		
		/**
		 * Where each rectangle is located on the main spritesheet (sourceRect of copyPixels)
		 */
		public var rects:Vector.<Rectangle>;
		
		/**
		 * Creates a new blitcommand
		 * @param	px The x coordinate of the sprite
		 * @param	py The y coordinate of the sprite
		 * @param	rect The rectangle where the sprite is located on the main spritesheet
		 */
		public function BlitCommand(px:int, py:int, rect:Rectangle) {
			pts = Vector.<Point>([new Point(px, py)]);
			rects = Vector.<Rectangle>([rect]);
		}
		
		/**
		 * Appends another rendering call to this blitsprite.  The last-concatenated render call will appear at the top, the first at the bottom.
		 * @param	px The x coordinate of the sprite
		 * @param	py The y coordinate of the sprite
		 * @param	rect The rectangle where the sprite is located on the main spritesheet
		 */
		public function concat(px:int, py:int, rect:Rectangle):void {
			pts.push(new Point(px, py));
			rects.push(rect);
		}
		
		/**
		 * Appends another rendering call to this blitsprite.  The last-concatenated render call will appear at the top, the first at the bottom.
		 * @param	bc The blitsprite to add render data from
		 */
		public function concatBC(bc:BlitCommand):void {
			
			for (var i:uint = 0; i < bc.pts.length; i++) {
				pts.push(bc.pts[i]);
				rects.push(bc.rects[i]);
			}
		}
		
		/**
		 * Returns the number of commands this blitcommand currently contains
		 */
		public function get length():int {
			return pts.length;
		}
	}
}