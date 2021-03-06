package com.ukuleledog.games.sonic.states 
{
	import com.ukuleledog.games.sonic.elements.Level;
	import com.ukuleledog.games.sonic.events.LevelEvent;
	import com.ukuleledog.games.sonic.events.UIEvent;
	import com.ukuleledog.games.sonic.Ressources;
	import com.ukuleledog.games.sonic.ui.MobileUI;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author matt
	 */
	public class GameState extends State
	{
		private var mobileUI:MobileUI;
		private var keyPressed:Boolean = false;
		private var pressedKeys:Dictionary = new Dictionary();
		
		private var _currentLevel:Level;
				
		public function GameState() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init );			
		}
		
		private function init( e:Event ) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init );
			
			levelRestart();
			
			addEventListener( Event.ENTER_FRAME, loop );
			
			if ( CONFIG::mobile == true ) {
				mobileUI = new MobileUI();
				parent.addChild( mobileUI );
				mobileUI.addEventListener( UIEvent.BUTTON_DOWN, onButtonDown );
				mobileUI.addEventListener( UIEvent.BUTTON_UP, onButtonUp );
			} else {
				stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
				stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			}
		
		}
		
		private function levelRestart( e:LevelEvent = null ) : void
		{
			stopMusic();
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
			startMusic( new Ressources.MUSIC_LEVEL(), true );
		}
		
		private function loop( e:Event ) : void
		{
			
			try
			{
				
				keyPressed = false;
				
				if ( pressedKeys[Keyboard.DOWN] == true ) {
					_currentLevel.crouch();
					keyPressed = true;
				} else if ( pressedKeys[Keyboard.LEFT] == true ) {
					_currentLevel.moveLeft();
					keyPressed = true;
				} else if ( pressedKeys[Keyboard.RIGHT] == true ) {
					_currentLevel.moveRight();
					keyPressed = true;
				}
				
				if ( pressedKeys[Keyboard.SPACE] == true && !_currentLevel.sonic.crouching && !_currentLevel.sonic.jumping ) {
					_currentLevel.jump();
					keyPressed = true;
				}
				
				if ( !keyPressed && !_currentLevel.sonic.waiting )
					_currentLevel.sonic.animation = 'idle';
				
				_currentLevel.loop();
			
			} catch (e:Error) {
				_currentLevel.addSign();
			}
			
		}
		
		private function onKeyUp( e:KeyboardEvent ) : void
		{
			pressedKeys[e.keyCode] = false;
		}
		
		private function onKeyDown( e:KeyboardEvent )  : void
		{
			pressedKeys[e.keyCode] = true;
		}
		
		private function onButtonUp( e:UIEvent ) : void
		{
			pressedKeys[e.button] = false;
		}
		
		private function onButtonDown( e:UIEvent ) : void
		{
			pressedKeys[e.button] = true;
		}
		
	}

}