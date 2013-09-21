package utils.io.serializers 
{
	//import error.AbstractMethodError;
	import flash.utils.IDataInput;
	import utils.io.ISerializer;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class AbstractSerializer implements ISerializer 
	{
		
		protected var _size:int;
		protected var _isStaticSize:Boolean;
		protected var _value:Object
		
		public function AbstractSerializer() 
		{
			
		}
		
		/**
		 * @inheritDoc
		 */
		public function serialize(source:IDataInput):int 
		{
			//throw(new AbstractMethodError('serialize'));
			return 0;
		}
		
		/* INTERFACE utils.io.ISerializer */
		
		public function get value():Object 
		{
			return _value;
		}
		
		public function set value(value:Object):void 
		{
			_value = value;
		}
		
		public function get isStaticSize():Boolean 
		{
			return _isStaticSize;
		}
		
		public function get size():int 
		{
			return _size;
		}
		
	}

}