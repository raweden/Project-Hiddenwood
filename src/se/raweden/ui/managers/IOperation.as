//
//	IOperation.as
//	Core UI Framework
//
//	Created by Jesper Svensson on 2011-07
//	Copyright 2011 Jesper Svensson. All rights reserved.
//
package se.raweden.ui.managers
{
	public interface IOperation{
		
		function performRedo():void;
		
		function performUndo():void;
		
	}
}