package se.raweden.console
{
	/**
	 * The <code>ConsoleUtil</code> is a utility class for converting String arguments to their actual datatypes.
	 * 
	 * <p>Copyright 2011, Raweden. All Rights Reserved.</p>
	 * 
	 * @author Raweden
	 */
	public class ConsoleUtil{
		
		/**
		 * Determines if the string argument represent a Boolean value.
		 * 
		 * @return A boolean indicating if the argument provided represents a Boolean Value.
		 */
		public static function isBool(arg:String):Boolean{
			arg = arg.toUpperCase();
			return arg == "TRUE" || arg == "FALSE" || arg == "YES" || arg == "NO" 
		}
		
		/**
		 * Casts the argument to a boolean value. Use the <code>BashUtil.isBool()</code> method
		 * to determine if the argument is a valid boolean value.
		 * 
		 * @return A boolean representing the actual value of the argument.
		 */
		public static function toBoolean(arg:String):Boolean{
			arg = arg.toUpperCase();
			return arg == "TRUE" || arg == "YES"
		}
		
		/**
		 * Determines if the argument represent interger.
		 * 
		 * @return A boolean indicating if the argument provided represents a interger Value.
		 */
		public static function isInt(arg:String):Boolean{
			return isNaN(parseInt(arg));
		}
		
		/**
		 * Casts the argument to a interger value. Use the <code>BashUtil.isInt()</code> method
		 * to determine if the argument is a valid interger.
		 */
		public static function toInt(arg:String,radix:int = 10):int{
			return parseInt(arg,radix);
		}
		
		/**
		 * Determines if the argument represent Numberic value.
		 * 
		 * @return A boolean indicating if the argument provided represents a numberic Value.
		 */
		public static function isNum(arg:String):Boolean{
			return isNaN(parseFloat(arg));
		}
		
		/**
		 * Casts the argument to a Numberic value. Use the <code>BashUtil.isNum()</code> method
		 * to determine if the argument is a valid numberic value.
		 */
		public static function toNum(arg:String):Number{
			return parseFloat(arg);
		}
			
	}
}
