//
//	UIPasteboard.as
//	Core UI Framework
//
//	Created by Jesper Svensson on 2011-07
//	Copyright 2011 Jesper Svensson. All rights reserved.
//
package se.raweden.ui.desktop
{
	/**
	 * A <code>UIPasteboard</code> object represents data that is beeing draged or internal copy and paste.
	 * 
	 * <p>The data can represented in multible formats and can also contain a collection of items.
	 * Each type of data is identified by a string that indicates the format of the data.</p>
	 * 
	 * <p><h1>Usage</h1>
	 * The <code>hasFormat()</code> method is used to determine if a <code>UIPasteboard</code> has data in certain foramt.
	 * Data can be added directly using <code>addData()</code> method, or indirectly using <code>addHandler()</code> method 
	 * for special cases when your for example if you have raw sound data you can add an MP3 format handler, then
	 * the MP3 conversion will only be done if the MP3 data is requested.</p>
	 * 
	 * @author Raweden
	 */	
	public final class UIPasteboard{
		
		private var _data:Object = new Object();
		public var name:String;
		
		/*
		 * TODO:
		 * add getters for common formats like:
		 * string, image(s), URL(s) and color(s). 
		 */
		
		public function UIPasteboard(){

		}
		
// // // // // // // // // // // // // 
// DRAGSOURCE PARAMTERS
		
		/**
		 * Contains the formats of the dag data, as an Array of Strings. set this property using the <code>addData()</code> or <code>addHandler()</code> methods. The default value depends on data added to the DragSource object.
		 */
		public function get formats():Array{
			var array:Array = new Array();
			for(var p:String in _data){
				array.push(p);
			}
			return(array);
		}
		
// // // // // // // // // // // // // 
// DRAGSOURCE METHODS
		
		/**
		 * Adds data and corresponding format String to the drag source.
		 * @param data Object that specifies the drag data. This can be any object.
		 * @param format String that specifies a label that describes the format for this data.
		 */
		public function addData(data:Object, format:String):void{
			_data[format] = data;
		}
		
		/**
		 * Adds a handler that is called when data for the specified format is requested.
		 * @param data Function that specifies the handler called to request the data, This function mist return the data in the specified format.
		 * @param format String that specifies a label that describes the format for this data.
		 */
		public function addHandler(callback:Function, format:String):void{
			_data[format] = callback;
		}
		
		/**
		 * <p>Retrives the data for the specified format.</p>
		 * <p>If the data was added with the <code>addData()</code> method, it is returned directly.
		 * If the data was added with the <code>addHandler()</code> method,the handler function is called to return the data.</p>
		 * @param format String that specifies a label that describes the format for data to return. This string can be a custom value if you are creating a custom drop target with the <code>addData()</code> method.
		 * @return An Object containing the data in the requested format. If you drag multiple items, the returned value is an Array, if the format wasn't found the default value is <code>null</code>.
		 */
		public function dataFormFormat(format:String):Object{
			var data:* = _data[format];
			// returns the solid object if object.
			if(data is Object){
				return(data);
			}
			// returns the object from handler.
			if(data is Function){
				return(data());
			}
			return(data);
		}

		/**
		 * Returns <code>true</code> if the the data source contains the requeted format; otherwise, its returns <code>false</code>.
		 * @param format String that specifies a label that describes the format for the data.
		 * @return <code>true</code> if the data source contains the requested format.
		 */
		public function hasFormat(format:String):Boolean{
			return(_data.hasOwnProperty(format))	
		}		
	}
}