package {
	
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.ui.*;
	
	/**
	 * ...
	 * @author MSGHero
	 */
	
	public class UiButton extends Sprite {
		
		private var _text:String = "";
		private var _disabled:Boolean;
		private var tf:TextField = new TextField();
		private static var textF:TextFormat = new TextFormat("Arial", 14, 0, true);
		
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
		
		private function mOver(e:MouseEvent):void {
			if (!_disabled) Mouse.cursor = MouseCursor.BUTTON;
		}
		
		private function mOut(e:MouseEvent):void {
			Mouse.cursor = MouseCursor.AUTO;
		}
		
		public function disable():void {
			//mouseChildren = false;
			//mouseEnabled = false;
			_disabled = true;
			tf.textColor = 0x666666;
		}
		
		public function enable():void {
			
			mouseChildren = true;
			mouseEnabled = true;
			_disabled = false;
			tf.textColor = 0x000000;
		}
		
		public function set text(s:String):void {
			_text = s;
			tf.text = s;
		}
		
		public function get text():String {
			return _text;
		}
		
		public function get disabled():Boolean {
			return _disabled;
		}
	}
}