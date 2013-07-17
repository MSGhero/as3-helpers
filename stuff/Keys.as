package {
	
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author MSGHero
	 */
	
	public class Keys {
		
		private static var down:Dictionary = new Dictionary();
		private static var pressed:Dictionary = new Dictionary();
		private static var released:Dictionary = new Dictionary();
		
		public function Keys() {
			
		}
		
		public static function init(stage:Stage):void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}
		
		public static function uninit(stage:Stage):void {
			
			down = new Dictionary();
			pressed = new Dictionary();
			released = new Dictionary();
			
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
		}
		
		private static function keyDown(e:KeyboardEvent):void {
			down[e.keyCode] = true;
			pressed[e.keyCode] = !(e.keyCode in pressed);
			delete released[e.keyCode];
		}
		
		private static function keyUp(e:KeyboardEvent):void {
			delete down[e.keyCode];
			delete pressed[e.keyCode];
			released[e.keyCode] = true;
		}
		
		private static function getState(d:Dictionary, args:Array, any:Boolean = false):Boolean {
			
			var matches:uint = 0;
			
			for (var i:uint = 0; i < args.length; i++) {
				if (d[args[i]] != undefined && d[args[i]]) {
					if (any) return true;
					matches++;
				}
			}
			
			return matches == args.length;
		}
		
		public static function isDown(...keys):Boolean {
			return getState(down, keys);
		}
		
		public static function areAnyDown(...keys):Boolean {
			return getState(down, keys, true);
		}
		
		public static function isReleased(...keys):Boolean {
			return getState(released, keys);
		}
		
		public static function justPressed(...keys):Boolean {
			return getState(pressed, keys);
		}
		
		public static function anyPressed(...keys):Boolean {
			return getState(pressed, keys, true);
		}
		
		public static function anyKey():Boolean {
			
			for (var index:String in pressed) {
				if (pressed[index]) return true;
			}
			
			return false;
		}
		
		public static function reset():void {
			
			released = new Dictionary();
			
			for (var index:String in pressed) {
				pressed[index] = false;
			}
		}
	}
}