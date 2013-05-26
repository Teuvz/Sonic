package com.ukuleledog.games.sonic.elements 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author matt
	 */
	public class Level extends Sprite
	{
		
		private var _sonic:Sonic;
		private var _colliderElements:Vector.<Element>;
		
		public function Level() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init );
		}
		
		private function init( e:Event ) : void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init );
		
			_colliderElements = new Vector.<Element>();
			var floor:Ground = new Ground();
			floor.graphics.beginFill( 0x00AA00, 0.5);
			floor.graphics.drawRect( 0, 0, stage.stageWidth*4, stage.stageHeight / 2 );
			floor.graphics.endFill();
			floor.y = stage.stageHeight / 2;
			addChild( floor );
			_colliderElements.push(floor);
			
			_sonic = new Sonic();
			_sonic.x = (stage.stageWidth / 2) - (_sonic.width / 2);
			addChild( _sonic );
			
		}
		
		public function loop() : void
		{
			collide();
			moveCamera();
			_sonic.loop();
		}
		
		private function collide() : void
		{
			
			var i:uint = _colliderElements.length;
			
			while ( --i >= 0 )
			{
				if ( _colliderElements[i].x <= (_sonic.x + _sonic.width/2) && (_colliderElements[i].x + _colliderElements[i].width) >= (_sonic.x + _sonic.width/2 ) )
				{
					
					if ( (_sonic.y + _sonic.height) < _colliderElements[i].y )
					{
						_sonic.fall();
						_sonic.onGround = false;
					} 
					else if ( (_sonic.y + _sonic.height) > _colliderElements[i].y )
					{
						_sonic.y = _colliderElements[i].y - _sonic.height;
						_sonic.onGround = true;
					}
					
				}
				else
				{
					_sonic.fall();
					_sonic.onGround = false;
				}
			}
			
		}
		
		public function get sonic() : Sonic
		{
			return _sonic;
		}
		
		private function moveCamera() : void
		{	
			this.x = (stage.stageWidth / 2) - _sonic.x - (_sonic.width/2);
			//this.y = (stage.stageHeight / 2) - _sonic.y - (_sonic.height / 2);
		}
		
	}

}