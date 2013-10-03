package ui.model 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	import ui.model.events.ProxyEvent;

	/**
	 * @eventType	patterns.events.LazyModeratorEvent.UPDATE_EVENT
	 */
	[Event(name="proxyUpdate", type="ui.model.events.ProxyEvent")] 
	public dynamic class ObjectProxy extends Proxy implements IObjectProxy, IEventDispatcher
	{
		
		private var defaultvalue:Object = { };
		
		public var isCastingUpdate:Boolean = true;
		public var target:Object = { };
		public var changedFields:Object = { };
		
		private var dispatcher:EventDispatcher = new EventDispatcher();
		
		public function ObjectProxy() 
		{
			
		}
		
		override flash_proxy function hasProperty(name:*):Boolean 
		{
			return name in target;
		}
		
		override flash_proxy function getProperty(name:*):* 
		{
			if (name.localName in  target)
				return target[name.localName]
			else
				return defaultvalue;
		}
		
		override flash_proxy function setProperty(name:*, value:*):void 
		{
			target[name.localName] = value;
			markField(name);
		}
		
		public function markField(fieldName:String):void 
		{
			changedFields[fieldName] = true;
		}
		
		private static var updateEvent:ProxyEvent = new ProxyEvent(ProxyEvent.UPDATE_EVENT);
		public function update():void 
		{
			if(isCastingUpdate)
				dispatchEvent(updateEvent);
				
			clean();
		}
		
		public function getUpdatedFields():Object 
		{
			return changedFields;
		}
		
		public function clean():void 
		{
			changedFields = { };
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean 
		{
			return dispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean 
		{
			return dispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean 
		{
			return dispatcher.willTrigger(type);
		}
		
	}

}