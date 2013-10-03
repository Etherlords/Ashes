package ui.model.events 
{
	import flash.events.Event;
	
	public class ProxyEvent extends Event
	{
		
		public static const UPDATE_EVENT:String = 'proxyUpdate';
		
		public function ProxyEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable)
		}
		
		override public function clone():Event 
		{
			return new ProxyEvent(type, bubbles, cancelable);
		}
	}

}