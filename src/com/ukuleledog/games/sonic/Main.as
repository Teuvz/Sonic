package com.ukuleledog.games.sonic
{
	import com.ukuleledog.games.sonic.elements.Level;
	import com.ukuleledog.games.sonic.elements.Sonic;
	import com.ukuleledog.games.sonic.events.LevelEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
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
			/*_currentLevel = new Level();
			addChild(_currentLevel);
			_currentLevel.addEventListener( LevelEvent.RESTART, levelRestart );*/
			levelRestart();
			
			addEventListener( Event.ENTER_FRAME, loop );
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		}
		
		private function levelRestart( e:LevelEvent = null ) : void
		{
			
			var loadingScreen:Sprite = new Sprite();
			loadingScreen.graphics.beginFill( 0x000000 );
			loadingScreen.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight );
			loadingScreen.graphics.endFill();
			
			var loadingText:TextField = new TextField();
			loadingText.text = 'Loading...';
			loadingText.setTextFormat( new TextFormat( 'verdana', 18, 0xFFFFFF, null, null, null, null, null, 'center' ), 0, loadingText.text.length );			
			loadingText.height = loadingText.textHeight + 5;
			loadingText.width = loadingText.textWidth + 5;
			loadingText.x = stage.stageWidth / 2 - loadingText.width / 2;
			loadingText.y = stage.stageHeight / 2 - loadingText.height / 2;
			loadingScreen.addChild( loadingText );
			
			addChild( loadingScreen );
			
			if ( _currentLevel != null )
			{
				_currentLevel.removeEventListener( LevelEvent.RESTART, levelRestart );
				removeChild( _currentLevel );
			}			
			
			_currentLevel = null;
			_currentLevel = new Level();
			_currentLevel.addEventListener( LevelEvent.RESTART, levelRestart );
			
			removeChild( loadingScreen );
			addChild( _currentLevel );
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