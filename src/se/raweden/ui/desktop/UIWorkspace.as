package se.raweden.ui.desktop
{
	import se.raweden.core.core;
	import se.raweden.ui.utils.ILocalController;

	/**
	 * The <code>WorkSpace</code> class...
	 * 
	 * <p>copyright Copyright 2011 Raweden. All rights reserved.</p>
	 * @author Raweden
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
		
		private var m_delegate:IWorkspaceDelegate;
		private var m_pasteboard:UIPasteboard;
		
		public function UIWorkspace(delegate:IWorkspaceDelegate){ //localControllers:Array,documents:Array,documentsDefaults:Object){
			m_delegate = delegate;
			/*
			m_localControllers = localControllers;
			m_documents = documents;
			m_documentsDefaults = documentsDefaults;
			// setting the default instance if not set.
			*/
			if(!m_sharedWorkspace)
				m_sharedWorkspace = this;
		}
		
		//------------------------------------
		// Managing Workspace Clipboard and Global Clipboard.
		//------------------------------------
		
		/**
		 * 
		 */
		public final function set pasteboard(value:UIPasteboard):void{
			m_pasteboard = value;
		}
		// indicates the current pasteboard.
		public final function get pasteboard():UIPasteboard{
			return m_pasteboard;
		}
		
		//------------------------------------
		// Default Application for Types
		//------------------------------------
		
		/**
		 * 
		 * @param type The filetype extention.
		 * @return 
		 */
		public final function defaultApplicationFor(type:String):ILocalController{
			return m_delegate.defaultApplicationFor(type);
		}
				
		/**
		 * Returns a Array containing all <code>ILocalController</code> registed for the type.
		 * 
		 * @param type The filetype extention.
		 * @return
		 */
		public final function applicationsFor(type:String):Array{
			return m_delegate.applicationsFor(type);
		}
		
		/**
		 * Returns a Array containing all Type Identifiers registerd on the platform.
		 */
		public final function get documents():Array{
			return m_delegate.documents;
		}
		
	}
}