package se.raweden.events
{
	public class Responder implements IResponder{
		
		private var _target:IResponder;
		
		private var _listeners:Object;
		private var _triggers:Array;
		
		/**
		 * Constructor
		 */		
		public function Responder(){
		
		}
		
		/**
		 * Adds a listener to the end of the listeners array for the specified event.
		 * 
		 * @param type
		 * @param callback
		 */		
		public function on(type:String, callback:Function):void{			
			var index:int = -1;
			var listeners:Array;
			if(!_listeners.hasOwnProperty(type) == true){
				_listeners[type] = listeners = new Array();
			}else{
				listeners = _listeners[type];
				index = listeners.indexOf(callback);
			}
			// Refenrences the callback under the type if not already registerd.
			if(index == -1){
				listeners.push(callback);
			}
		}
		
		/**
		 * Adds a one time listener for the event. 
		 * The listener is invoked only the first time the event is fired, after which it is removed.
		 * 
		 * @param type
		 * @param callback
		 */		
		public function once(type:String, callback:Function):void{
			on(type,callback);
			var index:int = _triggers.indexOf(callback);
			if(index == -1){
				_triggers.push(callback);
			}
		}
		
		/**
		 * Dispatches a Event to all listeners with the supplied arguments.
		 * 
		 * Arguments after the event argument can be provided and these arugments are also sent to the listener.
		 * 
		 * @param type The event identifier type.
		 * @param args
		 * @return 
		 */		
		public function emit(type:String, ...args):Boolean{
			// Determinening if any listener exist on the current event.
			if(type != null && _listeners.hasOwnProperty(type) == true){
				
				// Executes all listener methods.
				var responders:Array = _listeners[type];
				var len:int = responders.length;
				for(var i:int = 0;i<len;i++){
					var callback:Function = responders[i];
					callback.apply(null,args);
					// Determine if the callback where referenced as a once listener, in that case it's reference is removed.
					if(_triggers.indexOf(callback) != -1){
						removeListener(type,callback);
					}
				}
				return len > 0 ? true : false;
			}
			return false;
		}
		

		
		/**
		 * Remove a listener from the listener array for the specified event.
		 * 
		 * @param type The event identifier type.
		 * @param callback
		 */		
		public function removeListener(type:String, callback:Function):void{
			if(type == null || callback == null){
				throw new Error("remove listener failed! invalid of type arguments");
			}
			// Removes the listener if it exists under reference of the event type.
			var listeners:Array = _listeners[type];
			var index:int = listeners.indexOf(callback);
			if(index != -1){
				listeners.splice(index,1);
			}
			// Removes the listeners array for the type if empty.
			if(listeners.length === 0){
				listeners[type] = null;
			}
			
			// Removes the listner from once array if it exists there.
			listeners = _triggers;
			index = listeners.indexOf(callback);
			if(index != -1){
				listeners.splice(index,1);
			}
		}
		
		/**
		 * Returns an array of listeners for the specified event.
		 * 
		 * @param type
		 * @return 
		 */		
		public function listeners(type:String):Array{
			return _listeners.hasOwnProperty(type) ? this._listeners[type].concat() : null;
		}
		
		/**
		 * 
		 * @param type
		 * @return 
		 */		
		public function hasListener(type:String):Boolean{
			return _listeners.hasOwnProperty(type);
		}
	}
}

/*
Removes all listeners from the listener array for the specified event.

if(this._listeners.hasOwnProperty(event) === true){
this._listeners[event] = null;
}

*/