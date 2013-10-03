package  
{
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	import flash.utils.CompressionAlgorithm;
	import flash.utils.getTimer;
	import net.ConnectionManager;
	import net.DataReader;
	import net.PingSender;
	
	public class TestNet extends Sprite 
	{
		[Inject]
		public var connection:ConnectionManager;
		
		public function TestNet() 
		{
			super();
			
			new ApplicationBootstrap().launch(stage);
			inject(this);

			connection.connect();
			
			new PingSender();
			
			return;
			
			var data:DataReader = new DataReader();
			

			var ba:ByteArray = new ByteArray();
			//--header
			//packet full size
			ba.writeUnsignedInt(32);
			//packet type
			ba.writeUnsignedInt(0);
			//server time
			ba.writeDouble(1234567890);
			//--packet part playerinfo
			//id
			ba.writeUnsignedInt(1);
			//nameSize
			ba.writeUnsignedInt(1);
			var nameSize:uint = ba.position - 1
			//name
			ba.writeUTFBytes('nick1234');
			//recalculate name size
			ba[nameSize] = ba.position - nameSize - 1;
			//--Position
			//x
			ba.writeDouble(1024);
			//y
			ba.writeDouble(2048);
			//--AddedObjectInfo
			//objectType
			ba.writeUnsignedInt(1);
			//objectViewId
			ba.writeUnsignedInt(1);
			//--MoveInfo
			//start point
			ba.writeDouble(1024);
			ba.writeDouble(1024);
			//end point
			ba.writeDouble(1024);
			ba.writeDouble(1024);
			//start time
			ba.writeDouble(0);
			//traveltime
			ba.writeInt(1000);
			//speed
			ba.writeInt(300);

			
			var size:Number = ba.length;
			trace('original', size);
			ba.compress(CompressionAlgorithm.ZLIB);
			var t:Number = getTimer();
			trace('compress', 100-(ba.length / (size / 100)) + '%', ba.length);
			size = ba.length;
			ba.uncompress(CompressionAlgorithm.ZLIB);
			trace('uncompress time', getTimer() - t);
			
			//rewrite size
			ba.position = 0;
			ba.writeUnsignedInt(size);
			//ba[0] = size;
	
			//data.read(ba);
			
		}
		
	}

}