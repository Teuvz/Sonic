package com.ukuleledog.games.sonic.elements 
{
	import com.ukuleledog.games.sonic.events.LevelEvent;
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
		private var _running:Boolean = false;
		
		public function Level() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init );
		}
		
		private function init( e:Event ) : void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init );
		
			_colliderElements = new Vector.<Element>();
			var floor:Element = new Element();
			floor.graphics.beginFill( 0x00AA00, 0.5);
			floor.graphics.drawRect( 0, 0, stage.stageWidth*4, stage.stageHeight / 2 );
			floor.graphics.endFill();
			floor.y = stage.stageHeight / 2;
			floor.name = "floor";
			addChild( floor );
			_colliderElements.push(floor);
			
			var wall:Element = new Element();
			wall.graphics.beginFill( 0xFF0000, 0.5 );
			wall.graphics.drawRect( 0, 0, 30, 800 );
			wall.graphics.endFill();
			wall.name = "wall";
			addChild( wall );
			_colliderElements.push(wall);
			
			var wall2:Element = new Element();
			wall2.graphics.beginFill( 0xFF0000, 0.5 );
			wall2.graphics.drawRect( 0, 0, 30, 800 );
			wall2.graphics.endFill();
			wall2.name = "wall2";
			wall2.x = 500;
			addChild( wall2 );
			_colliderElements.push(wall2);
			
			_sonic = new Sonic();
			_sonic.x = (stage.stageWidth / 2) - (_sonic.width / 2);
			addChild( _sonic );
			
			_running = true;
		}
		
		public function loop() : void
		{
			
			if ( _running )
			{
				collideVertical();
				moveCamera();
				_sonic.loop();
				
				if ( _sonic.y > stage.stageHeight )
				{
					_running = false;
					dispatchEvent( new LevelEvent( LevelEvent.RESTART ) );
				}
			}
		}
		
		private function collideVertical() : void
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
		
		public function moveLeft() : void
		{
			
			var canMove:Boolean = true;
			var i:uint = _colliderElements.length;
			
			while ( --i >= 0 )
			{
				if ( 
					_sonic.x < ( _colliderElements[i].x + _colliderElements[i].width ) &&
					_colliderElements[i].x < _sonic.x && 
					_colliderElements[i].y < _sonic.y && 
					(_colliderElements[i].y + _colliderElements[i].height) > (_sonic.y + _sonic.height )
				)
				{
					_sonic.animation = "push";
					canMove = false;
					_sonic.jumping = false;
					_sonic.x = (_colliderElements[i].x + _colliderElements[i].width ) - 1;
					break;
				}
			}
			
			if ( canMove )
				_sonic.moveLeft();
			
		}
		
		public function moveRight() : void
		{
			var canMove:Boolean = true;
			var i:uint = _colliderElements.length;
			
			while ( --i >= 0 )
			{
				if ( 
					_colliderElements[i].x < ( _sonic.x + _sonic.width ) &&
					_colliderElements[i].x > _sonic.x && 
					_colliderElements[i].y < _sonic.y && 
					(_colliderElements[i].y + _colliderElements[i].height) > (_sonic.y + _sonic.height )
				)
				{
					_sonic.animation = "push";
					canMove = false;
					_sonic.jumping = false;
					_sonic.x = (_colliderElements[i].x - _sonic.width ) + 1;
					break;
				}
			}
			
			if ( canMove )
				_sonic.moveRight();
		}
		
		public function jump() : void
		{
			_sonic.jump();
		}
		
		public function crouch() : void
		{
			_sonic.crouch();
		}
		
	}

}