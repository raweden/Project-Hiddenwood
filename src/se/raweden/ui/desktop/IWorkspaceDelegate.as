package se.raweden.ui.desktop
{
	import se.raweden.ui.utils.ILocalController;

	/**
	 * 
	 */
	public interface IWorkspaceDelegate{
		
		/**
		 * 
		 * @param	type
		 * @return
		 */
		function defaultApplicationFor(type:String):ILocalController;
		
		/**
		 * 
		 * @param	type
		 * @return
		 */
		function applicationsFor(type:String):Array;
		
		/**
		 * 
		 */
		function get documents():Array;
		
	}
}