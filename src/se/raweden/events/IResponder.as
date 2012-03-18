package se.raweden.events
{
	/**
	 * 
	 * 
	 * @author Raweden
	 */	
	public interface IResponder{
		
		/**
		 * 
		 * 
		 * @param type
		 * @param callback
		 */		
		function on(type:String,callback:Function):void;
		
		/**
		 * 
		 * 
		 * @param type
		 * @param callback
		 */		
		function once(type:String,callback:Function):void;
		
		/**
		 * 
		 * 
		 * @param type
		 * @param args
		 * @return 
		 */		
		function emit(type:String,...args:*):Boolean;
		
		/**
		 * 
		 * 
		 * @param type
		 * @param callback
		 */		
		function removeListener(type:String,callback:Function):void;
		
		/**
		 * 
		 * 
		 * @param type
		 * @return 
		 */		
		function listeners(type:String):Array;
		
		/**
		 * 
		 * 
		 * @param type
		 * @return 
		 */		
		function hasListener(type:String):Boolean
		
		
	}
}