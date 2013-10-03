package characters.model.mobile   
{
	import characters.model.AnimationModel;
	import display.IActorController;
	import display.ViewController;
	import flash.events.EventDispatcher;
	import flash.geom.Vector3D;
	import geom.PathMathematic;
	import utils.DimensionalMath;
	
	public class MobileController extends EventDispatcher implements IActorController
	{
		public static const IDENT:String = 'MobileController';
		
		private var _moveData:MoveData = new MoveData();
		private var _viewController:ViewController;
		
		private var isStop:Boolean = true;
		private var positionSetter:PositionSetter3D;
		
		[Inject]
		public var pathMath:PathMathematic;
		
		[Inject]
		public var worldTime:WorldTimeController;
		
		public var createTime:Number;
		public var lifeTime:Number;
		
		private var _position:Vector3D = new Vector3D();
		
		private var yAngle:Number = 0;
		private var currentAngle:Number = 0;
		private var angleBetwen:Number;
		
		private var angleSteps:int = 0;
		
		public function MobileController(viewController:ViewController, positionSetter:PositionSetter3D) 
		{
			inject(this);
			
			this.positionSetter = positionSetter;
			_viewController = viewController;
			
			createTime = worldTime.currentTime
			initilize();
		}
		
		public function moveTo(x:Number, y:Number):void
		{
			pathMath.calculateCurrentPosition(moveData, moveData.startPoint);
			moveData.setEndPoint(x, y);
			moveData.startTime = worldTime.currentTime;
			
			var distance:Number = DimensionalMath.distance(moveData.startPoint, moveData.endPoint);
			
			moveData.travelTime = distance / moveData.speed * 1000;
		}
		
		public function stop():void 
		{
			pathMath.calculateCurrentPosition(moveData, moveData.startPoint);
			moveData.setEndPoint(moveData.startPoint.x, moveData.startPoint.y);
			moveData.travelTime = 0;
			moveData.startTime = worldTime.currentTime;
		}
		
		private function initilize():void 
		{
			
		}
		
		public function get position():Vector3D 
		{
			return _position;
		}
		
		public function set position(value:Vector3D):void 
		{
			_position = value;
			placeOnPosition();
		}
		
		public function get viewController():ViewController 
		{
			return _viewController;
		}
		
		public function get moveData():MoveData 
		{
			return _moveData;
		}
		
		public function get ident():String 
		{
			return IDENT;
		}
		
		private function calculatePosition():void
		{
			pathMath.calculateCurrentPosition(moveData, _position);
		}
		
		public function update(dt:Number):void
		{
			calculatePosition();
			
			if (angleSteps != 0)
			{
				currentAngle += angleBetwen;
				//trace("#1", currentAngle)
				currentAngle = AngleMathematic.normalizeAngle(currentAngle);
				//trace("#2", currentAngle)
				_viewController.displayObject.rotationY = AngleMathematic.normalizeAngle(currentAngle);
				angleSteps--;
				//trace( Math.floor(AngleMathematic.normalizeAngle(_viewController.displayObject.rotationY)));
			}
			
			if (_position.equals(moveData.endPoint))
				stop2();
			else
			{
				move();
				placeOnPosition();
			}
		}
		
		private function stop2():void 
		{
			
		}
		
		private function move():void 
		{
			
		}
		
		public function placeOnPosition():void
		{
			yAngle = positionSetter.applyPosition(_viewController, position);
			
			if (yAngle == currentAngle)
				return;
				
			angleSteps = 4;
			
			angleBetwen = yAngle - currentAngle;
			
			//trace('abw', angleBetwen);
			if (angleBetwen > 180)
				angleBetwen = angleBetwen - 360;
			
			if (angleBetwen < -180)
				angleBetwen = angleBetwen + 360;
					
			//trace('yAngle', yAngle, angleBetwen, currentAngle);
			angleBetwen /= angleSteps;
			
			//trace('-----------------');
		}
	}

}