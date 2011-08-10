package se.raweden.ui.desktop
{
	import se.raweden.core.core;
	import se.raweden.ui.ILocalController;

	/**
	 * The <code>WorkSpace</code> class...
	 * 
	 */
	public final class UIWorkspace{
		
		//
		// TODO: Allow communcation between internal applications's sandboxes: almost complete.
		// TODO: Manage the internal clipboard and implement menas to set the internal clipboard as the native.
		//
		
		use namespace core;
		
		//------------------------------------
		// Getting the default Workspace.
		//------------------------------------
		
		private static var m_sharedWorkspace:UIWorkspace;
		
		public static function get sharedWorkspace():UIWorkspace{
			return m_sharedWorkspace;
		}
		
		//------------------------------------
		// Instance Implementation
		//------------------------------------
		
		private var m_localControllers:Array;	// contains controllers for registerd applications.
		private var m_documents:Array;			// contains all documents type regiesterd.
		private var m_documentsDefaults:Object;	// contains the default applicaiton for documents types.
		
		private var m_pasteboard:UIPasteboard;
		
		public function UIWorkspace(localControllers:Array,documents:Array,documentsDefaults:Object){
			m_localControllers = localControllers;
			m_documents = documents;
			m_documentsDefaults = documentsDefaults;
			// setting the default instance if not set.
			if(!m_sharedWorkspace)
				m_sharedWorkspace = this;
		}
		
		//------------------------------------
		// Managing Workspace Clipboard and Global Clipboard.
		//------------------------------------
		
		/**
		 * 
		 */
		public function set pasteboard(value:UIPasteboard):void{
			m_pasteboard = value;
		}
		// indicates the current pasteboard.
		public function get pasteboard():UIPasteboard{
			return m_pasteboard;
		}
		
		//------------------------------------
		// Getting the Default Application for File Types
		//------------------------------------
		
		/**
		 * 
		 * @param type The filetype extention.
		 */
		public final function defaultApplicationFor(type:String):ILocalController{
			return m_documentsDefaults ? m_documentsDefaults[type] as ILocalController : null;
		}
		
		/**
		 * 
		 */
		public final function get documents():Array{
			return m_documents.concat();
		}
		
		/**
		 * 
		 * @param type The filetype extention.
		 */
		public final function applicationsFor(type:String):Array{
			var len:int = m_documents.length;
			var apps:Array = new Array()
			for(var i:int = 0;i<len;i++){
				
			}
			return apps.length > 0 ? apps : null;
		}
		
	}
}