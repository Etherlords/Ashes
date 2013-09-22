package  
{
	import display.builders.MD5ModelBuilder;
	import geom.PathMathematic;
	import net.ConnectionManager;
	import net.packets.BytePacket;
	import net.PingSender;
	import utils.io.DoubleOperator;
	import utils.io.IntOperator;
	import utils.io.PointOperator;
	import utils.io.StreamOperator;

	public class ClassesReference 
	{
		
		var intOp:IntOperator;
		var doubleOp:DoubleOperator;
		var pointOp:PointOperator;
		
		var streamOp:StreamOperator;
		var conManager:ConnectionManager;
		var pingSender:PingSender;
		var bytePack:BytePacket;
		
		var worldTime:WorldTimeController;
		var mathem:PathMathematic;
		//var md5builder:MD5ModelBuilder;
		
	}

}