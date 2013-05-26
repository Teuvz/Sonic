package com.ukuleledog.games.sonic
{
	import com.ukuleledog.games.sonic.elements.Level;
	import com.ukuleledog.games.sonic.elements.Sonic;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author matt
	 */
	public class Main extends Sprite 
	{
	
		private var keyPressed:Boolean = false;
		private var pressedKey:uint;
		
		private var _currentLevel:Level;
		
		public function Main():void 
		{
			_currentLevel = new Level();
			addChild(_currentLevel);
			addEventListener( Event.ENTER_FRAME, loop );
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		}
		
		private function loop( e:Event ) : void
		{
			if ( keyPressed )
			{
				switch( pressedKey )
				{
					case Keyboard.RIGHT:
						_currentLevel.sonic.moveRight();
						break;
					case Keyboard.LEFT:
						_currentLevel.sonic.moveLeft();
						break;
					case Keyboard.SPACE:
						_currentLevel.sonic.jump();
						break;
					case Keyboard.DOWN:
						_currentLevel.sonic.crouch();
						break;
				}
			}
			
			_currentLevel.loop();
		}
		
		private function onKeyUp( e:KeyboardEvent ) : void
		{
			keyPressed = false;
			_currentLevel.sonic.animation = 'idle';
		}
		
		private function onKeyDown( e:KeyboardEvent )  : void
		{
			keyPressed = true;
			pressedKey = e.keyCode;
		}
		
	}
	
}