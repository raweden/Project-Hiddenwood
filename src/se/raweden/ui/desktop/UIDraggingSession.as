//
//	UIDraggingSession.as
//	Core UI Framework
//
//	Created by Jesper Svensson on 2011-07
//	Copyright 2011 Jesper Svensson. All rights reserved.
//

package se.raweden.ui.desktop
{
	import flash.geom.Point;

	/**
	 * 
	 */
	public class UIDraggingSession{
		
		private static var m_currentSequence:uint = 0;
		
		private var m_pasteboard:UIPasteboard;
		private var m_items:Array;
		private var m_sequence:uint;
		private var m_location:Point;
		
		public function UIDraggingSession(pasteboard:UIPasteboard,items:Array){
			m_pasteboard = pasteboard;
			// getting the sequence id.
			m_sequence = m_currentSequence;
			m_currentSequence++;
		}
		
		// Dragging Pasteboard.
		
		/**
		 * The pasteboard provided with this dragging session.
		 */
		public function get pasteboard():UIPasteboard{
			return m_pasteboard;
		}
		
		// Dragging Session's Visual Representation.
		
		/**
		 * 
		 */
		public final function get items():Array{
			return m_items;
		}
		
		// Identifying the Dragging Session.
		
		/**
		 * Indicates the sequence number for this dragging session.
		 */
		public final function get sequence():uint{
			return m_sequence;
		}
		
		// Dragging Session Localtion Attributes.

		/**
		 * The current dragging trackpoint location in stage coordinates.
		 */
		public function get location():Point{
			return m_location;
		}
		
	}
}