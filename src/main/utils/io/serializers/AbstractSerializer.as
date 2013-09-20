package utils.io.serializers 
{
	import error.AbstractMethodError;
	import flash.utils.IDataInput;
	import utils.io.ISerializer;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class AbstractSerializer implements ISerializer 
	{
		
		public function AbstractSerializer() 
		{
			
		}
		
		/**
		 * @inheritDoc
		 */
		public function serialize(source:IDataInput):int 
		{
			throw new AbstractMethodError('serialize');
		}
		
	}

}