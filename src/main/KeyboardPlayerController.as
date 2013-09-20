package  
{
	import characters.Actor;
	import characters.model.mobile.MobileController;
	import core.ui.KeyBoardController;
	import display.ViewController;
	import flash.display.Stage;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author Nikro
	 */
	public class KeyboardPlayerController 
	{
		private var keyboardController:KeyBoardController;
		
		private var moveVector:Vector3D = new Vector3D();
		private var lastMoveVecotr:Vector3D = new Vector3D();
		
		private var character:Actor;
		private var characterMovementController:MobileController;
		
		[Inject]
		public var stage:Stage;	
		
		public function KeyboardPlayerController(character:Actor) 
		{
			inject(this);
			this.character = character;
			initilize();
		}
		
		private function initilize():void 
		{
			keyboardController = new KeyBoardController(stage);
			characterMovementController = character.getController(MobileController.IDENT) as MobileController;
		}
		
		public function update():void
		{
			checkMoveing();
		}
		
		private function checkMoveing():void
		{
			moveVector.setTo(0, 0, 0);
			
			if (keyboardController.isKeyDown(Keyboard.W))
				moveVector.incrementBy(ViewController.FORWARD);
			
			if (keyboardController.isKeyDown(Keyboard.A))
				moveVector.incrementBy(ViewController.LEFT);
			
			if (keyboardController.isKeyDown(Keyboard.S))
				moveVector.incrementBy(ViewController.BACKWARD);
			
			if (keyboardController.isKeyDown(Keyboard.D))
				moveVector.incrementBy(ViewController.RIGHT);
			
			if (moveVector.x == 0 && moveVector.y == 0 && moveVector.z == 0)
			{
				if (!lastMoveVecotr.equals(moveVector))
				{
					stop();
					return;
				}
			}
			
			if (lastMoveVecotr.equals(moveVector))
				return;
			
			
			characterMovementController.moveTo(moveVector.x * 10000 + characterMovementController.moveData.startPoint.x, moveVector.z * 10000 + characterMovementController.moveData.startPoint.y);
			
			//connectionManager.sendMoveTo(playerController.moveData.endPoint.x, playerController.moveData.endPoint.y);
			
			lastMoveVecotr.setTo(moveVector.x, moveVector.y, moveVector.z);
		}
		
		private function stop():void 
		{
			characterMovementController.stop()//(characterMovementController.moveData.startPoint.x, characterMovementController.moveData.startPoint.y);
			lastMoveVecotr.setTo(0, 0, 0);
		}
		
	}

}