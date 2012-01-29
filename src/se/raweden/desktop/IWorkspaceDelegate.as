package se.raweden.desktop 
{
	import flash.display.BitmapData;
	
	import se.raweden.ui.utils.ILocalController;
	
	/**
	 * Description
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public interface IWorkspaceDelegate{
		
		/**
		 * 
		 * @param	item 
		 * @return	A <code>BitmapData</code>
		 */
		function iconForItem(item:Object):BitmapData;
		
		/**
		 * 
		 * @param	type 
		 * @return	A <code>BitmapData</code>
		 */
		function iconForType(type:String):BitmapData;
		
		/**
		 * Returns the <code>ILocalController</code> for the default plugin for the indicated type.
		 * 
		 * @param	type 
		 * @return A <code>ILocalController</code> 
		 */
		function defaultPluginFor(type:String):ILocalController;
		
		/**
		 * Returns a Array containing all <code>ILocalController</code> that are registerd to 
		 * interact with the indicated type.
		 * 
		 * @param	type 
		 * @return	A <code>Array</code> of <code>ILocalController</code> or null if no plugin
		 * where found for the indicated type.
		 */
		function pluginsForType(type:String):Array;
		
		/**
		 * 
		 */
		function get documents():Array;
		
		/**
		 * 
		 */
		function get types():Array;
		
	}
	
}