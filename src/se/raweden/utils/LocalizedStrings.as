package se.raweden.utils
{	
	import flash.net.navigateToURL;
	import flash.net.sendToURL;
	import flash.utils.flash_proxy;
	import flash.utils.getTimer;

	/**
	 * A <code>LocalizedStrings</code> object encapsulate a resource of localized strings.
	 * 
	 * <p>The localized strings are stored in the properties of this object,
	 * and both the string and properity name may contain formating syntax.
	 * The class where intended to be used with external string resource (*.strings) files.
	 * A <code>LocalizedStrings</code> object is dynamic and strings may be added and replaced
	 * at runtime, the simpliest way to get the strings is to use the bracket syntax.</p>
	 * 
	 * <p>This classes is a part of Core UI Framework.</p>
	 * 
	 * @example <listing version="3.0">
	 * 	var local:LocalizedStrings = new LocalizedStrings("name of choice","en_US");
	 * 	local.parse(data);	// parsing external string resource.
	 * 	// getting the localized string for "ok"
	 * 	button.label = local["ok"];
	 * 	// getting a more complext string for exeample a alert.
	 * 	alert.message = local["are you sure to dismiss unsaved changed?"];
	 * </listing>
	 * 
	 * @see printf
	 * @author Raweden
	 */
	public dynamic class LocalizedStrings{
		
		use namespace flash_proxy;
		
		// Regular Expression constants used for parsing and replacing format elements.
		private static const COMMENTS:RegExp = new RegExp("/\/\*[\s\S]*?\*\/|//[\s\S]*?\r/gm");
		private static const VALUE_PAIRS:RegExp = /(?<!\\)(?:")(?(1)|(\\"|[^\r"])+?")/g;
		// Instance variables.
		private var _name:String;
		private var _language:String;
		
		/**
		 * 
		 * @param name The name of the resource.
		 * @param language The language of the resource.
		 */
		public function LocalizedStrings(name:String,language:String){
			// sets data enterd from the constructor.
			_name = name;
			_language = language;
			// makes the default class parameters non enumerable (excluded when using for var in).
			this.setPropertyIsEnumerable("name",false);
			this.setPropertyIsEnumerable("length",false);
			this.setPropertyIsEnumerable("keys",false);
			this.setPropertyIsEnumerable("language",false);
		}
		
		//------------------------------------
		// Getting properties related.
		//------------------------------------
		
		/**
		 * A Array containing the names of all strings in this <code>LocalizedStrings</code> resource.
		 */
		public function get keys():Array{
			var keys:Array = new Array();
			for(var p:String in this){
				keys.push(p);
			}
			keys = keys.length == 0 ? null : keys;
			return keys;
		}
		
		/**
		 * Indicates the language of this <code>LocalizedStrings</code> resource.
		 */
		public function get language():String{
			return _language;
		}
		
		/**
		 * Indicates the number of string in this <code>LocalizedStrings</code> resource.
		 */
		public function get length():int{
			var c:int = 0;
			for(var p:String in this){
				c++;
			}
			return c == 0 ? -1 : c; 
		}
		
		/**
		 * Indicates the name of this <code>LocalizedStrings</code> resource.
		 */
		public function get name():String{
			return _name;
		}
		
		//------------------------------------
		// Getting Localized Strings
		//------------------------------------

		/**
		 * Returns the localized string for the key or null if not found.
		 * @param key The key to get the language string for.
		 * @param parms The paramters to replace the paramters in the text String.
		 * @return The localized string for the key or null.
		 */
		public function string(key:String):String{
			return this.hasOwnProperty(key) ? this[key] : null;
		}
		
		//------------------------------------
		// Manage the resource.
		//------------------------------------

		/**
		 * 
		 * @param data 
		 */
		public function parse(data:String):void{
			clear();
			parseInternal(data);
		}
		
		// parses raw data input.
		private function parseInternal(data:String):void{
			// strippes the comments off.
			data = data.replace(COMMENTS,"");
			// extracts the pairs of localized strings.
			var pair:Array = data.match(VALUE_PAIRS);			
			while(pair.length > 0){
				var key:String = pair.shift();
				key = _unescape(key);	
				var val:String = pair.shift();
				val = _unescape(val);
				this[key] = val;
			}
			
			// unescape the new line,tabs and quotes and removes starting and ending quotes.
			function _unescape(str:String):String{
				str = str.replace(/^"|"$/gm,"");
				str = str.replace("\\r","\r");
				str = str.replace("\\n","\n");
				str = str.replace("\\t","\t");
				str = str.replace("\\\"","\"");
				return str;
			}
		}
		
		/**
		 * Parses and merages the the resource with the resource of this resource.
		 * 
		 * @param data The string resource to merage into this resource.
		 */
		public function merge(data:String):void{
			parseInternal(data);
		}
			
		/**
		 * Clears the content of this LocalizedString resource resource.
		 */
		public function clear():void{
			for(var p:String in this){
				delete this[p];
			}
		}

		
	}
}