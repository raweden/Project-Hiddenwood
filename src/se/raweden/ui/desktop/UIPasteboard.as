package se.raweden.ui.desktop
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
	 * @author Raweden
	 * @see UIDragging
	 */	
	public final class UIPasteboard{
		
		private var m_data:Array;
		private var m_type:Array;
		private var m_types:Array;
		public var name:String;
		
		//
		// TOOD: add better handling of multible items represented in diffrent formats.
		// TODO: add support for intergration with natvive clipboard with flash.desktop.Clipboard
		// TODO: add support for cloning data.
		//
		
		/**
		 * Creates an empty <code>UIPasteboard</code> object.
		 */
		public function UIPasteboard(){
			m_types = [];
			m_data = [];
			m_type = [];
		}
		
		//------------------------------------
		// Getting Attributes.
		//------------------------------------
		
		/**
		 * Returns a <code>Boolean</code> value that determine whether this pasteboard contains one or
		 * more instances of the format type of the <code>format</code> argument.
		 * 
		 * @param format A <code>String</code>that identifies the format. Typically the Uniform Type Identifier.
		 * @return <code>true</code> if the pasteboard contains the format, otherwise <code>false</code>
		 */
		public final function hasFormat(format:String):Boolean{
			return m_type.indexOf(format) != -1	
		}	
		
		/**
		 * A <code>Array</code> of all uniqe formats that this pasteboard contains.
		 */
		public final function get formats():Array{
			return m_types.length > 0 ? m_types.concat() : null;
		}
		
		/**
		 * Returns the number of items in this pasteboard.
		 */
		public final function get length():int{
			return -1;
		}
		
		//------------------------------------
		// Setting format.
		//------------------------------------
		
		/**
		 * Adds data and corresponding format String to the drag source.
		 * 
		 * @param data Object that specifies the drag data. This can be any object. 
		 * @param format String that specifies a label that describes the format for this data. Typically the UTI.
		 */
		public final function addData(data:Object, format:String):void{
			m_type.push(format);
			m_data.push(data);
			// pushes the uniqe format id into formats collection.
			if(m_types.indexOf(format) == -1){
				m_types.push(format);
			}
		}
		
		/**
		 * Adds a handler that is called when data for the specified format is requested.
		 * 
		 * @param data Function that specifies the handler called to request the data, This function mist return the data in the specified format.
		 * @param format String that specifies a label that describes the format for this data. Typically the UTI.
		 */
		public final function addHandler(callback:Function, format:String):void{
			m_type.push(format);
			m_data.push(callback);
			// pushes the uniqe format id into formats collection.
			if(m_types.indexOf(format) == -1){
				m_types.push(format);
			}
		}
		
		//------------------------------------
		// Getting Formats.
		//------------------------------------
		
		/**
		 * Retrives the data for the specified format.
		 * 
		 * <p>If the data was added wiht the <code>addData()</code>, it's retuned directly,
		 * in other cases where <code>addHandler()</code> is used. the pasteboard invokes the handler method to return the data.</p>
		 * 
		 * @param format String that specifies a label that describes the format for data to return.
		 * This string can be a custom value if you are creating a custom drop target with the <code>addData()</code> 
		 * method. The format string is typically the format.
		 * @return An Object containing the data in the requested format. If you drag multiple items,
		 * the returned value is an Array, if the format wasn't found the default value is <code>null</code>.
		 */
		public final function data(format:String):Object{
			var index:int = m_type.indexOf(format);
			if(index != -1){
				var data:* = m_data[index];
				if(data is Object){
					return data;
				}
				if(data is Function){
					return data();
				}
			}
			return null;
		}
		
		/**
		 * Retrives all instances of references to a specific format.
		 */		
		public final function multiData(format:String):Array{
			var index:int = m_type.indexOf(format);
			var content:Array = [];
			while(index != -1){
				var data:* = m_data[index];
				if(data is Function){
					data = data();
				}
				content.push(data);
				index = m_type.indexOf(format,index);
			}
			return content.length > 0 ? content : null;
		}
		
		/**
		 * Deletes references to the data and providers in this <code>UIPasteboard</code> object.
		 */
		public function clear():void{
			m_data.length  = 0;
			m_type.length  = 0;
			m_types.length = 0;
		}
		
		//------------------------------------
		// Getting Standard Formats.
		//------------------------------------
				
		/**
		 * Returns the first string in this pasteboard or <code>null</code> if no string where found.
		 */
		public function get string():String{
			return data("public.text") as String;
		}		
		
		/**
		 * Returns a Array of all string in this pasteboard or <code>null</code> if no string(s) where found.
		 */
		public function get strings():Array{
			return multiData("public.text");
		}
		
		/**
		 * Returns the first image in this pasteboard or <code>null</code> if no image where found.
		 */
		public function get image():BitmapData{
			return data("public.image") as BitmapData;
		}
		
		/**
		 * Returns a Array containing all images in this pasteboard or <code>null</code> if no image(s) where found.
		 */
		public function get images():Array{
			return multiData("public.image");
		}
		
		/**
		 * Returns the first url in this pasteboard or <code>null</code> if no url where found.
		 */
		public function get url():String{
			return data("public.url") as String;
		}
		
		/**
		 * Returns a Array of all urls in this pasteboard or <code>null</code> if no url(s) where found.
		 */
		public function get urls():Array{
			return multiData("public.url");
		}
		
	}
}