package net.commands 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Nikro
	 */
	public class PlayerAddCommand implements INetCommand
	{
		
		public static const IDENT:String = 'PlayerAddCommand';
		
		public var id:int;
		public var modelIdent:int;
		public var modelPath:String;
		public var position:Point;
		
		
		public function PlayerAddCommand() 
		{
			
		}
		
		public function fill(obj:Object):void
		{
			
		}
		
	}

}