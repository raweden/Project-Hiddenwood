package se.raweden.utils
{
	
	/**
	 * The <code>IErrorHandler</code> is a abstact interface for processing errors from a modular component.
	 *
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 *
	 * @author Raweden
	 */
	public interface IErrorHandler{
		
		/**
		 * This method is invoked when a error occours.
		 * 
		 * @param	error The error to be processed by the <code>IErrorHandler</code> implemenation.
		 */
		function processError(error:Error):void;
		
	}
}