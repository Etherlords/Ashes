package utils 
{
	import flash.utils.getQualifiedClassName;
	
	public function formateToString(...rest:Array):String
	{
		var target:Object = rest.shift();
		
		var isHaveInfoObject:Boolean = (getQualifiedClassName(rest[0]) != UtilsConstants.STRING_IDNET);
		
		if(isHaveInfoObject)
			var infoObject:Object = rest.shift()
		
		var fields:Array = rest;
		
		var s:String = getQualifiedClassName(isHaveInfoObject? infoObject:target) + UtilsConstants.TO_STRING_START;//String(target);
		var field:String;
		var l:int = fields.length;
		
		for (var i:int = 0; i < l; i++)
		{
			field = fields[i];
			s += field + UtilsConstants.TO_STRING_DECORATION + target[field];
			
			if (i < l-1)
				s += UtilsConstants.TO_STRING_DELEMITER;
		}
		
		s += UtilsConstants.TO_STRING_END;
		
		return s;
	}

}