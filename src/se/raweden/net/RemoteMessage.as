package se.raweden.net
{
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.utils.getTimer;
	
	import se.raweden.utils.IDisposable;

	/**
	 * A <code>RemoteMessage</code> encapsulates a method call to a backend rpc .
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 *
	 * @author Raweden
	 */
	public class RemoteMessage implements IDisposable{
		
		private var _command:String;
		private var _arguments:Array;
		private var _callback:Function;
		private var _resived:Boolean = false;
		private var _latancy:int;
		private var _sent:Boolean = false;
		private var _errors:Boolean = false;
		//
		private var _responder:Responder;
		private var _connection:NetConnection;
		
		/**
		 * 
		 * 
		 * @param	connection
		 * @param	command
		 * @param	callback example: <code>function(data:Object,message:RpcMessage):void</code>
		 * @param	...arguments
		 */
		public function RemoteMessage(connection:NetConnection,command:String,callback:Function,...arguments:*){
			trace("request method for "+command+" where created");
			_connection = connection;
			_command = command;
			_arguments = arguments;
			_callback = callback;
			_responder = new Responder(onResult,onFault);
		}
		
		/**
		 * Indicates the <code>NetConnection</code> over which the message is sent.
		 */		
		public final function get connection():NetConnection{
			return _connection;
		}
		
		/**
		 * Indicates the service command of the message.
		 */
		public final function get command():String{
			return _command;
		}
		
		/**
		 * Indicates the latancy time in millisecounds.
		 */
		public final function get latancy():int{
			return _resived ? _latancy : -1;
		}
		
		/**
		 * A Boolean value determine whether the method result have been resived.
		 */
		public final function get resived():Boolean{
			return _resived;
		}
		
		/**
		 * A Boolean value determine whether the method message have been sent using the <code>send()</code> method.
		 */
		public final function get sent():Boolean{
			return _sent;
		}
		
		/**
		 * A Boolean value determine whether the method message resulted in a service error.
		 */		
		public final function get isFault():Boolean{
			return _errors;
		}
		
		//------------------------------------
		// Sending Method Message
		//------------------------------------
		
		/**
		 * 
		 */
		public function send():void{
			if(_sent){
				return;
			}
			var arguments:Array = [_command,_responder];
			arguments = arguments.concat(_arguments);
			_connection.call.apply(_connection,arguments);
			_latancy = getTimer();
			_sent = true;
		}
		
		//------------------------------------
		// Private Responders.
		//------------------------------------
		
		/**
		 * This methos is invoked when result is retrived from service.
		 */
		private final function onResult(data:Object):void{
			trace("on result triggerd");
			_latancy = getTimer()-_latancy;
			_resived = true;
			
			_callback(data,this);
			dispose();
		}
		
		/**
		 * This method is invoked when fault event is retrived from service.
		 */
		private final function onFault(data:Object):void{
			trace("on fault triggerd");
			_latancy = getTimer()-_latancy;
			_errors = true;
			_resived = true;
			
			_callback(data,this);
			dispose();
		}
		
		//------------------------------------
		// Utility methods 
		//------------------------------------		
		
		/**
		 * 
		 */
		public final function dispose():void{
			_connection = null;
			_arguments = null;
			_callback = null;
			_responder = null;
		}
		
	}
}