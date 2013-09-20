package utils.io.desirealizers 
{
	import error.AbstractMethodError;
	import flash.utils.IDataOutput;
	import utils.io.IDesirealizer;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class AbstractDesirealizer implements IDesirealizer
	{
		
		public function AbstractDesirealizer() 
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