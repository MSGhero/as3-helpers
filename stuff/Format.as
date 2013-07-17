package {
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author MSGHero
	 */
	
	public class Format {
		
		public function Format() {
			
		}
		
		public static function time(millis:uint, showSeconds:Boolean, showMillis:Boolean = false):String {
			
			var s:String = "";
			var secs:int = millis / 1000;
			millis %= 1000;
			
			s += int(secs / 3600) + ":"; // hours
			if (int((secs % 3600) / 60) < 10) s += "0"
			s += int((secs % 3600) / 60); // minutes
			if (showSeconds) s += ":" + ((secs % 60) < 10 ? "0" : "") + (secs % 60); // seconds
			if (showMillis) s += "." + (millis < 100 ? "0" : "") + (millis < 10 ? "0" : "") + millis; // millis
			
			return s;
		}
		
		public static function textInField(tf:TextField, strings:Array/*String*/, formats:Array/*TextFormat*/):TextField {
			
			tf.text = "";
			
			var s:String, last:int = 0;
			for (var i:uint = 0; i < strings.length; i++) {
				
				s = strings[i];
				
				if (s.length == 0) continue;
				tf.appendText(s);
				
				tf.setTextFormat(formats[i], last, last + s.length);
				last += s.length;
			}
			
			return tf;
		}
	}
}