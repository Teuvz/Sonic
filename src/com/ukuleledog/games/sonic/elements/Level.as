package com.ukuleledog.games.sonic.elements 
{
	import com.ukuleledog.games.sonic.blocks.Block;
	import com.ukuleledog.games.sonic.blocks.Block1;
	import com.ukuleledog.games.sonic.blocks.Block2;
	import com.ukuleledog.games.sonic.events.LevelEvent;
	import com.ukuleledog.games.sonic.Ressources;
	import com.ukuleledog.games.sonic.ui.Hud;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	/**
	 * ...
	 * @author matt
	 */
	public class Level extends Sprite
	{
		
		private var _sonic:Sonic;
		private var _colliderElements:Vector.<Element>;
		private var _running:Boolean = false;
		private var _blocks:Vector.<Block>;
		private var _hud:Hud;	
		
		public function Level() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init );
		}
		
		private function init( e:Event ) : void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init );
		
			_blocks = new Vector.<Block>();
			var block1:Block1 = new Block1( 1 );
			addChild(block1);
			_blocks.push(block1);
			
			var block2:Block1 = new Block1( 2 );
			block2.x = stage.stageWidth;
			addChild(block2);
			_blocks.push(block2);
			
			var block3:Block1 = new Block1( 3 );
			block3.x = stage.stageWidth * 2;
			addChild(block3);
			_blocks.push(block3);
	
			_sonic = new Sonic();
			_sonic.x = this.width / 2 - _sonic.width / 2;
			_sonic.y = 337;
			addChild( _sonic );
			
			_hud = new Hud();
			parent.addChild( _hud );
			
			_running = true;
		}
		
		public function loop() : void
		{
			
			if ( _running )
			{
				manageBlocks();
				_colliderElements = getCurrentBlock().colliderElements;
				
				if ( getCurrentBlock().collectableElements != null )
					collect();
				
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
		
		private function getCurrentBlock() : Block
		{
			var i:uint = _blocks.length;
			
			while ( --i >= 0 )
			{
				if ( (_sonic.x + _sonic.width / 2) > _blocks[i].x && (_sonic.x + _sonic.width / 2) < _blocks[i].x + _blocks[i].width )
				return _blocks[i];
			}
			
			return null;
		}
		
		private function manageBlocks() : void
		{			
			var i:uint = _blocks.length;
			
			var minX:int = 0;
			var maxX:int = 0;
			
			while ( --i >= 0 )
			{
				if ( _blocks[i].x < minX )
					minX = _blocks[i].x;
				if ( _blocks[i].x + _blocks[i].width > maxX )
					maxX = _blocks[i].x + _blocks[i].width;
			}
			
			if ( _sonic.x < (minX + stage.stageWidth * 2) )
			{
				var blockX:Block = Block.generateRandomBlock( _blocks.length + 1 );
				blockX.x = minX - stage.stageWidth;
				addChild(blockX);
				_blocks.push(blockX);
				swapChildrenAt( getChildIndex(_sonic), getChildIndex(blockX) );
			}
			else if ( _sonic.x > maxX - stage.stageWidth )
			{
				var blockX2:Block = Block.generateRandomBlock( _blocks.length + 1 );
				blockX2.x = maxX;
				addChild(blockX2);
				_blocks.push(blockX2);
				swapChildrenAt( getChildIndex(_sonic), getChildIndex(blockX2) );
			}
			
		}
		
		private function collect() : void
		{
			
			var i:uint = getCurrentBlock().collectableElements.length;
			
			while ( --i >= 0 ) {
				
				if ( getCurrentBlock().collectableElements[i].hitTestObject( _sonic ) ) {
					getCurrentBlock().removeChild( getCurrentBlock().collectableElements[i] );
					getCurrentBlock().collectableElements[i] = null;
					getCurrentBlock().collectableElements.splice( i, 1 );
					
					_hud.addPoint();
					
					if ( CONFIG::sound && !CONFIG::debug ) {
						var sound:Sound = new Ressources.SOUND_RING();
						sound.play();
					}
				}
				
			}
			
		}
		
		private function collideVertical() : void
		{
			
			var i:uint = _colliderElements.length;
			
			while ( --i >= 0 && !_sonic.jumping )
			{
				if ( _colliderElements[i].absoluteX <= (_sonic.x + _sonic.width/2) && (_colliderElements[i].absoluteX + _colliderElements[i].width) >= (_sonic.x + _sonic.width/2 ) )
				{
					
					if ( (_sonic.y + _sonic.height) < _colliderElements[i].y )
					{
						_sonic.fall();
						//_sonic.onGround = false;
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
			
			var canMove:Boolean = _running;
			var i:uint = _colliderElements.length;
			
			while ( --i >= 0 )
			{
				if ( 
					_sonic.x < ( _colliderElements[i].absoluteX + _colliderElements[i].width ) &&
					_colliderElements[i].absoluteX < _sonic.x && 
					_colliderElements[i].y < _sonic.y && 
					(_colliderElements[i].y + _colliderElements[i].height) > (_sonic.y + _sonic.height )
				)
				{
					_sonic.animation = "push";
					canMove = false;
					_sonic.jumping = false;
					_sonic.x = (_colliderElements[i].absoluteX + _colliderElements[i].width ) - 1;
					break;
				}
			}
			
			if ( canMove )
				_sonic.moveLeft();
			
		}
		
		public function moveRight() : void
		{
			var canMove:Boolean = _running;
			var i:uint = _colliderElements.length;
			
			while ( --i >= 0 )
			{
				if ( 
					_colliderElements[i].absoluteX < ( _sonic.x + _sonic.width ) &&
					_colliderElements[i].absoluteX > _sonic.x && 
					_colliderElements[i].y < _sonic.y && 
					(_colliderElements[i].y + _colliderElements[i].height) > (_sonic.y + _sonic.height )
				)
				{
					_sonic.animation = "push";
					canMove = false;
					_sonic.jumping = false;
					_sonic.x = (_colliderElements[i].absoluteX - _sonic.width ) + 1;
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