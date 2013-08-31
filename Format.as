package {
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * Provides helper functions for formatting text
	 * @author MSGHero
	 */
	
	public class Format {
		
		public function Format() {
			
		}
		
		/**
		 * Formats milliseconds into a string in the format hh:mm:ss:mmm
		 * @param	millis Number of milliseconds
		 * @param	showHours If the number of hours should be shown
		 * @param	showMinutes If the number of minutes should be shown
		 * @param	showSeconds If the number of seconds should be shown
		 * @param	showMillis If the number of milliseconds should be shown
		 * @return The formatted string in hh:mm:ss:mmm format
		 */
		public static function time(millis:uint, showHours:Boolean = true, showMinutes:Boolean = true, showSeconds:Boolean = false, showMillis:Boolean = false):String {
			
			var s:String = "";
			var secs:int = millis / 1000;
			millis %= 1000;
			
			if (showHours) s += int(secs / 3600) + (showMinutes || showSeconds || showMillis ? ":" : ""); // hours
			if (showMinutes) s += (int((secs % 3600) / 60) < 10 ? "0" : "") + int((secs % 3600) / 60) + (showSeconds || showMillis ? ":" : ""); // minutes
			if (showSeconds) s += ((secs % 60) < 10 ? "0" : "") + (secs % 60) + (showSeconds || showMillis ? ":" : ""); // seconds
			if (showMillis) s += (millis < 100 ? "0" : "") + (millis < 10 ? "0" : "") + millis; // millis
			
			return s;
		}
		
		/**
		 * Formats a TextField by applying the specified TextFormat to the specified String, ie the first string will be formatted by the first TextFormat, and so on.
		 * The TextField's current text is ignored.
		 * @param	tf The TextField to format
		 * @param	strings An array of strings that make up the text of the TextField
		 * @param	formats An array of TextFormats that will be applied to the strings. The length of this array should match the length of the strings array.
		 * @return The formatted TextField
		 */
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
		
		// currency...?
	}
}