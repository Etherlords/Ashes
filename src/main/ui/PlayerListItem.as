package ui 
{
	import com.bit101.components.IndicatorLight;
	import com.bit101.components.Label;
	import com.bit101.components.ListItem;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class PlayerListItem extends ListItem 
	{
		static public const STATUS_COLORS:Vector.<int> = new <int>[0x0, 0x00FF00, 0x0000FF, 0xFF0000];
		static public const STATUS:String = "status";
		
		private var statusIndicator:IndicatorLight;
		
		public function PlayerListItem(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, data:Object = null) 
		{
			super(parent, xpos, ypos, data);
		}
		
		override protected function addChildren():void 
		{
			statusIndicator = new IndicatorLight(this, 5, 5);
			
			statusIndicator.isLit = true;
			
			_label = new Label(this, 14, 0);
            _label.draw();
		}
		
		override public function draw():void 
		{
			super.draw();
			
			if (_data && STATUS in _data)
			{
				statusIndicator.color = STATUS_COLORS[data[STATUS]];
			}
		}
		
		override public function get data():Object 
		{
			return super.data;
		}
		
		override public function set data(value:Object):void 
		{
			super.data = value;
		}
		
	}

}