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
		
		private static var _defaultEnviroment:UIWorkspace;
		
		private var _delegate:IWorkspaceDelegate;
		
		public function UIWorkspace(delegate:IWorkspaceDelegate = null) {
			_delegate = delegate;
		}
		
		public static function get defaultEnviroment():UIWorkspace{
			if(!_defaultEnviroment){
				_defaultEnviroment = new UIWorkspace();
			}
			return _defaultEnviroment;
		}
		
		public static function get hasDefaultEnviroment():Boolean{
			return _defaultEnviroment != null;
		}
		
		public function set delegate(value:IWorkspaceDelegate):void{
			if(!_delegate){
				_delegate = value;
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
			return _delegate ? _delegate.iconForItem(item) : null;
		}
		
		/**
		 * @param type The uniqe type identifier for the format type.
		 * @return
		 */
		public function iconForType(type:String):BitmapData{
			return _delegate ? _delegate.iconForType(type) : null;
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
			return _delegate ? _delegate.defaultPluginFor(type) : null;
		}
		
		/**
		 * 
		 * @param 	type The identifier for the data type.
		 * @return A Array of all plugins that is registerd to interact with the type.
		 */
		public function pluginsFor(type:String):Array {
			return _delegate ? _delegate.pluginsForType(type) : null;
		}
		
		/**
		 * Contains identifiers for all data types registered on the platform.
		 * 
		 * <p>A type identifier is simular to a Uniform Type Identifier, 
		 * and uses a naming convention simular to package.class in AS3.</p>
		 */
		public function get types():Array{
			return _delegate ? _delegate.types : null;
		}
		
		//------------------------------------
		// Managing Documents.
		//------------------------------------
		
		/**
		 * 
		 */
		public function get documents():Array{
			return _delegate ? _delegate.documents : null;
		}
		
		//------------------------------------
		// Utility methods
		//------------------------------------
		
	}
}