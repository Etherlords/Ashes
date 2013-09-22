package utils.dump 
{
	import flash.utils.ByteArray;
	
	public function dumpByteArray(obj:ByteArray):String 
	{
		var s:String = '';
		var l:int = obj.length
		
		for (var i:int = 0; i < l; i++)
		{
			s += obj[i];
			
			if (i != l - 2)
				s += ', ';
		}
		
		return s;
	}
}