package utils.io 
{
	
	/**
	 * ...
	 * @author Nikro
	 */
	public interface IStream 
	{
		function addSerializer(serializer:ISerializer):void
		function addDesirealizer(deserializer:IDeserializer):void
	}
	
}