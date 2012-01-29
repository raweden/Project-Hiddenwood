package se.raweden.desktop
{
	import flash.display.BitmapData;
	
	/**
	 * A <code>UIPasteboard</code> object provides a container for transferring data and objects through
	 * between application, modules and the native clipboard. A <code>UIPasteboard</code> object can contain
	 * multiple items represented in more than one format. By supplying information in multiple formats, you increase
	 * the chances that another application or module will be able to use that information. Add data to pasteboard
	 * with the <code>addData()</code> or <code>addHandler</code> method.
	 * 
	 * <p>The <code>hasFormat()</code> method is used to determine whether a <code>UIPasteboard</code> contains one or
	 * more instance of a format. Data can be added directly using the <code>addData()</code> method, or indirectly using
	 * the <code>addHandler()</code> method, in which case the data is only provided when actually required. A example of a 
	 * use case is when raw sound data exists and a callback can be added to transcode the data into valid MP3 
	 * formatted bytes the MP3 conversion will only be done if the MP3 data is actually requested.</p>
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @see UIDragging
	 * 
	 * @author Raweden
	 */	
	public final class UIPasteboard{
		
		private var m_items:Array;	// Contains all items in this pasteboard.
		private var m_types:Array;	// Contains all uniqe types identifier in this pasteboard.
		
		//
		// TODO: change methods names for contents and content, they are to simular to contains.
		// TODO: add support for intergration with natvive clipboard with flash.desktop.Clipboard.
		// TODO: merage with a api simular to Flex.
		//
		
		/**
		 * Creates an empty <code>UIPasteboard</code> object.
		 */
		public function UIPasteboard(){
			m_items = [];
			m_types = [];
		}
		
		//------------------------------------
		// Getting Attributes.
		//------------------------------------
		
		/**
		 * Returns a <code>Boolean</code> value that determine whether this pasteboard contains
		 * one or more representations of the data-type indicated by of the <code>type</code> argument.
		 * 
		 * @param type A <code>String</code> that identifies the data-type. Typically the uti.
		 * @return A <code>Boolean</code> value that determine whether the pasteboard contains the type.
		 */
		public final function contains(type:String):Boolean{
			return m_types.indexOf(type) != -1;
		}	
		
		/**
		 * A <code>Array</code> of all uniqe formats that this pasteboard contains.
		 */
		public final function get types():Array{
			return m_types.length > 0 ? m_types.concat() : null;
		}
		
		/**
		 * Indicates the number of items in this pasteboard.
		 */
		public final function get length():int{
			return m_items.length;
		}
		
		//------------------------------------
		// Setting format.
		//------------------------------------
		
		/**
		 * Adds data and corresponding format String to the drag source.
		 * 
		 * @param data Object that specifies the drag data. This can be any object. 
		 * @param type A <code>String</code> that identifies the data-type. Typically the uti.
		 */
		public final function addContent(data:Object, type:String):void{
			/*
			m_type.push(type);
			m_data.push(data);
			// pushes the uniqe format id into formats collection.
			if(m_types.indexOf(type) == -1){
				m_types.push(type);
			}
			*/
		}
		
		/**
		 * Adds a handler that is called when data for the specified format is requested.
		 * 
		 * @param callback Function that specifies the handler called to request the data, This function mist return the data in the specified format.
		 * @param type A <code>String</code> that identifies the data-type. Typically the uti.
		 */
		public final function addHandler(callback:Function, type:String):void{
			/*
			m_type.push(type);
			m_data.push(callback);
			// pushes the uniqe format id into formats collection.
			if(m_types.indexOf(type) == -1){
				m_types.push(type);
			}
			*/
		}
		
		//------------------------------------
		// Getting Formats.
		//------------------------------------
		
		/**
		 * 
		 * 
		 * @param type A <code>String</code> that identifies the data-type. Typically the uti.
		 * @return
		 */
		public final function content(type:String):Object{
			return m_items.length > 0 ? contentAt(type,0) : null;
		}
		
		/**
		 * 
		 * 
		 * @param type A <code>String</code> that identifies the data-type. Typically the uti.
		 * @return
		 */
		public final function contents(type:String):Array{
			if(m_types.indexOf(type) != -1){
				var len:int = m_items.length;
				var items:Array = [];
				var content:Object;
				for(var i:int = 0;i<len;i++){
					content = contentAt(type,i);
					if(content != null)
						items.push(content);
				}
				return items.length > 0 ? items : null;
			}
			return null;
		}
		
		/**
		 * 
		 * @param type A <code>String</code> that identifies the data-type. Typically the uti.
		 * @param index
		 */		
		private function contentAt(type:String,index:int):Object{
			var item:Object = m_items[index];
			var content:Object = item && item.hasOwnProperty(type) ? item[type] : null;
			if(content is Function)
				content = content();
			return content;
		}
		
		/**
		 * Clears all items and references to the data and providers in this <code>UIPasteboard</code> object.
		 */
		public final function clear():void{
			m_items.length = 0;
			m_types.length = 0;
		}
		
		/**
		 * 
		 * @return 
		 */
		public final function clone():UIPasteboard{
			return null;
		}
		
		//------------------------------------
		// Managing Multi-items.
		//------------------------------------
		
		/**
		 * 
		 */
		public final function addItem(item:Object):void{
			var data:Object;
			var index:int = m_items.length;
			for(var type:String in item){
				data = item[type];
				if(data is Function){
					_data(data,type,index);
				}else{
					_data(data,type,index);
				}
			}
		}
		
		private function _data(data:Object,type:String,index:int):void{
			var item:Object = m_items[index];
			if(!item){
				item = {};
				m_items[index] = item;
			}
			item[type] = data;
			if(m_types.indexOf(type) == -1){
				m_types.push(type);
			}
		}
		
		/**
		 * The value of this property is an array of objects.
		 * Each object represents a pasteboard item, with the key being the representation type
		 * and the value the data object accociated with that type. Setting this property 
		 * replaces all of the current pasteboard items.
		 */
		public final function set items(value:Array):void{
			var len:int = value.length;
			for(var i:int = 0;i<len;i++){
				var item:Object = value[i];
				if(item){
					addItem(item);	
				}
			}
		}
		// 
		public final function get items():Array{
			return m_items;
		}
		
		
		//------------------------------------
		// Getting Standard Formats.
		//------------------------------------
						
		/**
		 * The data stored in this is a <code>String</code> object.
		 * Setting this property replaces all current items in the pasteboard with the new item. 
		 * If the first item isn't represented as the type <code>null</code> is returned.
		 */
		public final function set string(value:String):void{
			this.clear();
			this.addContent(value,PLAIN_TEXT);
		}
		// returns the first items string data type.
		public final function get string():String{
			return content(PLAIN_TEXT) as String;
		}
		
		/**
		 * The data stored in this property is an array <string>String</code> objects.
		 * Setting this property replaces all current items in the pasteboard with the new items.
		 * The returned array may have fewer items than the number of items in the pasteboard,
		 * this happens when a item in the pasteboard doesn't have a representation of the 
		 * indicated type. If no item is represented as the type, <code>null</code> is returned.
		 */
		public final function set strings(value:Array):void{
			clear();
			// inserting the new items.
			var item:Object;
			var str:String;
			for(var i:int = 0;i<value.length;i++){
				str = value[i];
				if(url){
					item = new Object();
					item[PLAIN_TEXT] = str;
					m_items.push(item);
				}
			}
		}
		//
		public final function get strings():Array{
			return contents(PLAIN_TEXT);
		}
		
		/**
		 * The data stored in this is a <code>Bitmapdata</code> object.
		 * Setting this property replaces all current items in the pasteboard with the new item. 
		 * If the first item isn't represented as the type <code>null</code> is returned.
		 */
		public final function set image(value:BitmapData):void{
			clear();
			addContent(value,IMAGE);
		}
		// returns the first item image data-type.
		public final function get image():BitmapData{
			return content(IMAGE) as BitmapData;
		}
		
		/**
		 * The data stored in this property is an array <string>BitmapData</code> objects.
		 * Setting this property replaces all current items in the pasteboard with the new items.
		 * The returned array may have fewer items than the number of items in the pasteboard,
		 * this happens when a item in the pasteboard doesn't have a representation of the 
		 * indicated type. If no item is represented as the type, <code>null</code> is returned.
		 */
		public final function set images(value:Array):void{
			clear();
			// inserting the new items.
			var item:Object;
			var img:BitmapData;
			for(var i:int = 0;i<value.length;i++){
				img = value[i];
				if(url){
					item = new Object();
					item[URL] = url;
					m_items.push(item);
				}
			}
		}
		// 
		public final function get images():Array{
			return contents(IMAGE);
		}
		
		/**
		 * The data stored in this is a <code>String</code> object.
		 * Setting this property replaces all current items in the pasteboard with the new item. 
		 * If the first item isn't represented as the type <code>null</code> is returned.
		 */
		public final function set url(value:String):void{
			
		}
		// 
		public final function get url():String{
			return content(URL) as String;
		}
		
		/**
		 * The data stored in this property is an array <string>String</code> objects.
		 * Setting this property replaces all current items in the pasteboard with the new items.
		 * The returned array may have fewer items than the number of items in the pasteboard,
		 * this happens when a item in the pasteboard doesn't have a representation of the 
		 * indicated type. If no item is represented as the type, <code>null</code> is returned.
		 */
		public final function set urls(value:Array):void{
			clear();
			// inserting the new items.
			var item:Object;
			var url:String;
			for(var i:int = 0;i<value.length;i++){
				url = value[i];
				if(url){
					item = new Object();
					item[URL] = url;
					m_items.push(item);
				}
			}
		}
		// 
		public final function get urls():Array{
			return contents(URL);
		}
		
		private static const IMAGE:String = "public.image";
		private static const PLAIN_TEXT:String = "public.text";
		private static const HTML_TEXT:String = "public.html";
		private static const RICH_TEXT:String = "public.rtf";
		private static const URL:String = "public.url";
		private static const FILE:String = "public.file";
		
	}
}
/* Flex Implementation

formats : Array
[read-only] Contains the formats of the drag data, as an Array of Strings.

Public Methods

addData(data:Object, format:String):void
Adds data and a corresponding format String to the drag source.

addHandler(handler:Function, format:String):void
Adds a handler that is called when data for the specified format is requested.

dataForFormat(format:String):Object
Retrieves the data for the specified format.

hasFormat(format:String):Boolean
Returns true if the data source contains the requested format; otherwise, it returns false.

*/

/* iOS implementation

Getting and Removing Pasteboards
+ generalPasteboard
+ pasteboardWithName:create:
+ pasteboardWithUniqueName
+ removePasteboardWithName:

Getting and Setting Pasteboard Attributes
  name  property
  persistent  property
  changeCount  property

Determining Types of Single Pasteboard Items
– pasteboardTypes
– containsPasteboardTypes:

Getting and Setting Single Pasteboard Items
– dataForPasteboardType:
– valueForPasteboardType:
– setData:forPasteboardType:
– setValue:forPasteboardType:

Determining the Types of Multiple Pasteboard Items
numberOfItems  property
– pasteboardTypesForItemSet:
– itemSetWithPasteboardTypes:
– containsPasteboardTypes:inItemSet:

Getting and Setting Multiple Pasteboard Items
  items  property
– dataForPasteboardType:inItemSet:
– valuesForPasteboardType:inItemSet:
– addItems:

Getting and Setting Pasteboard Items of Standard Data Types
  string  property
  strings  property
  image  property
  images  property
  URL  property
  URLs  property
  color  property
  colors  property

*/
