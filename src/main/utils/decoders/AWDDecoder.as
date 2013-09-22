package utils.decoders 
{
import away3d.events.AssetEvent;
import away3d.events.LoaderEvent;
import away3d.loaders.AssetLoader;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.ByteArray;

import resources.MD5MeshResource;

/**
	 * ...
	 * @author Nikro
	 */
	public class AWDDecoder extends EventDispatcher implements IDecoder 
	{
		protected var loader:AssetLoader;
		protected var filename:String;
		protected var _data:Object;
		
		public function AWDDecoder() 
		{
			_data = new MD5MeshResource();
		}
		
		public function decode(data:ByteArray, filename:String = null):void 
		{
			this.filename = filename;
			loader = new AssetLoader();
			loader.addEventListener(AssetEvent.ASSET_COMPLETE, assetComplete);
			loader.addEventListener(LoaderEvent.RESOURCE_COMPLETE, onComlete);
			loader.loadData(data, filename);
		}
		
		protected function onComlete(e:LoaderEvent):void 
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		protected function assetComplete(e:AssetEvent):void 
		{
			if(e.asset.assetType == 'mesh' || e.asset.assetType == 'skeleton' || e.asset.assetType == 'animationSet')
				_data[e.asset.assetType] = e.asset;
		}
		
		public function get data():* 
		{
			return _data;
		}
		
		public function destroy():void 
		{
			loader.removeEventListener(AssetEvent.ASSET_COMPLETE, assetComplete);
			loader.removeEventListener(LoaderEvent.RESOURCE_COMPLETE, onComlete);
		}
		
	}

}