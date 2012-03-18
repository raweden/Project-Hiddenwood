package se.raweden.logging
{
	
	/**
	 * Description
	 *
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 *
	 * @author Raweden
	 */
	public interface ILogger{
		
		/**
		 * 
		 * @param	level
		 * @param	line
		 */
		function log(level:Level, line:String):void;
		
	}
}