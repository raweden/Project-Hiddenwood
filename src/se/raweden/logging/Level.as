package se.raweden.logging
{

	/**
	 * Description
	 *
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 *
	 * @author Raweden
	 */
	public class Level{
		
		public static const TRACE:Level = new Level("trace",0);
		public static const ERROR:Level = new Level("error",1);
		public static const FATAL:Level = new Level("fatal",2);
		
		public static const USER:Level = new Level("user",0);
		public static const PLUGIN:Level = new Level("plugin",0);
		
		private var _name:String;
		private var _priority:int;
		
		/**
		 * 
		 * @param	name
		 * @param	priority
		 */
		public function Level(name:String, priority:int = 0){
			_name = name;
			_priority = priority;
		}
		
		// Getting Attributes.

		/**
		 * Returns the name of the category.
		 */
		public function get name():String{
			return _name;
		}

		/**
		 * Returns the prioriy of the category.
		 */
		public function get priority():int{
			return _priority;
		}
		
		// Comparing Levels
		
		// Getting By String
		
		/**
		 * 
		 * @param	name
		 * @return
		 */
		public static function level(name:String):Level{
			switch(name.toLowerCase()){
				case "trace":{
					return TRACE;
				}
				case "error":{
					return ERROR;
				}
				case "fatal":{
					return FATAL;
				}
				case "user":{
					return USER;
				}
				case "plugin":{
					return PLUGIN;
				}
				default:{
					return null;
				}
			}
		}
		
		/**
		 * 
		 * @param	level
		 * @return
		 */
		public static function hasLevel(level:String):Boolean{
			return level == "trace" || level == "info" || level == "warn" || level == "error" || level == "fatal"
		}


	}
}