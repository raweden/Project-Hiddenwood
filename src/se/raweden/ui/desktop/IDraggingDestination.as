//
//	IDraggingDestination.as
//	Core UI Framework
//
//	Created by Raweden on 2011-08-08
//	Copyright 2011 Raweden. Some rights reserved.
//

package se.raweden.ui.desktop
{
	public interface IDraggingDestination{
		
		/**
		 * 
		 */
		function acceptsDrop(session:UIDraggingSession):Boolean;
		
		/**
		 * 
		 */
		function updateDraggingItems(session:UIDraggingSession):void
		
		
	}
}