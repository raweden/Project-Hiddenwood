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
	public class UIWorkspace{
		
		private static var m_defaultEnviroment:UIWorkspace;
		
		private var m_owner:IWorkspaceDelegate;
		
		private var m_delegate:IWorkspaceDelegate;
		
		public function UIWorkspace(delegate:IWorkspaceDelegate = null) {
			m_delegate = delegate;
		}
		
		public static function get defaultEnviroment():UIWorkspace{
			if(!m_defaultEnviroment){
				m_defaultEnviroment = new UIWorkspace();
			}
			return m_defaultEnviroment;
		}
		
		public static function get hasDefaultEnviroment():Boolean{
			return m_defaultEnviroment != null;
		}
		
		public function set delegate(value:IWorkspaceDelegate):void{
			if(!m_delegate){
				m_delegate = value;
			}
		}
		
		//------------------------------------
		// Managing Icons
		//------------------------------------
		
		/**
		 * 
		 * @param item
		 * @return
		 */
		public function iconForItem(item:Object):BitmapData{
			return m_delegate ? m_delegate.iconForItem(item) : null;
		}
		
		/**
		 * @param type The uniqe type identifier for the format type.
		 * @return
		 */
		public function iconForType(type:String):BitmapData{
			return m_delegate ? m_delegate.iconForType(type) : null;
		}
		
		//------------------------------------
		// Managing Plugins.
		//------------------------------------
		
		/**
		 * 
		 * @param 	type The identifier for the data type..
		 * @return	
		 */
		public function defaultPluginFor(type:String):ILocalController {
			return m_delegate ? m_delegate.defaultPluginFor(type) : null;
		}
		
		/**
		 * 
		 * @param 	type The identifier for the data type.
		 * @return A Array of all plugins that is registerd to interact with the type.
		 */
		public function pluginsFor(type:String):Array {
			return m_delegate ? m_delegate.pluginsForType(type) : null;
		}
		
		/**
		 * Contains identifiers for all data types registered on the platform.
		 * 
		 * <p>A type identifier is simular to a Uniform Type Identifier, 
		 * and uses a naming convention simular to package.class in AS3.</p>
		 */
		public function get types():Array{
			return m_delegate ? m_delegate.types : null;
		}
		
		//------------------------------------
		// Managing Documents.
		//------------------------------------
		
		/**
		 * 
		 */
		public function get documents():Array{
			return m_delegate ? m_delegate.documents : null;
		}
		
		//------------------------------------
		// Utility methods
		//------------------------------------
		
	}
}