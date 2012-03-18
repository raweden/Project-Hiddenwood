package se.raweden.ui
{
	/**
	 * The <code>UIModalPresentation</code> contains contants to be
	 * used with the UIViewController's <code>modalPresentation</code> property.
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden.
	 */
	public class UIModalPresentation{
		
		/**
		 * The presented view covers on which it is presented modaly on.
		 */
		public static const FullScreen:String = "fullsceen";
		
		/**
		 * The width and height of the presented view is smaller than those of the sceen and the view is centered on the sceen.
		 * All uncoverd areas are dimmed so the user cant interact with them. 
		 */
		public static const Form:String = "form";
		
		/**
		 * The height of the presented view is set to the height of the screen and the width is preserved.
		 * All uncoverd areas are dimmed so the user cant interact with them.
		 */
		public static const Page:String = "page";
		
		/**
		 * The view is presented using the same style as it's parent view controller.
		 */
		public static const Current:String = "current";
		
	}
}