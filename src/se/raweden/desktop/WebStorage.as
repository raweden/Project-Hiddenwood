package se.raweden.desktop
{
	import flash.events.EventDispatcher;
	import flash.net.NetConnection;
	
	import se.raweden.utils.IDictionary;

	/**
	 * A <code>WebStorage</code> Object provides a storage for application sittings.
	 * 
	 * 
	 */
	public class WebStorage extends EventDispatcher implements IDictionary{
		
		private var proxy:WebStorageProxy;
		
		/**
		 * Not Implemented!
		 */
		public static function get sharedWebStorage():WebStorage{
			return null;
		}
		
		public function WebStorage(namespace:String){
			proxy = WebStorageProxy.proxyForNamespace(namespace);
		}
				
		//------------------------------------
		// Getting Attributes.
		//------------------------------------
		
		/**
		 * Determine the size of the <code>WebStorage</code> in bytes.
		 */
		public final function get size():uint{
			return 0;
		}
		
		//------------------------------------
		// Methods
		//------------------------------------
		
		/**
		 * Sets a key/value pair.
		 */
		public final function setItem(key:String,value:*):void{
			return proxy.setProperty(key,value);
		}
		
		/**
		 * Returns the value associated with the given key
		 */
		public final function getItem(key:String):*{
			return proxy.getProperty(key);
		}
		
		/**
		 * Removes the item with the specified key.
		 */
		public final function removeItem(key:String):Boolean{
			return proxy.removeProperty(key);
		}
		
		/**
		 * Determine whether the WebStorage has the item with the specified key.
		 */
		public final function hasItem(key:String):Boolean{
			return proxy.hasProperty(key);
		}
		
		/**
		 * Removes all key/value pairs.
		 */
		public final function clear():void{
			return proxy.clear();
		}
		
		/**
		 * Indicates to the server that the value of a property has been changed.
		 * 
		 * This method marks properties as dirty, which means changed. The <code>WebStorage</code> invokes
		 * <code>setDirty()</code> as it's properties are set or removed. In cases when <code>WebStorage</code>
		 * contains a object that contains it's own properties, call <code>setDirty()</code> to flush the
		 * chanes to the storage.
		 */
		public final function setDirty(name:String):void{
			proxy.setDirty(name);
		}
		
		//
		
		public final function connect(connection:NetConnection):void{
			proxy.connection = connection;
		}
		
		public final function flush():void{
			WebStorageProxy.flush();
		}
		
	}
}
import flash.events.TimerEvent;
import flash.net.NetConnection;
import flash.utils.Timer;

import se.raweden.net.RemoteMessage;
import se.raweden.desktop.WebStorage;

class WebStorageProxy{
	
	private static var _timer:Timer;
	private static var _connection:NetConnection;
	private static var _namespaces:Array = new Array();
	private static var _instances:Array = [];
	
	private var _connection:NetConnection;
	private var _namespace:String;
	private var _name:QName;
	private var _data:Object = {};
	private var _dirty:Array = [];	// contains the names of properties that have been updated.
	private var _unset:Array = [];	// contains the names of properties that have been removed.
	
	public static function proxyForNamespace(namespace:String):WebStorageProxy{
		init();
		if(namespace != null){
			if(_namespaces.hasOwnProperty(namespace)){
				return _namespaces[namespace] as WebStorageProxy;
			}else{
				return new WebStorageProxy(namespace);
			}
		}
		return null;
	}
	
	private static function init():void{
		if(!_timer){
			_timer = new Timer(5000);
			_timer.addEventListener(TimerEvent.TIMER,onTimer);
			//_timer.start();
		}
	}
	
	public function WebStorageProxy(namespace:String){
		_name = new QName(namespace.toLowerCase());
		_instances.push(this);
	}
	
	public static function get namespaces():Array{
		return _namespaces;
	}
		
	//-----------------------------------
	// Managing Properties.
	//-----------------------------------
	
	/**
	 * Sets a key/value pair.
	 * 
	 * @param key
	 * @param value
	 */
	public final function setProperty(key:String,value:*):void{
		_data[key] = value;
		setDirty(key);
	}
	
	/**
	 * Returns the value associated with the given key.
	 * 
	 * @param key
	 * @return The value of the key.
	 */
	public final function getProperty(key:String):*{
		return _data[key];
	}
	
	/**
	 * Removes the item with the specified key.
	 * 
	 * @param key
	 * @return A Boolean value that determine if the key where removed.
	 */
	public final function removeProperty(key:String):Boolean{
		if(delete _data[key]){
			if(_unset.indexOf(key) == -1){
				_unset.push(key);
			}
			return true;
		}
		return false;
	}
	
	/**
	 * Determine whether the WebStorage has the item with the specified key.
	 * 
	 * @param key
	 * @return A Boolean value that determine whether the key exists.
	 */
	public final function hasProperty(key:String):Boolean{
		return _data.hasOwnProperty(key);
	}
	
	/**
	 * Removes all key/value pairs.
	 */
	public final function clear():void{
		for(var key:String in _data){
			removeProperty(key);
		}
	}
	
	//-----------------------------------
	//
	//-----------------------------------
	
	public function setDirty(name:String):void{
		if(_dirty.indexOf(name) == -1){
			_dirty.push(name);
		}
	}
	
	public static function flush():void{
		flushPrivate();
	}
	
	private static function flushPrivate():void{
		var namespaces:Array = [];
		var dirty:Object;
		var storage:WebStorageProxy;
		for(var i:String in _instances){
			storage = _instances[i];
			dirty = storage.flush();
			if(dirty)
				namespaces.push(dirty);
		}
		if(namespaces.length > 0){
			new RemoteMessage(_connection,"WebStorage.update",onFlush,dirty);
			trace("flush to web-storage as got dirty properties");
		}else{
			trace("skip flush to web-storage as no dirty properties");
		}
	}
	
	private static function onFlush(data:Object,message:RemoteMessage):void{
		trace("on flush triggerd by remote callback");
	}
	
	//-----------------------------------
	// 
	//-----------------------------------
	
	/**
	 * 
	 */
	public function set connection(value:NetConnection):void{
		_connection = value;
	}
	//
	public function get connection():NetConnection{
		return _connection;
	}
	
	
	/**
	 * 
	 */
	private function flush():Object{
		if(_dirty.length == 0)
			return null;
		// 
		var dirty:Object = {};
		while(_dirty.length > 0){
			var p:String = _dirty.shift();
			dirty[p] = _data[p];
			trace("flush property:",p);
		}
		return {namespace:_namespace,plist:dirty};
	}
	
	//------------------------------------
	// Managing Auto Flush
	//------------------------------------
	
	private static function onTimer(e:TimerEvent):void{
		flushPrivate();
	}
	
}