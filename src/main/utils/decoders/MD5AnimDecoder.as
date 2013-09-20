package utils.decoders 
{
	import away3d.animators.nodes.SkeletonClipNode;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	/**
	 * ...
	 * @author Nikro
	 */
	public class MD5AnimDecoder extends MD5MeshDecoder 
	{
		
		public function MD5AnimDecoder() 
		{
			
		}
		
		override protected function assetComplete(e:AssetEvent):void 
		{
			_data = e.asset;
			//(_data as SkeletonClipNode).highQuality = true;
			//(_data as SkeletonClipNode).stitchFinalFrame = true;
			var parts:Array = filename.split('/');
			e.asset['name'] = parts[parts.length - 1];
		}
		
	}

}