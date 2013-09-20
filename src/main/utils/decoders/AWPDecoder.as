package utils.decoders 
{
	import away3d.arcane;
	import away3d.entities.ParticleGroup;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.library.assets.AssetType;
	import away3d.loaders.AssetLoader;
	import away3d.loaders.misc.AssetLoaderContext;
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Nikro
	 */
	public class AWPDecoder extends MD5MeshDecoder 
	{
		private var source:ByteArray;
		[Inject]
		public var awayContext:AssetLoaderContext
		
		use namespace arcane;
		
		public function AWPDecoder() 
		{
			inject(this)
			
			
		}
		
		override public function decode(source:ByteArray, filename:String = null):void 
		{
			this.source = source;
			this.filename = filename;
			
			loader = new AssetLoader();
			loader.addEventListener(AssetEvent.ASSET_COMPLETE, assetComplete);
			loader.addEventListener(LoaderEvent.RESOURCE_COMPLETE, onComlete);
			
			
			var wait:Timer = new Timer(1000, 1);
			wait.start();
			wait.addEventListener(TimerEvent.TIMER_COMPLETE, onDelay);
		}
		
		private function onDelay(e:TimerEvent):void 
		{
			loader.loadData(source, null, awayContext);
		}
		
		override protected function assetComplete(e:AssetEvent):void 
		{
			
			if(e.asset.assetType == AssetType.CONTAINER)
				_data = e.asset as ParticleGroup;
		}
		
	}

}