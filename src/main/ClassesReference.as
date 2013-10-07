package  
{
	import geom.PathMathematic;
	import logic.MainController;
	import logic.ui.LoginWindowController;
	import net.ConnectionManager;
	import net.DataReader;
	import net.events.ChatMessageEventListener;
	import net.events.LoginAnswerEventListener;
	import net.events.SocketDataEventRouter;
	import net.packets.BytePacket;
	import net.PingSender;
	import services.LoginService;
	import ui.LoginWindow;
	import utils.io.DoubleOperator;
	import utils.io.IntOperator;
	import utils.io.PointOperator;
	import utils.io.StreamOperator;
	import utils.io.UTFStringOperator;

	public class ClassesReference 
	{
		LoginWindowController;
		LoginWindow;
		
		LoginAnswerEventListener;
		ChatMessageEventListener;
		
		
		SocketDataEventRouter;
		
		MainController;
		
		IntOperator;
        DoubleOperator;
        PointOperator;
        UTFStringOperator;

        StreamOperator;
        ConnectionManager;
        PingSender;
        BytePacket;
		
		DataReader;
		
		LoginService;

        WorldTimeController;
        PathMathematic;
		//var md5builder:MD5ModelBuilder;
		
	}

}