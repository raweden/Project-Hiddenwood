package
{
	import se.raweden.logging.Logger;
	import se.raweden.logging.Level;
	
	/**
	 * Writes to runtime logger. A single log statement can support multiple arguments.
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @param args One or more (comma separated) expression to evaluate. For multiple expressions, a space is inserted between each expression in the output.
	 * 
	 * @author Raweden
	 */
	public function log(...args:*):void{
		var level:Level = args.length > 0 && Level.hasLevel(args[0]) ? Level.level(args[0]) : Level.TRACE;
		var line:String;
		// logging error
		if(args[0] is Error){
			// getting level and error text.
			level = Level.ERROR;
			line = args[0].text;
			// outputing the line to log.
			Logger.log.log(level,line);
		}else if(args[0] is Level){
			level = args.shift();
			line = args.join(" ");
			Logger.log.log(level,line);
		}
		else{
			line = args.join(" ");
			Logger.log.log(level,line);
		}
		trace.apply(null,args);
	}
	
}