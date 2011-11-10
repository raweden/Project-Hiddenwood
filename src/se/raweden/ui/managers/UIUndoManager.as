package se.raweden.ui.managers
{
	/**
	 * A <code>UIUndoManager</code> object is a general purpose undo and redo manager. 
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * @author Raweden
	 */
	public class UIUndoManager{
		
		private var undoStack:Array;
		private var redoStack:Array;
		
		private var m_levels:int = 25;
		
		public function UIUndoManager(){
			undoStack = new Array();
			redoStack = new Array();
		}
		
		//------------------------------------
		// Getting and Setting Attributes.
		//------------------------------------
		
		/**
		 * A <code>Integer</code> that determines the maximum number of undo and redo operation in the stacks.
		 * 
		 * @default <code>25</code>
		 */
		public function set levels(value:int):void{
			m_levels = value;
			trimStacks();
		}
		// returns the current level set.
		public function get levels():int{
			return m_levels;
		}
		
		/**
		 * A <code>Boolean</code> value determine whether there is a operation that can be redone.
		 */
		public function get canRedo():Boolean{
			return redoStack.length > 0;
		}
		
		/**
		 * A <code>Boolean</code> value determine whether there is a operation that can be undone.
		 */
		public function get canUndo():Boolean{
			return undoStack.length > 0;
		}
		
		//------------------------------------
		// Clearing the history.
		//------------------------------------
		
		/**
		 * Clears both the undo and the redo histories.
		 */
		public function clearAll():void{
			undoStack.length = 0;
			redoStack.length = 0
		}
		
		/**
		 * Clears the redo history.
		 */
		public function clearRedo():void{
			redoStack.length = 0
		}
		
		//------------------------------------
		// Pushing and Peeking
		//------------------------------------
		
		/**
		 * Adds a redoable <code>IOperation</code> to the redo stack.
		 */
		public function pushRedo(operation:IOperation):void{
			redoStack.push(operation);
			trimStacks();
		}
		
		/**
		 * Adds a undoable <code>IOperation</code> to the undo stack.
		 */
		public function pushUndo(operation:IOperation):void{
			undoStack.push(operation);
			trimStacks();
		}
		
		/**
		 * Returns the next operation to be redone.
		 * 
		 * @return The redoable <code>IOperation</code>, or <code>null</code> if no redoable operation
		 * is in the stack.
		 */
		public function peekRedo():IOperation{
			return redoStack.length > 0 ? redoStack[redoStack.length-1] : null;
		}
		
		/**
		 * Returns the next operation to be undone.
		 * 
		 * @return The undoable <code>IOperation</code>, or <code>null</code> of no undoable operation
		 * is in the stack. 
		 */
		public function peekUndo():IOperation{
			return undoStack.length > 0 ? undoStack[undoStack.length-1] : null;
		}
		
		//------------------------------------
		// Preform Redo and Undo
		//------------------------------------
		
		/**
		 * Removes the next <code>IOperation</code> object from the redo stack
		 * and calls the <code>preformRedo()</code> function of that object.
		 */		
		public function redo():void{
			if(this.canRedo){
				var action:IOperation = redoStack.pop();
				action.performRedo();
			}
		}
		
		/**
		 * Removes the next <code>IOperation</code> object from the undo stack
		 * and calls the <code>performUndo()</code> function of that object.
		 */		
		public function undo():void{
			if(this.canUndo){
				var action:IOperation = undoStack.pop();
				action.performUndo();
			}
		}
		
		//------------------------------------
		// UTILITY METHODS
		//------------------------------------
		
		// Trims the length of both stacks if they are longer than what levels indicates
		private function trimStacks():void{
			if(undoStack.length > m_levels){
				undoStack.length = m_levels;
			}
			if(undoStack.length > m_levels){
				undoStack.length = m_levels;
			}
		}
		
	}
}