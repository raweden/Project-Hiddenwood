package se.raweden.ui.view
{
	import flash.text.TextField;

	/**
	 * 
	 */
	public interface IScriptViewDelegate{
		
		/**
		 * 
		 */
		function onScriptChange(editor:UIScriptView,textField:TextField):void;
		
	}
}