package se.raweden.console
{
	/**
	 * The <code>IConsoleCommand</code> is abstract structure for a <code>Console</code> commands.
	 * 
	 * <p>Copyright 2011, Raweden. All Rights Reserved.</p>
	 * 
	 * @author Raweden
	 */
	public interface IConsoleCommand{
		
		/**
		 * Determines the minimal number of argumtens which this command needs to be executed
		 * with the <code>execute()</code> method without casting an Error.
		 * 
		 * <p>Arguments should be implemented on the degree of how important they are.</p>
		 */
		function get lenght():int;
		
		/**
		 * Returns the command's name, also used to trigger the command to execute.
		 */
		function get name():String;	
		
		/**
		 * Returns the command's description. The description should describe the arguments and their actions
		 * to the user.
		 */
		function get help():String;
				
		/**
		 * Executes the bash command, this method will resive a Array of strings when executed.
		 * 
		 * @return A string feedback that will be written on the command-line.
		 */
		function execute(...args:*):String;
		
	}
}