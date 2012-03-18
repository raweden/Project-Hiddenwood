package se.raweden.console
{
	/**
	 * The <code>IConsoleClient</code> is a abstract interface for a Client to master the <code>Console</code> tool.
	 * 
	 * <p>Copyright 2011, Raweden. All Rights Reserved.</p>
	 * 
	 * @author Raweden
	 */
	public interface IConsoleClient extends IConsoleOutput{
		
		// TODO: more documentation needed.
		
		function show():void;
		
		function hide():void;
		
		/**
		 * A string representing the current output.
		 */
		function get currentOutput():String;
		
		/**
		 * A boolean value indicating if the client is currently visible.
		 */
		function get visible():Boolean;
		
	}
}