package  
{
	import away3d.extrusions.Elevation;

import characters.model.mobile.PositionSetter3D;

import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import mvc.mainscene.logic.TerrainBuilder;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class ElevationDebug extends Sprite 
	{
		[Inject]
		public var positionSetter:PositionSetter3D;
		
		[Inject]
		public var terrain:TerrainBuilder;
		
		private var marker:Shape = new Shape();
		private var elevationHeightView:Bitmap;
		private var elevation:Elevation;
		
		private var initilized:Boolean = false;
		private var settingsView:TerrainSettingsController;
		private var markForUpdate:Boolean;
		
		private var isUseNormal:Boolean = true;
		private var isUseSpec:Boolean = true;
		private var isUseLight:Boolean = true;
		
		private var scale:Number = 5;
		private var isUseDiffuseMethod:Boolean = true;
		
		public function ElevationDebug() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addToContext(this);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function initilize():void 
		{
			initilized = true;
			
			this.elevation = terrain.terrain;
			marker.graphics.beginFill(0xFF0000);
			marker.graphics.drawRect( -2.5, -0.2, 5, 5);
			
			elevationHeightView = new Bitmap(terrain.terrain._activeMap)
			elevationHeightView.scaleX = elevationHeightView.scaleY = 0.25
			
			addChild(elevationHeightView);
			addChild(marker);
			
			settingsView = new TerrainSettingsController();
			settingsView.x = elevationHeightView.width;
			
			settingsView.addEventListener(Event.CHANGE, onChange);
			
			addChild(settingsView);
			
		}
		
		private function onChange(e:Event):void 
		{
			for (var i:int = 0; i < 4; i++)
			{
				if (terrain.blend[i] != settingsView.getBlendValue(i))
				{
					markForUpdate = true;
					terrain.blend[i] = settingsView.getBlendValue(i);
				}
			}
			
			if (isUseDiffuseMethod != settingsView.getMapStatus(3))
			{
				isUseDiffuseMethod = settingsView.getMapStatus(3)
				terrain.diffuseMethod(isUseDiffuseMethod);
			}
			
			if (scale != settingsView.scale.value)
				terrain.scale(settingsView.scale.value);
			
			if (settingsView.getMapStatus(0) != isUseNormal)
			{
				isUseNormal = settingsView.getMapStatus(0);
				terrain.normal(isUseNormal);
			}
			
			if (settingsView.getMapStatus(1) != isUseSpec)
			{
				isUseSpec = settingsView.getMapStatus(1);
				terrain.specular(isUseSpec);
			}
			
			if (settingsView.getMapStatus(2) != isUseLight)
			{
				isUseLight = settingsView.getMapStatus(2);
				terrain.light(isUseLight);
			}
			
			
			if (markForUpdate)
				terrain.resetBlendMethod();
		}
		
		private function update(e:Event):void 
		{
			if (!initilized)
			{
				inject(this);
				if (terrain)
				{
					initilize();
				}
				else
					return;
			}
			
			
			//terrain.resetBlendMethod();
			//terrain.blend[2]++;

			marker.x = elevation.correctX(positionSetter.currentPosition.x) * 0.25 //+ elevationHeightView.width / 2) 
			marker.y = elevation.correctY(positionSetter.currentPosition.y) * 0.25 //+ elevationHeightView.height / 2)  
			//trace(positionSetter.currentPosition.x, positionSetter.currentPosition.y);
		}
		
	}

}