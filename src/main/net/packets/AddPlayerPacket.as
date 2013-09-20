package net.packets 
{
	import net.packets.packetparts.AddedObjectInfo;
	import net.packets.packetparts.MoveInfo;
	import net.packets.packetparts.PlayerInfo;
	import net.packets.packetparts.Position;
	/**
	 * ...
	 * @author Nikro
	 */
	public class AddPlayerPacket extends BasePacket 
	{
		
		public var playerInfo:PlayerInfo = new PlayerInfo();
		public var position:Position = new Position();
		public var addedObject:AddedObjectInfo = new AddedObjectInfo();
		public var moveInfo:MoveInfo = new MoveInfo();
		
		public function AddPlayerPacket() 
		{
			super();
		}
		
		private function initilize():void 
		{
			super.initilize();
			
			addPart(playerInfo);
			addPart(position);
			addPart(addedObject);
			addPart(moveInfo);
		}
		
	}

}