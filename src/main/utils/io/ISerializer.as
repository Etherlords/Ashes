package utils.io 
{
	import flash.utils.IDataInput;
	
	public interface ISerializer extends IStreamOperator
	{
		
		/**
		 * Read data from raw byte stream
		 * @param	source an data input stream
		 * @return number of bytes readed from stream
		 */
		function serialize(source:IDataInput):int
		
	}

}