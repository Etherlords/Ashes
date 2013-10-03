package ui.setters 
{
	import com.bit101.components.Component;
	import flash.events.Event;
	/**
	 * ...
	 * @author Nikro
	 */
	public class CompsValueProxy 
	{
		
		private var _source:Component;
		public var valueSource:String;
		public var valueToSet:String;
		public var target:Object;
		
		public function CompsValueProxy() 
		{
			
		}
		
		public function setValue():void
		{
			if (!target)
				return;
				
			if (target[valueToSet] is Function)
				target[valueToSet](_source[valueSource]);
			else
				target[valueToSet] = _source[valueSource];
		}
		
		public function get source():Component 
		{
			return _source;
		}
		
		public function set source(value:Component):void 
		{
			if (_source)
				_source.removeEventListener(Event.CHANGE, onChange);
			
			_source = value;
			_source.addEventListener(Event.CHANGE, onChange);
		}
		
		private function onChange(e:Event):void 
		{
			
			setValue();
		}
		
	}

}