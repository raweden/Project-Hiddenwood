package se.raweden.console
{
	/**
	 * The <code>IConsoleOutput</code> is a abstact interface for reading output from the <code>Console</code> tool.
	 * 
	 * <p>Copyright 2011, Raweden. All Rights Reserved.</p>
	 * 
	 * @author Raweden
	 */
	public interface IConsoleOutput{
		
		// TODO: more documentation needed.
		
		/**
		 * Abstact method for clearing the outputed text.
		 */
		function clear():void;
		
		/**
		 * Abstact method for that the Bash console uses to output text.
		 */		
		function write(text:String):void;
		
	}
}