package com.ukuleledog.games.sonic.elements 
{
	import com.ukuleledog.games.sonic.blocks.Block;
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
		
			var block1:Block = new Block( 1, 'lala' );
			addChild(block1);
			var block2:Block = new Block( 2, 'lala' );
			block2.x = stage.stageWidth;
			addChild(block2);
			var block3:Block = new Block( 3, 'lala' );
			block3.x = stage.stageWidth*2;
			addChild(block3);
			var block4:Block = new Block( 4, 'lala' );
			block4.x = stage.stageWidth*3;
			addChild(block4);
			var block5:Block = new Block( 5, 'lala' );
			block5.x = stage.stageWidth*4;
			addChild(block5);
			var block6:Block = new Block( 6, 'lala' );
			block6.x = stage.stageWidth*5;
			addChild(block6);
			var block7:Block = new Block( 7, 'lala' );
			block7.x = stage.stageWidth*6;
			addChild(block7);
						
			_colliderElements = new Vector.<Element>();
			var floor:Element = new Element();
			floor.graphics.beginFill( 0x00AA00, 0.5);
			floor.graphics.drawRect( 0, 0, stage.stageWidth*7, stage.stageHeight / 2 );
			floor.graphics.endFill();
			floor.y = 415;
			floor.name = "floor";
			floor.visible = false;
			addChild( floor );
			_colliderElements.push(floor);
			
			var wall:Element = new Element();
			wall.graphics.beginFill( 0xFF0000, 0.5 );
			wall.graphics.drawRect( 0, 0, 60, 800 );
			wall.graphics.endFill();
			wall.name = "wall";
			wall.x -= 30;
			addChild( wall );
			_colliderElements.push(wall);
			
			var wall2:Element = new Element();
			wall2.graphics.beginFill( 0xFF0000, 0.5 );
			wall2.graphics.drawRect( 0, 0, 60, 800 );
			wall2.graphics.endFill();
			wall2.name = "wall2";
			wall2.x = stage.stageWidth*7 - 30;
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