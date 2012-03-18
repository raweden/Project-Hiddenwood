package se.raweden.ui.view
{
	/**
	 * 
	 */
	public interface ITableViewDataSource{
		
		/**
		 * 
		 */
		function cellForRowAt(tableView:UITableView,index:int):UITableViewCell;
			
		/**
		 * 
		 */
		function numberOfCellsInSection(section:int):int;
		
	}
}