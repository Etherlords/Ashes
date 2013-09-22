package utils.decoders 
{
import away3d.textures.BitmapTexture;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;

/**
	 * ...
	 * @author Nikro
	 */
	public class TextureDecoder extends PngDecoder
	{
		
		public function TextureDecoder() 
		{
			
		}
		
		override protected function onComplete(e:*):void 
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
			
			var bitmap:BitmapData = (loader.content as Bitmap).bitmapData;
			_data = new BitmapTexture(bitmap, true);
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		
	}

}