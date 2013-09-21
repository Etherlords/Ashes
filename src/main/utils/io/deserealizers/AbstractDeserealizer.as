package utils.io.deserealizers 
{
	//import error.AbstractMethodError;
	import flash.utils.IDataOutput;
	import utils.io.IDeserializer;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class AbstractDeserealizer implements IDeserializer
	{
		protected var _size:int;
		protected var _isStaticSize:Boolean;
		protected var _value:Object
		
		public function AbstractDeserealizer() 
		{
			
		}
		
		/**
		 * @inheritDoc
		*/
		public function deserialize(source:IDataOutput):int 
		{
			//throw(new AbstractMethodError('deserialize'));
			return 0;
		}
		
		
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