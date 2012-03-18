package se.raweden.motion
{
	/**
	 * 
	 * @author Raweden
	 */	
	public class TweenProperty{
		
		public var name:String;
		public var start:Number;
		public var step:Number;
		public var value:Number;
		
		/**
		 * 
		 * @param name
		 * @param value
		 */		
		public function TweenProperty(name:String,value:Number){
			this.name = name;
			this.value = value;
		}
	}
}