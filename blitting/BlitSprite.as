package  {
	import flash.display.BitmapData;
	import flash.utils.Dictionary;
	/**
	 * A basic blitting building block.  Similar to a flash.display.Sprite except uses blitting to render
	 * @author MSGHero
	 */
	public class BlitSprite {
		
		private var jsonRef:Object;
		
		private var animDict:Dictionary;
		private var currAnim:Animation;
		private var currIndex:int;
		private var framesPassed:int;
		
		private var _children:Vector.<BlitSprite>;
		private var _parent:BlitSprite;
		private var _index:int;
		private var noAnimation:Boolean;
		
		private var _regisX:int;
		private var _regisY:int;
		public var x:int;
		public var y:int;
		
		/**
		 * If the blitsprite is currently visible and should be rendered
		 */
		public var visible:Boolean = true;
		
		/**
		 * Creates a new blitsprite
		 * @param	json The json spritesheet info
		 * @param	reference Reference sprite name from which regis pt info will be taken
		 * @param   altRegisX x coordinate of the registration point (alternative to reference)
		 * @param   altRegisY y coordinate of the registration point (alternative to reference)
		 * @param   useAnimsFrom (optional) A blitsprite from which to reuse animation data.  json, reference, and altRegisX/Y are ignored if this is defined
		 */
		public function BlitSprite(json:Object, reference:String, altRegisX:int = NaN, altRegisY:int = NaN, useAnimsFrom:BlitSprite = null) {
			
			jsonRef = json;
			
			if (useAnimsFrom == null) {
				
				animDict = new Dictionary();
				
				var o:Object = json[reference + ".png"].spriteSourceSize;
				_regisX = isNaN(altRegisX) ? o.x + o.w / 2 : altRegisX;
				_regisY = isNaN(altRegisY) ? o.y + o.h / 2 : altRegisY;
			}
			
			else {
				animDict = useAnimsFrom.animDict;
				_regisX = useAnimsFrom._regisX;
				_regisY = useAnimsFrom._regisY;
			}
			
			x = y = framesPassed = 0;
			_children = Vector.<BlitSprite>([]);
		}
		
		/**
		 * Adds an animation
		 * @param	name The anim's name
		 * @param	frames A string array of the frame names
		 * @param	fps The number of frames to play per second (game fps / fps = delay between frames)
		 */
		public function addAnimation(name:String, frames:Array/*String*/, fps:int):void {
			animDict[name] = new Animation(frames, fps, jsonRef);
		}
		
		/**
		 * Plays an animation
		 * @param	name The anim's name
		 * @param	recursive If the children should also begin playing this animation
		 */
		public function playAnimation(name:String, recursive:Boolean = true):void {
			
			currAnim = animDict[name];
			if (currAnim == null) throw "Animation " + name + " not found";
			currIndex = 0;
			noAnimation = currAnim.length <= 1; // don't bother updating if there's only one frame
			
			if (recursive) {
				for (var i:uint = 0; i < _children.length; i++) {
					_children[i].playAnimation(name);
				}
			}
		}
		
		/**
		 * Adds a child blitsprite
		 * @param	bs The blitsprite to add as a child
		 */
		public function addChild(bs:BlitSprite):void {
			
			if (bs._parent) {
				bs._parent.removeChild(bs);
			}
			
			bs._parent = this;
			_children.push(bs);
			bs._index = _children.length - 1;
		}
		
		/**
		 * Removes the child blitsprite
		 * @param	bs The blitsprite to be removed
		 */
		public function removeChild(bs:BlitSprite):void {
			if (bs._parent != this) throw "Not a child of this BlitSprite";
			bs._parent = null;
			_children.splice(bs._index, 1);
		}
		
		/**
		 * Renders the blitsprite and all children
		 * @return A blitcommand for the renderer
		 */
		public function render():BlitCommand {
			
			if (currAnim == null) throw "Must play an animation first";
			
			var bc:BlitCommand;
			// localXY -> globalXY if parent
			bc = _parent != null ? currAnim.getBlitCommand(currIndex, x - _regisX + _parent.x, y - _regisY + _parent.y) : currAnim.getBlitCommand(currIndex, x - _regisX, y - _regisY);
			for (var i:uint = 0; i < _children.length; i++) {
				bc.concatBC(_children[i].render());
			}
			
			return bc;
		}
		
		/**
		 * Updates the blitsprite, advancing the animation ticker
		 * @param	recursive If the children should also be updated
		 */
		public function update(recursive:Boolean = false):void {
			
			if (!noAnimation) {
				
				if (currAnim == null) throw "Must play an animation first";
				
				if (framesPassed++ >= currAnim.time) { // next frame of animation
					currIndex = (currIndex + 1) % currAnim.length;
					framesPassed -= currAnim.time;
				}
				
				if (recursive) { // update kids
					for (var i:uint = 0; i < _children.length; i++) {
						_children[i].update(true);
					}
				}
			}
		}
	}
}