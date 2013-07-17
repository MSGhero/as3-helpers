package {
	
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.ui.*;
	
	/**
	 * A generic labeled button
	 * @author MSGHero
	 */
	
	public class UiButton extends Sprite {
		
		private var _text:String = "";
		private var _disabled:Boolean;
		private var tf:TextField = new TextField();
		private static var textF:TextFormat = new TextFormat("Arial", 14, 0, true);
		
		/**
		 * Creates a new labeled button
		 * @param	text The button's text
		 * @param	x The button's x position
		 * @param	y The button's y position
		 */
		public function UiButton(text:String, x:Number = 0, y:Number = 0) {
			
			graphics.beginFill(0xff9999);
			graphics.drawRoundRect(0, 0, 120, 40, 50);
			graphics.endFill();
			
			tf.defaultTextFormat = textF;
			tf.width = 120;
			tf.autoSize = TextFormatAlign.CENTER;
			tf.selectable = false;
			tf.y = 10;
			tf.text = _text = text;
			this.addChild(tf);
			tf.mouseEnabled = false;
			
			this.x = x;
			this.y = y;
			
			addEventListener(MouseEvent.MOUSE_OVER, mOver);
			addEventListener(MouseEvent.MOUSE_OUT, mOut);
		}
		
		/**
		 * Displays the button cursor whem moused over if the button is not disabled
		 * @param	e
		 */
		private function mOver(e:MouseEvent):void {
			if (!_disabled) Mouse.cursor = MouseCursor.BUTTON;
		}
		
		/**
		 * Displays the normal cursor when moused out
		 * @param	e
		 */
		private function mOut(e:MouseEvent):void {
			Mouse.cursor = MouseCursor.AUTO;
		}
		
		/**
		 * Disables the button
		 * @param	disableMouse Whether the button should remain mouse enabled (false) or not (true)
		 */
		public function disable(disableMouse:Boolean = false):void {
			
			mouseChildren = !disableMouse;
			mouseEnabled = !disableMouse;
			_disabled = true;
			tf.textColor = 0x666666;
		}
		
		/**
		 * Re-enables the button
		 */
		public function enable():void {
			
			mouseChildren = true;
			mouseEnabled = true;
			_disabled = false;
			tf.textColor = 0x000000;
		}
		
		/**
		 * Sets the text of the button
		 * @param   s The text
		 */
		public function set text(s:String):void {
			_text = s;
			tf.text = s;
		}
		
		/**
		 * Gets the text of the button
		 * @return The button's text
		 */
		public function get text():String {
			return _text;
		}
		
		/**
		 * @return If the button is disabled
		 */
		public function get disabled():Boolean {
			return _disabled;
		}
	}
}