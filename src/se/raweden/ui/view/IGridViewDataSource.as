package se.raweden.ui.view
{
	/**
	 * 
	 */
	public interface IGridViewDataSource{
		
		/**
		 * 
		 */
		function cellAt(collectioView:UIGridView,index:int):UIGridViewCell;
		
		/**
		 * 
		 */
		function numberOfCells():int;
		
	}
}