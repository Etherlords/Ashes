package utils.dump 
{
	import flash.utils.ByteArray;
	
	public function dump(obj:Object):String
	{
		if (obj is ByteArray)
		{
			return dumpByteArray(obj as ByteArray);
		}
		
		return '';
	}
}