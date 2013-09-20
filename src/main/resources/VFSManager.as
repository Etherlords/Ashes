package resources 
{
	import away3d.loaders.misc.AssetLoaderContext;
	import away3d.textures.BitmapCubeTexture;
	import away3d.textures.BitmapTexture;
	import core.collections.SimpleMap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import org.as3commons.zip.Zip;
	import org.as3commons.zip.ZipFile;
	import utils.decoders.AWDDecoder;
	import utils.decoders.AWPDecoder;
	import utils.decoders.IDecoder;
	import utils.decoders.MD5AnimDecoder;
	import utils.decoders.MD5MeshDecoder;
	import utils.decoders.PngDecoder;
	import utils.decoders.TextureDecoder;
	import utils.decoders.XMLDecoder;
	/**
	 * ...
	 * @author Nikro
	 */
	public class VFSManager extends EventDispatcher
	{
		static public const SKYBOX:String = "skybox";
		static private var SKYBOXE_SIDES_ALIACES:Object = 
													{
														'negX':'negativeX', 'negY':'negativeY', 'negZ':'negativeZ',
														'posX':'posativeX', 'posY':'posativeY', 'posZ':'posativeZ'
													}
		
		private var files:Zip;
		
		private var storage:SimpleMap = new SimpleMap();
		private var decoders:Object = { 'awd':AWDDecoder, 'obj':AWDDecoder, 'fnt':XMLDecoder, 'xml':XMLDecoder, 'jpg':TextureDecoder, 'png':TextureDecoder, 'skybox':PngDecoder, 'md5anim':MD5AnimDecoder, 'md5mesh':MD5MeshDecoder, 'awp':AWPDecoder};
		
		private var filesCount:int;
		private var awayContext:AssetLoaderContext;
		
		public function VFSManager() 
		{
			awayContext = new AssetLoaderContext();
			addToContext(awayContext);
			
			initilize();
		}
		
		public function getFile(name:String):Object
		{
			return storage.getItem(name);
		}
		
		private function initilize():void 
		{
			files = new Zip();
			files.loadBytes(Resources.mainAssetBin);
			
			processAsset();
		}
		
		private function processAsset():void 
		{
			var file:ZipFile;
			filesCount = files.getFileCount();
			var l:int = filesCount;
			for (var i:int = 0; i < l; i++)
			{
				file = files.getFileAt(i);
				processFile(file);
			}
		}
		
		private function processFile(file:ZipFile):void 
		{
			if (file.filename.charAt(file.filename.length - 1) == '/')
			{
				filesCount--;
				return;
			}
			
			var nameOfFile:String = file.filename;
			var content:ByteArray = file.content;
			
			var fileExtension:String = nameOfFile.split('.')[1];
			var fileName:String = nameOfFile.split('.')[0];
			
			var decoder:IDecoder;
			
			if(fileName.indexOf(SKYBOX) != -1)
				decoder = new decoders[SKYBOX];
			else
				decoder = new decoders[fileExtension.toLowerCase()];
				
			decoder.addEventListener(Event.COMPLETE, Delegate.create(onDecoded, fileName, decoder, nameOfFile));
			
			decoder.decode(content, fileName);
		}
		
		private function onDecoded(e:Event, filename:String, decoder:IDecoder, nameOfFile:String):void 
		{
			
			//if (filename.indexOf(SKYBOX) != -1)
			//{
			//	onCube(filename, decoder.data);
			//}
			//else
			
			if (nameOfFile.indexOf('particles') != -1 && nameOfFile.indexOf('.png') != -1)
			{
				
				awayContext.mapUrlToData(nameOfFile.split('/').slice(1).join('/'), (decoder.data as BitmapTexture).bitmapData);
			}
			
				storage.addItem(filename, decoder.data);
			
			if (storage.length == filesCount)
				fvsReady();
		}
		
		private function onCube(filename:String, data:BitmapData, nameOfFile:String):void 
		{
			var cubeName:String = filename.split('_')[0]
			var cubeTexture:BitmapCubeTexture = storage.getItem(cubeName);
			
			if (!cubeTexture)
			{
				cubeTexture = new BitmapCubeTexture(null, null, null, null, null, null);
				storage.addItem(cubeName, cubeTexture)
			}
			
			
			
			var textureSide:String = filename.split('_')[1];
			cubeTexture[SKYBOXE_SIDES_ALIACES[textureSide]] = data;
		}
		
		private function fvsReady():void 
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
	}

}