package se.raweden.ui.view
{
	/**
	 * 
	 */
	public interface IPagingViewDataSource{
		
		/**
		 * 
		 * 
		 * @param index
		 * @return
		 */
		function viewForPageAt(index:int):UIView;
		
		/**
		 * 
		 * 
		 * @param index
		 * @return 
		 */
		function titleForPageAt(index:int):String;
		
		/**
		 * 
		 * 
		 * @param index
		 * @return 
		 */
		function subtitleForPageAt(index:int):String;
		
		/**
		 * 
		 */
		function get numberOfPages():int;
		
	}
}