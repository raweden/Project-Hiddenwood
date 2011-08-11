//
//	UIDocument.as
//	Core UI Framework
//
//	Created by Raweden on 2011-07-03
//	Copyright 2011 Raweden. Some rights reserved.
//

package se.raweden.ui.desktop
{
	import flash.printing.PrintJob;
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	import se.raweden.ui.UIViewController;
	import se.raweden.ui.managers.UIUndoManager;
	
	
	/**
	 * The <code>UIDocument</code> class provides a abstract interface for creating document based applications. 
	 * 
	 * <p>Objects and properties that can internally represent data displayed in a view 
	 * and can be read from and written to file should be implemented in your subclass of <code>UIDocument</code>.
	 * A <code>UIDocument</code> instance should associated with a <code>UIViewController</code> instances
	 * that manages the view where the document is represented visualy./p>
	 * 
	 * TODO: add a complete list of method and properties that should be overriden when subclassing UIDocument.
	 */	
	public class UIDocument{
		
		//
		// TODO: develop a event class that represents bindable properties so the view controller may process changes.
		// TODO: develop a class that represents the reading and writting session of remote files.
		//
		
		private var m_undoManager:UIUndoManager;
		
		public function UIDocument(){
			
		}
		
		//------------------------------------
		// Reading and Writting Document Data
		//------------------------------------
		
		/**
		 * Reads the Document from its binary source from a input stream.
		 * 
		 * @param input
		 * @param type
		 * @return A Boolean value indicating if the stream where accepted.
		 */
		public function readExternal(input:IDataInput,type:String):Boolean{
			
			//
			// In a feature release of the Flash Player you will be able to create a new thread to decode the file.
			// This avoids the interface to freeze when reading complex formats.
			//
			
			return false;
		}
		
		/**
		 * Writes the documents binary represtentation to a output stream.
		 * 
		 * @param output 
		 * @param type
		 * @return A Boolean value indicating if the document where successfully written to the stream.
		 * 
		 */
		public function writeExternal(output:IDataOutput,type:String):Boolean{
			
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
		 * Indicates if the Document has undo management.
		 */
		public function get hasUndoManager():Boolean{
			return m_undoManager != null;
		}
		
		/**
		 * Determine the undo manager that stores short history of this document.
		 * 
		 * @default <code>null</code>
		 */		
		public function set undoManager(value:UIUndoManager):void{
			m_undoManager = value;
		}
		// indicates the undo manager for this instance.
		public function get undoManager():UIUndoManager{
			return m_undoManager;
		}
		
		//------------------------------------
		// Managing Document Status
		//------------------------------------
		
		/**
		 * Indicates if the Document have been edited since it where last saved.
		 * 
		 * @default <code>false</code>
		 */
		public function get isDocumentEdited():Boolean{
			return false;
		}
		
		//------------------------------------
		// Creating and Managing Window Controllers
		//------------------------------------
				
		/**
		 * Returns the Panel Controller associated with this document instance.
		 * 
		 * <p>When subclassing this method this method should be overriden.</p>
		 * 
		 * @default <code>null</code>
		 */
		public function get viewController():UIViewController{
			return null;
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
		 * Returns the printJob representing the document.
		 * 
		 * @default <code>null</code>
		 */
		public function print():PrintJob{
			// generate the print as the this method is invoked.
			return null;
		}
		
	}
}