package net.packets.packetparts 
{
	import flash.utils.IDataInput;
	import net.packets.IPacketReader;
	import utils.formateToString;
	
	public class AddedObjectInfo implements IPacketReader 
	{
		
		public var objectType:uint;
		public var objectViewId:uint;
		
		public function AddedObjectInfo() 
		{
			
		}
		
		public function read(source:IDataInput):void 
		{
			objectType = source.readUnsignedInt();
			objectViewId = source.readUnsignedInt();
		}
		
		public function toString():String
		{
			return formateToString(this, 'objectType', 'objectViewId');
		}
		
	}

}