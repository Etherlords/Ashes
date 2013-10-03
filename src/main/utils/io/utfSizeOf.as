package utils.io 
{

	public function utfSizeOf(str:String):int
	{
		var strlen:int = str.length;
		var utflen:int = 0;
		var c:int = 0;

		/* use charAt instead of copying String to char array */
		for (var i:int = 0; i < strlen; i++) {
			c = str.charCodeAt(i);
			if ((c >= 0x0001) && (c <= 0x007F)) {
				utflen++;
			} else if (c > 0x07FF) {
				utflen += 3;
			} else {
				utflen += 2;
			}
		}

		return utflen + 2;
	}
		
}