//
//	UIUndoManager.as
//	Core UI Framework
//
//	Created by Jesper Svensson on 2011-07
//	Copyright 2011 Jesper Svensson. All rights reserved.
//

package se.raweden.ui.managers
{
	/**
	 * UndoManager is a general purpose manager.... add more documetation here.
	 * 
	 */
	public class UIUndoManager{
		
		private var undoStack:Array;
		private var redoStack:Array;
		
		private var m_levels:int = 25;
		
		public function UIUndoManager(){
			undoStack = new Array();
			redoStack = new Array();
		}
		
		// Manage the levels of management
		
		public function set levels(value:int):void{
			m_levels = value;
			trimStacks();
		}
		
		public function get levels():int{
			return m_levels;
		}
		
		public function get canRedo():Boolean{
			return redoStack.length > 0;
		}
		
		public function get canUndo():Boolean{
			return undoStack.length > 0;
		}
		
		public function clearAll():void{
			undoStack.length = 0;
			redoStack.length = 0
		}
		
		public function clearRedo():void{
			redoStack.length = 0
		}
		
		public function peekRedo():IOperation{
			return redoStack.length > 0 ? redoStack[redoStack.length-1] : null;
		}
		
			
		public function peekUndo():IOperation{
			return undoStack.length > 0 ? undoStack[undoStack.length-1] : null;
		}
		
		public function pushRedo(operation:IOperation):void{
			redoStack.push(operation);
			trimStacks();
		}
		
		
		public function pushUndo(operation:IOperation):void{
			undoStack.push(operation);
			trimStacks();
		}
		
		/**
		 * Removes the next IOperation object from the redo stack and calls preformRedo() function of that object.
		 */		
		public function redo():void{
			if(this.canRedo){
				var action:IOperation = redoStack.pop();
				action.performRedo();
			}
		}
		
		/**
		 * Removes the next IOperation object from the undo stack and calls the performUndo() function of that object.
		 */		
		public function undo():void{
			if(this.canUndo){
				var action:IOperation = undoStack.pop();
				action.performUndo();
			}
		}
		
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