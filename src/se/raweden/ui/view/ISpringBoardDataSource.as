package se.raweden.ui.view
{
	/**
	 * 
	 */
	public interface ISpringBoardDataSource{
		
		/**
		 * 
		 * @param	board
		 * @param	page
		 * @param	index
		 * @return
		 */
		function cellAt(board:SpringBoardView,page:int,index:int):SpringBoardViewCell;
		
		/**
		 * 
		 * @param	board
		 * @param	parentIndex
		 * @param	index
		 * @return
		 */
		function childAt(board:SpringBoardView,parentIndex:int,index:int):SpringBoardViewCell;
		
		/**
		 * 
		 * @param	page
		 * @return
		 */
		function numCellsAt(page:int):int;
		
		/**
		 * 
		 */
		function get numberOfPages():int;
		
		/**
		 * 
		 * @param	index
		 * @return
		 */
		function hasChildren(index:int):Boolean;
		
	}
}