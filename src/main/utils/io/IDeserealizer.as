package utils.io 
{
	import flash.utils.IDataOutput;
	
	public interface IDeserealizer 
	{
		
		/**
		 * Write data to stream as raw bytes
		 * @param	source an output stream implementation
		 * @return number of bytes writed into stream
		 */
		function deserialize(source:IDataOutput):int
		
	}

}