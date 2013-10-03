package utils.configuration 
{
	
	/**
	 * ...
	 * @author Nikro
	 */
	public interface IConfigReader 
	{
		
		function read(config:XML):void;
		function inject():void
		function callConstructor():void
		function get ident():String;
	}
	
}