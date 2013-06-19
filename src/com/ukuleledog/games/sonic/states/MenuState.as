package com.ukuleledog.games.sonic.states 
{
	import com.ukuleledog.games.sonic.events.MenuEvent;
	import com.ukuleledog.games.sonic.Ressources;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author matt
	 */
	public class MenuState extends State
	{
	
		private var _spriteSheet:Bitmap = new Ressources.START_MENU();
		
		private var _sonic:MovieClip = new asset_title();
		private var _sonicFrame:uint = 0;
		private var _startMessage:MovieClip = new asset_startmessage();
		
		public function MenuState() 
		{
			super();
						
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init( e:Event ) : void
		{
			removeEventListener( Event.ADDED_TO_STAGE, init );
		
			var background:BitmapData = new BitmapData( stage.stageWidth, stage.stageHeight, false );
			background.copyPixels( _spriteSheet.bitmapData, new Rectangle(270, 3, 511, 248), new Point(0, 0) );
			var backgroundSprite:Sprite = new Sprite();
			backgroundSprite.graphics.beginBitmapFill( background );
			backgroundSprite.graphics.drawRect( 0, 0, 511, 248 );
			backgroundSprite.graphics.endFill();
			backgroundSprite.scaleX = 2;
			backgroundSprite.scaleY = 2;
			backgroundSprite.y = 45;
			addChild( backgroundSprite );
			
			var logo:BitmapData = new BitmapData( 260, 160, true );
			logo.copyPixels( _spriteSheet.bitmapData, new Rectangle(2, 75, 260, 160), new Point(0, 0) );
			var logoSprite:Sprite = new Sprite();
			logoSprite.graphics.beginBitmapFill( logo );
			logoSprite.graphics.drawRect( 0, 0, 260, 160 );
			logoSprite.graphics.endFill();
			logoSprite.scaleX = 1.5;
			logoSprite.scaleY = 1.5;
			logoSprite.x = stage.stageWidth / 2 - logoSprite.width / 2;
			logoSprite.y = stage.stageHeight / 2 - logoSprite.height / 2;
			addChild( logoSprite );
			
			_sonic.x = stage.stageWidth / 2 - 55;
			_sonic.y = stage.stageHeight / 2 - 120;
			_sonic.scaleX = 1.5;
			_sonic.scaleY = 1.5;
			addChild( _sonic );
			
			_startMessage.scaleX = 2;
			_startMessage.scaleY = 2;
			_startMessage.x = stage.stageWidth / 2 - _startMessage.width / 2;
			_startMessage.y = 450;
			addChild( _startMessage );
			
			if ( CONFIG::mobile == true ) {
				stage.addEventListener( MouseEvent.CLICK, onMouseClick );
			} else {
				stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			}
			
			startMusic( new Ressources.MUSIC_MENU() );
		}
		
		private function onKeyDown( e:KeyboardEvent ) : void
		{
			if ( e.keyCode == Keyboard.SPACE || e.keyCode == Keyboard.ENTER ) {
				removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
				stopMusic();
				dispatchEvent( new MenuEvent( MenuEvent.MENU_START ) );
			}
		}
		
		private function onMouseClick( e:MouseEvent ) : void
		{
			stage.removeEventListener( MouseEvent.CLICK, onMouseClick );
			stopMusic();
			dispatchEvent( new MenuEvent( MenuEvent.MENU_START ) );
		}
		
	}

}