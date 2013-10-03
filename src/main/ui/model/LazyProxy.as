package ui.model 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public dynamic class LazyProxy extends ObjectProxy 
	{
		
		public var updateInterval:Number;
		protected var updateTimer:Timer;
		
		public function LazyProxy(updateInterval:Number = 500) 
		{
			this.updateInterval = updateInterval;
			initilize();
			super();
		}
		
		private function initilize():void 
		{
			updateTimer = new Timer(updateInterval, 1);
			updateTimer.addEventListener(TimerEvent.TIMER_COMPLETE, updateTime);
		}
		
		private function updateTime(e:TimerEvent):void 
		{
			update();
		}
		
		override public function markField(str:String):void 
		{
			super.markField(str);
			
			if(!updateTimer.running)
				updateTimer.start();
		}
		
	}

}