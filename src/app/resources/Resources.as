package resources 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Nikro
	 */
	public class Resources 
	{
		[Embed(source = "../../../asset/asset.zip", mimeType = "application/octet-stream")]
		private static var mainAssetSrc:Class;
		public static var mainAssetBin:ByteArray = new mainAssetSrc();
		
		public function Resources() 
		{
			
		}
		
	}

}