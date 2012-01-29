package se.raweden.desktop
{
	import flash.events.EventDispatcher;
	import flash.printing.PrintJob;
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	import se.raweden.managers.UndoManager;
	import se.raweden.utils.IExternalizable;
	
	/**
	 * A <code>UIDocument</code> object provides a base class for managing the data of documents.
	 * 
	 * <p>In the Model-View-Controller design pattern, a <code>UIDocument</code> object is a model 
	 * object or a model-controller object, it manages the data related to a document.
	 * A <code>UIDocument</code> is typically associated with a view controller that manges the 
	 * view presenting the document's data.</p>
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */	
	public class UIDocument extends EventDispatcher{
		
		//
		// TODO: add a complete list of method and properties that should be overriden when subclassing UIDocument.
		// TODO: develop a event class that represents bindable properties so the view controller may process changes.
		// TODO: develop a class that represents the reading and writting session of remote files.
		//
		
		private var m_undoManager:UndoManager;
		
		public function UIDocument(){
		
		}
		
		//------------------------------------
		// Object Attributes.
		//------------------------------------
		
		/**
		 * Determine the Mime type of the document format.
		 * 
		 * @default <code>"application/octet-stream"</code>
		 */
		public function get contentType():String{
			return "application/octet-stream";
		}
		
		/**
		 * 
		 * 
		 * @default <code>null</code>
		 */
		public function get localizedName():String{
			return null;
		}
		
		/**
		 * Indicates the data format that this <code>UIDocument</code> is encoded to.
		 * 
		 * @default <code>null</code>
		 */
		public function get savedType():String{
			return null;
		}
		
		/**
		 * 
		 * 
		 * @default <code>null</code>
		 */
		public function get attributes():Object{
			return null;
		}
		
		//------------------------------------
		// Reading Document Data
		//------------------------------------
		
		/**
		 * Reads the Document from its binary source from a input stream.
		 * 
		 * @param input The <code>ByteArray</code> from which the the document can be readin.
		 * @param type
		 * @return A Boolean value indicating if the stream where accepted.
		 */
		public function readExternal(input:ByteArray,type:String):Boolean{
			
			//
			// In a feature release of the Flash Player you will be able to create a new thread to decode the file.
			// This avoids the interface to freeze when reading complex formats.
			//
			
			return false;
		}
		
		//------------------------------------
		// Writting Document Data
		//------------------------------------
		
		/**
		 * Writes the documents binary represtentation to a output stream.
		 * 
		 * @param output The <code>ByteArray</code> for the document to write it's binary representation.
		 * @param type The format of the output format, by default the file extention.
		 * @return A Boolean value indicating if the document where successfully written to the stream.
		 */
		public function writeExternal(output:ByteArray,type:String):Boolean{
			
			//
			// In a feature release of the Flash Player you will be able to create a new thread to decode the file.
			// This avoids the interface to freeze when writting complex formats.
			//
			
			return false;
		}
		
		//------------------------------------
		// Working with Undo Manager
		//------------------------------------
				
		/**
		 * A <code>Boolean</code> value that determine whether the document has a undo management.
		 */
		public function get hasUndoManager():Boolean{
			return m_undoManager != null;
		}
		
		/**
		 * Determine the undo manager that stores short history of this document.
		 * 
		 * @default <code>null</code>
		 */		
		public function set undoManager(value:UndoManager):void{
			m_undoManager = value;
		}
		// indicates the undo manager for this instance.
		public function get undoManager():UndoManager{
			return m_undoManager;
		}
		
		//------------------------------------
		// Managing Document Status
		//------------------------------------
		
		/**
		 * Indicates the current state of the document.
		 */
		public final function get documentState():String{
			return null;
		}
		
		/**
		 * A <code>Boolean</code> value indicating whether the document have been edited since
		 * it where last saved.
		 * 
		 * @default <code>false</code>
		 */
		public function get isEdited():Boolean{
			return false;
		}
		
		//------------------------------------
		// Managing Related View and Controllers
		//------------------------------------
			
		/**
		 * Called by external interfaces to present the document in the application's viewport.
		 */
		public function present():void{
			
		}
		
		//------------------------------------
		// Printing Documents
		//------------------------------------
		
		/**
		 * Indicates that the document can be printed.
		 * 
		 * @default <code>false</code>
		 */
		public function get canPrint():Boolean{
			return false;
		}
		
		/**
		 * Returns the printJob representing the document, the default implementation of this 
		 * method returns <code>null</code>.
		 * 
		 * @return The <code>PrintJob</code> to be printed by the system.
		 */
		public function print():PrintJob{
			// generate the print as the this method is invoked.
			return null;
		}
		
	}
}