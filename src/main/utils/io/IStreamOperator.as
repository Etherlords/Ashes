package utils.io 
{
	
	/**
	 * ...
	 * @author Nikro
	 */
	public interface IStreamOperator 
	{
		function get value():Object;
		function set value(value:Object):void;
		function get isStaticSize():Boolean
		function get size():Boolean
	}
	
}