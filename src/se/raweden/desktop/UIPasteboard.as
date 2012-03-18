package se.raweden.desktop
{
	
	/**
	 * A <code>UIPasteboard</code> object provides a container for transferring data and resource
	 * between moduels, application and the native clipboard. A pasteboard can contain multiple items
	 * represented in more than one format. By supplying information in multiple formats the chance that
	 * other moduels and application will be able to use that information is increased.
	 * 
	 * Adding data is done with the <code>setData()</code> or <code>SetDataAt()</code> method. 
	 * Resources can be added indirect by providing a function reference as the data argument, 
	 * in that case the the function supplied is only called when the type is first requerd or 
	 * when the pasteboard is written to storage. A example usecase of adding data indirect is
	 * when raw sound data exists and a callback can be added to transcode the data into a MP3
	 * format ByteArray, the conversion will only be done if the MP3 data is actually requested.
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @see UIDragging
	 * 
	 * @author Raweden
	 */	
	public class UIPasteboard{
		
		// To determine whether a pasteboard resource contains a certain type. The <code>types</code>
		// property and the <code>typesAt()</code> method returns array 
		
		private var _items:Array;
		private var _types:Array;
		
		/**
		 * Creates an empty <code>UIPasteboard</code> object.
		 */
		public function UIPasteboard(){
			_items = [];
			_types = [];
		}
		
		
		/**
		 * 
		 */
		public function get files():Array{
			var value:Array = [];
			for(var i:int = 0;i<_items.length;i++){
				var file:Object = getDataAt("public.file",i);
				if(file != null){
					value.push(file);
				}
			}
			
			return value.length > 0 ? value : null;
		}
		
		
		/**
		 * Indicates the number of items in this pasteboard.
		 */
		public final function get length():int{
			return _items.length;
		}
		
		
		/**
		 * A <code>Array</code> of all uniqe types that this pasteboard contains.
		 */
		public function get types():Array{
			return _types.concat();
		}
		
		//------------------------------------
		// Public methodsmethods.
		
		/**
		 * 
		 * @param type
		 */
		public function clearData(type:String = null):void{
			if(type == null){
				
				return;
			}
			
			var len:int = _items.length;
			for(var i:int = 0;i<len;i++){
				var item:Object = _items[i];
				if(item.hasOwnProperty(type) == true){
					delete item[type];
				}
			}
			
		}
		
		/**
		 * 
		 * @param type
		 * @param index
		 */
		public function clearDataAt(type:String = null,index:int = 0):void{
			
		}
		
		/**
		 * 
		 * @return 
		 */		
		public function clone():UIPasteboard{
			return null;
		}
		
		
		/**
		 * Adds data 
		 * 
		 * @param type A String that identifies the data-type. Simular to a Unifrom Type Identifier.
		 * @param data Object that represents the data.
		 */
		public function setData(type:String,data:Object):void{
			setDataAt(type, data, 0);
		}
		
		/**
		 * 
		 * @param type
		 * @param data
		 * @param index
		 */
		public function setDataAt(type:String,data:Object,index:int = 0):void{
			var item:Object;
			// creates the item..
			if(_items[index] == null){
				_items[index] = {};
			}
			
			item = _items[index];
			item[type] = data;
			
			if(_types.indexOf(type) == -1){
				_types.push(type);
			}
		}
		
		/**
		 * 
		 * @param type
		 * @return 
		 */		
		public function getData(type:String):Object{
			return getDataAt(type, 0);
		}
		
		/**
		 * 
		 * @param type
		 * @param index
		 * @return 
		 */
		public function getDataAt(type:String,index:int):Object{
			if(type == null || type == ""){
				return null;
			}
			
			var item:Object = _items[index];
			
			var data:Object = item.hasOwnProperty(type) ? item[type] : null;
			
			return data is Function ? data() : data;
		}
		
		/**
		 * Returns a Array that contains the type identifiers at the specified index.
		 * 
		 * @param index
		 * @return 
		 */		
		public function typesAt(index:int):Array{
			var types:Array = [];
			var item:Object = _items[index];
			for(var type:String in item){
				types.push(type);
			}
			return types.length > 0 ? types : null;
		}
		
	}
}