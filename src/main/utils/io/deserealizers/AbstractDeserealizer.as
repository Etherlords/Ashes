package utils.io.deserealizers 
{
	import error.AbstractMethodError;
	import flash.utils.IDataOutput;
	import utils.io.IDeserealizer.as;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class AbstractDeserealizer implements IDeserealizer.as
	{
		
		public function AbstractDeserealizer() 
		{
			
		}
		
		/**
		 * @inheritDoc
		*/
		public function deserialize(source:IDataOutput):int 
		{
			throw new AbstractMethodError('deserialize');
		}
		
	}

}