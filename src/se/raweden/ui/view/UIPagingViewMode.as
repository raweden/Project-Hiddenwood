package se.raweden.ui.view
{
	
	/**
	 * The <code>UIPagingViewMode</code> contains constants to be used with the <code>UIPagingView.mode</code> property.
	 *
	 * <p>Copyright 2011, Raweden. All Rights Reserved.</p>
	 * 
	 * @author Raweden
	 */
	public class UIPagingViewMode{
		
		/**
		 * Specifies that the <code>UIPagingView</code> is displayed as a deck of cards, 
		 * this gives the user a sneak-peak of the pages and allows navigating the stack of views.
		 * Direct interaction with the pages are disabled in this mode.
		 */
		public static const DECK:String = "deck";
		
		/**
		 * Specifies that the <code>UIPagingView</code> is displayed as maximized page.
		 */
		public static const PAGE:String = "page";
		
	}
}