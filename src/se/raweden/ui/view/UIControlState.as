package se.raweden.ui.view
{
	/**
	 * The states of a control, a control can have more tahn one state at a time.
	 * States are recognized diffrently depending on the control.@tag 
	 * 
	 * @tag<p>You may notice that by default there is no hovering state for a control,
	 * it's not all platforms supports hovering a hovering state and in a real world
	 * methapore hovering would not apper.</p>
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public class UIControlState{
		
		/**
		 * The normal or default state of the Control that is neither selected or highlighted.
		 */
		public static const Normal:int = 0;
		
		/**
		 * Highlighted state of a control. A control enters this state when the user primarly interacts with the control.
		 */
		public static const Highlighted:int = 1;
		
		/**
		 * Disabled state of a control. This state indicates that the control is currently disabled.
		 */
		public static const Disabled:int = 2;
		
		/**
		 * Selected state of a control. This state indicates that the controls is currently selected.
		 */
		public static const Selected:int = 4;
		
	}
}