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
		
		internal var intOp:IntOperator;
        internal var doubleOp:DoubleOperator;
        internal var pointOp:PointOperator;

        internal var streamOp:StreamOperator;
        internal var conManager:ConnectionManager;
        internal var pingSender:PingSender;
        internal var bytePack:BytePacket;

        internal var worldTime:WorldTimeController;
        internal var mathem:PathMathematic;
		//var md5builder:MD5ModelBuilder;
		
	}

}