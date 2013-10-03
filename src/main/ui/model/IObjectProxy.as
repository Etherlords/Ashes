package ui.model 
{
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public interface IObjectProxy extends IEventDispatcher
	{
		function markField(fieldName:String):void;
		function update():void;
		function getUpdatedFields():Object;
		function clean():void;
		
	}
	
}