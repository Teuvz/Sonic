package com.ukuleledog.games.sonic.ui 
{
	import com.ukuleledog.games.sonic.events.UIEvent;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author matt
	 */
	public class MobileUI extends Sprite 
	{
		
		private var jumpButton:Sprite;
		
		public function MobileUI() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init );
		}
		
		private function init( e:Event ) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init );
			
			jumpButton = new Sprite();
			jumpButton.graphics.beginFill( 0xFF0000, 0.6 );
			jumpButton.graphics.drawRoundRect( 0, 0, 300, 50, 5, 5 );
			jumpButton.graphics.endFill();
			jumpButton.x = stage.stageWidth / 2 - jumpButton.width / 2;
			jumpButton.y = stage.stageHeight;
			jumpButton.addEventListener( MouseEvent.MOUSE_DOWN, onJumpDown );
			addChild( jumpButton );
			
		}
		
		private function onJumpDown( e:MouseEvent ) : void
		{
			jumpButton.removeEventListener( MouseEvent.MOUSE_DOWN, onJumpDown );
			jumpButton.addEventListener( MouseEvent.MOUSE_UP, onJumpUp );
			dispatchEvent( new UIEvent( UIEvent.BUTTON_DOWN, Keyboard.SPACE ) );
		}
		
		private function onJumpUp( e:MouseEvent ) : void
		{
			jumpButton.addEventListener( MouseEvent.MOUSE_DOWN, onJumpDown );
			jumpButton.removeEventListener( MouseEvent.MOUSE_UP, onJumpUp );
			dispatchEvent( new UIEvent( UIEvent.BUTTON_UP, Keyboard.SPACE ) );
		}
		
	}

}