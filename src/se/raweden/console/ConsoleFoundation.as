//
//	BashFoundation.as
//	Core UI Addition Framework
//
//	Created by Raweden on 2011-08-11
//	Copyright 2011 Raweden. Some rights reserved.
//

package se.raweden.console
{
	/**
	 * The <code>ConsoleFoundation</code> contains a collection of classes that represents the default built in commands.
	 * 
	 * <p>Copyright 2011, Raweden. All Rights Reserved.</p>
	 * 
	 * @author Raweden
	 */
	public class ConsoleFoundation{
		
		private static var _classUtils:IConsoleCommand;
		
		private static var _fontUtils:IConsoleCommand;
		
		private static var _helpUtils:IConsoleCommand;
		
		
		/**
		 * Returns the class untilty commmand.
		 */
		public static function get classUtils():IConsoleCommand{
			if(!_classUtils){
				_classUtils = new CMDClassExists();
			}
			return _classUtils;
		}

		/**
		 * Returns the font untilty commmand.
		 */
		public static function get fontUtils():IConsoleCommand{
			if(!_fontUtils){
				_fontUtils = new CMDFont();
			}
			return _fontUtils;
		}

		/**
		 * Returns the help command.
		 * 
		 * The help command prints a list of all commands registerd to the bash.
		 */
		public static function helpUtils(commands:Array = null):IConsoleCommand{
			if(!_helpUtils){
				_helpUtils = new CMDHelp(commands)
			}
			return _helpUtils;
		}


	}
}

import flash.text.Font;
import flash.utils.getDefinitionByName;

import se.raweden.console.IConsoleCommand;
import se.raweden.utils.StringUtil;



/**
 * Command for checking if the class exists inside the current ApplicationDomain.
 */
class CMDClassExists implements IConsoleCommand{
	
	public function CMDClassExists(){
		
	}
	
	// the name of the command.
	public function get name():String{
		return("class");
	}
	
	// the lenght requierd.
	public function get lenght():int{
		return(0);
	}
	
	// help proivied over the command.
	public function get help():String{
		return("Observering classes in the current application domain.");
	}
	
	// executes the command.
	public function execute(...args:*):String{
		var action:String = args.shift();
		if(action == "exists"){
			return exists.apply(null,args);
		}
		return("-bash: class: invalid action");
		
		// action for checking if class exists.
		function exists(...args:*):String{
			var classname:String = args.shift();
			var result:Class;
			try{
				result = Class(getDefinitionByName(classname));
				if(result == null){
					return "-bash: class: class does not exist.";
				}else{
					return "-bash: class: \""+classname+"\" exists.";
				}
			}
			catch(error:Error){
				return "-bash: class: class does not exist.";
			}
			return null;
		}
	}
}

/**
 * Command for output the help for all registered commands.
 */
class CMDHelp implements IConsoleCommand{
	
	private var m_commands:Array;
	
	public function CMDHelp(commands:Array){
		m_commands = commands;
	}
	
	// the requerd lenght of paramters.
	public function get lenght():int{
		return(0);
	}
	
	// the execution name of the command.
	public function get name():String{
		return("help");
	}
	
	// help for the command.
	public function get help():String{
		return("Shows a either normal help screen, all commands or,\nif a command name is provided, some help for that command.");
	}
	
	// executes the command.
	public function execute(...args:*):String{
		var len:int = m_commands.length;
		var cmd:IConsoleCommand
		var str:String = "";
		for(var i:int = 0;i<len;i++){
			cmd = m_commands[i] as IConsoleCommand;
			str += StringUtil.fillAtEnd(cmd.name,15);
			str += " - "+cmd.help+"\n";
		}
		return(str);
	}	
}

/**
 * Command for output the help for all registered commands.
 */
class CMDFont implements IConsoleCommand{
	
	private var m_commands:Array;
	
	public function CMDFont(){
		
	}
	
	// the requerd lenght of paramters.
	public function get lenght():int{
		return(0);
	}
	
	// the execution name of the command.
	public function get name():String{
		return("font");
	}
	
	// help for the command.
	public function get help():String{
		return("Observing fonts and types use \"font help\" for more info");
	}
	
	// executes the command.
	public function execute(...args:*):String{
		var action:String = args[0];
		var result:String;
		// action for listing all fonts registerd.
		if(action == "listall"){
			return listall.apply(null,null);
		}
		// action for getting the number of fonts registerd.
		if(action == "length"){
			return length.apply(null,null);
		}
		return "-bash: font: invalid action"
		
		// internal method for listing all fonts..
		function listall():String{
			var fonts:Array = Font.enumerateFonts(true);
			for(var i:int = 0;i<fonts.length;i++){
				fonts[i] = fonts[i].fontName;
			}
			return "All registered fonts\n"+fonts.join(",");
		}
		
		// internal method for getting the number of fonts.
		function length():String{
			return "-bash: font: "+Font.enumerateFonts(true).length+" registered font(s)";
		}
	}	
}