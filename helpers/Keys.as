package {
	
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	
	/**
	 * Methods to check the state of keyboard keys, whether just pressed, held down, or just released.
	 * @author MSGHero
	 */
	
	public class Keys {
		
		private static var down:Dictionary = new Dictionary(); // keys currently being held down
		private static var pressed:Dictionary = new Dictionary(); // keys currently being pressed (a press lasts for one frame only before needing to be released)
		private static var released:Dictionary = new Dictionary(); // keys just released (a release lasts for one frame only)
		
		public function Keys() {
			
		}
		
		/**
		 * Initializes the keyup/keydown listeners. Must be called before anything else.
		 * @param	stage
		 */
		public static function init(stage:Stage):void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}
		
		/**
		 * Removes the keyup/keydown listeners.
		 * @param	stage
		 */
		public static function uninit(stage:Stage):void {
			
			down = new Dictionary();
			pressed = new Dictionary();
			released = new Dictionary();
			
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
		}
		
		/**
		 * Resets the keys: pressed keys are set to false and released keys are deleted.  Call this at the end of the main loop.
		 */
		public static function reset():void {
			
			released = new Dictionary();
			
			for (var index:String in pressed) {
				pressed[index] = false;
			}
		}
		
		/**
		 * Checks if all of the passed keycodes are down.
		 * @param	...keys Keycodes to check, can be uints written out or in an array
		 * @return If all of the passed keycodes are down.
		 */
		public static function isDown(...keys):Boolean {
			return getState(down, keys);
		}
		
		/**
		 * Checks if any of the passed keycodes are down.
		 * @param	...keys Keycodes to check, can be uints written out or in an array
		 * @return If any of the passed keycodes are down.
		 */
		public static function anyDown(...keys):Boolean {
			return getState(down, keys, true);
		}
		
		/**
		 * Checks if all of the passed keycodes have just been released.  Use !isDown() if checking if a key has been released longer than 1 frame.
		 * @param	...keys Keycodes to check, can be uints written out or in an array
		 * @return If all of the passed keycodes have just been released.
		 */
		public static function isReleased(...keys):Boolean {
			return getState(released, keys);
		}
		
		/**
		 * Checks if any of the passed keycodes have just been released.  Use !anyDown() if checking if any keys have been released longer than 1 frame.
		 * @param	...keys Keycodes to check, can be uints written out or in an array
		 * @return If any of the passed keycodes have just been released.
		 */
		public static function anyReleased(...keys):Boolean {
			return getState(released, keys, true);
		}
		
		/**
		 * Checks if all of the passed keycodes have just been pressed.  Use isDown() if checking if a key has been held down longer than 1 frame.
		 * @param	...keys Keycodes to check, can be uints written out or in an array
		 * @return If all of the passed keycodes have just been pressed.
		 */
		public static function isPressed(...keys):Boolean {
			return getState(pressed, keys);
		}
		
		/**
		 * Checks if any of the passed keycodes have just been pressed.  Use anyDown() if checking if any keys have been held down longer than 1 frame.
		 * @param	...keys Keycodes to check, can be uints written out or in an array
		 * @return If any of the passed keycodes have just been pressed.
		 */
		public static function anyPressed(...keys):Boolean {
			return getState(pressed, keys, true);
		}
		
		/**
		 * Checks if any key has just been pressed.
		 * @return If any key has just been pressed.
		 */
		public static function anyKey():Boolean {
			
			for (var index:String in pressed) {
				if (pressed[index]) return true;
			}
			
			return false;
		}
		
		/**
		 * Sets the key in down to true and the key in press if it does not already exist.
		 * @param	e
		 */
		private static function keyDown(e:KeyboardEvent):void {
			down[e.keyCode] = true;
			pressed[e.keyCode] = !(e.keyCode in pressed);
			delete released[e.keyCode];
		}
		
		/**
		 * Sets the key in released to true, deletes the keys in pressed and down.
		 * @param	e
		 */
		private static function keyUp(e:KeyboardEvent):void {
			delete down[e.keyCode];
			delete pressed[e.keyCode];
			released[e.keyCode] = true;
		}
		
		/**
		 * Checks the specified dictionary for the keys.
		 * @param	d The key state dictionary
		 * @param	args The keys that were pressed
		 * @param	any If only one key needs to be matched to return true
		 * @return If all/any keys exist in the dictionary and are true.
		 */
		private static function getState(d:Dictionary, args:Array, any:Boolean = false):Boolean {
			
			var matches:uint = 0;
			
			if (args.length > 0 && args[0] is Array) args = args[0];
			
			for (var i:uint = 0; i < args.length; i++) {
				if (d[args[i]] != undefined && d[args[i]]) {
					if (any) return true;
					matches++;
				}
			}
			
			return matches == args.length;
		}
	}
}