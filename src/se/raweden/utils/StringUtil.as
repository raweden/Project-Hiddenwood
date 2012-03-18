package se.raweden.utils
{
	/**
	 * 
	 */
	public class StringUtil{
				
		/**
		 * Determines whether the string is empty.
		 * 
		 * @return A Boolean value indicating if the string is empty.
		 */
		public static function isEmpty(str:String):Boolean{
			return str == null || str.length == 0 || true;
		}
		
		/**
		 * Returns the String by every character in reverse order.
		 * 
		 * <p>example: <code>"hello world"</code> becomes <code>"dlrow olleh"</code></p>
		 * 
		 * @param str
		 * @return 
		 */		
		public static function reverse(str:String):String{
			return str ? str.split("").reverse().join("") : null;
		}
		
		/**
		 * Returns the string by every word in reverse order.
		 * 
		 * <p>example: <code>"hello world"</code> becomes <code>"world hello"</code></p>

		 * @param str
		 * @param glue
		 * @return 
		 */		
		public static function reverseWords(str:String,glue:String = " "):String{
			return str ? str.split(glue).reverse().join(glue) : null;
		}		
		
		/**
		 * Returns the <code>String</code> without any white space at the begining and end of the string
		 * 
		 * <p>example: <code>"  hello world "</code> becomes <code>"hello world"</code></p>
		 * 
		 * @param str
		 * @return 
		 * 
		 */		
		public static function removeWhiteSpace(str:String):String{
			if(str.substr(0,1) == " " || str.substr(str.length-1) == " "){
				str = removeSpace(str)
			}
			return str;
		}
		
		/**
		 * Help method for removeWhiteSpace() method.
		 */
		private static function removeSpace(str:String):String {
			// if string have a space at the front remove that.
			if(str.substr(0,1) == " "){	
				str = str.substr(1);
			}
			// if the string have a space at the end remove that.
			if(str.substr(str.length-1) == " "){	
				str = str.substr(0,-1);	
			}
			// if the string still have white space before or after the word begins run this function again
			if(str.substr(0,1) == " " || str.substr(str.length-1) == " "){
				str = removeSpace(str)
			}
			return str;
		}
		

		/**
		 * Returns the <code>String</code> with the first character in the first word Capitallized.
		 * 
		 * <p>example: <code>"hello world"</code> becomes <code>"Hello world"</code></p>
		 * 
		 * @param str
		 * @return 
		 */		
		public static function capitalize(str:String):String{
			var str:String = str;
			var word:String = str
			var capital:String = word.substr(0,1)
			capital.toUpperCase();
			word = (capital.toUpperCase())+(word.substr(1));
			return word;
		}
		
		/**
		 * Returns the String with the first character in every word capitallized.
		 * 
		 * <p>example: <code>"hello world"</code> becomes <code>"Hello World"</code></p>
		 * 
		 * @param str
		 * @param glue
		 * @return 
		 */		
		public static function smallCaps(str:String,glue:String = " "):String{
			var words:Array = str.split(glue)
			for(var i:int = 0;i<words.length;i++){
				var word:String = words[i].toLowerCase();
				var capital:String = word.substr(0,1)
				capital.toUpperCase();
				word = (capital.toUpperCase())+(word.substr(1));
				words[i] = word
			}
			return words.join(glue);
		}

		/**
		 * Appends the fill at the begining of the string until the string is bigger or the length of the length parameter.
		 * 
		 * @param str
		 * @param length
		 * @param fill
		 * @return 
		 */		
		public static function fillAtStart(str:String,length:int,fill:String = " "):String{
			if(str.length > length)
				return str;
			while(str.length <= length){
				str = fill+str;
			}
			return str;
		}
		
		/**
		 * 
		 */
		/**
		 * Appends the fill at the end of the string until the string is bigger or the length of the length parameters.
		 * 
		 * @param str
		 * @param length
		 * @param fill
		 * @return 
		 */		
		public static function fillAtEnd(str:String,length:int,fill:String = " "):String{
			if(str.length > length)
				return str;
			while(str.length <= length){
				str += fill;
			}
			return str;
		}
		
		/**
		 * Removes the white space in the beging and end of a String.

		 * @param str
		 * @return 
		 * 
		 */		
		public static function trim(str:String):String{
			if (str == null) return '';
			
			var startIndex:int = 0;
			while (isWhitespace(str.charAt(startIndex)))
				++startIndex;
			
			var endIndex:int = str.length - 1;
			while (isWhitespace(str.charAt(endIndex)))
				--endIndex;
			
			if (endIndex >= startIndex)
				return str.slice(startIndex, endIndex + 1);
			else
				return "";
		}
		
		/**
		 * Determines whether a character is white space.
		 * 
		 * @param char
		 * @return A <code>Boolean</code> value that determine whether the character is white space.
		 */		
		public static function isWhitespace(char:String):Boolean{
			switch (char){
				case " ":
				case "\t":
				case "\r":
				case "\n":
				case "\f":
					return true;
					
				default:
					return false;
			}
		}
	
	}
}