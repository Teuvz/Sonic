package com.ukuleledog.games.sonic.elements 
{
	import com.ukuleledog.games.sonic.Ressources;
	import flash.display.AVM1Movie;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author matt
	 */
	public class Sonic extends Element
	{

		private const _speedWalk:uint = 20;
		private const _speedRun:uint = 40;
		
		private var _spritesheet:Bitmap;	
		private var _animation:String;
		private var _frames:uint = 0;
		private var _currentFrame:uint = 0;
		private var _offsetX:uint = 0;
		private var _offsetY:uint = 0;
		private var _height:uint = 0;
		private var _width:uint = 0;
		private var _framerate:uint = 250;
		private var _speed:uint = 7;
		private var _fallSpeed:uint = 10;
		private var _fallSpeedMax:uint = 30;
		private var _inverted:Boolean = false;
		private var _onGround:Boolean = false;
		private var _jumping:Boolean = false;
		private var _jumpToY:uint = 0;
		
		private var _animationTimer:Timer = new Timer(250);
		private var _animationChangeTimer:Timer = new Timer(1000);
		
		public function Sonic() 
		{
			_spritesheet = new Ressources.SONIC();
			animation = 'idle';
			this.scaleX = 2;
			this.scaleY = 2;
		}
		
		public function get waiting() : Boolean
		{
			return (_animation == 'wait' || _animation == 'idle');
		}
		
		public function set jumping( value:Boolean ) : void
		{
			if ( value == true )
				jump();
			else
				_jumping = false;
		}
		
		public function set animation( name:String ) : void
		{
			
			if ( name == _animation )
				return;
			
			switch( name )
			{
				case 'idle':
					_frames = 1;
					_offsetX = 5;
					_offsetY = 8;
					_height = 39;
					_width = 30;
					_framerate = 0;
					_animationChangeTimer.delay = 6000;
					_animationChangeTimer.addEventListener( TimerEvent.TIMER, animationChange );
					_animationChangeTimer.start();
					break;
				case 'wait':
					_frames = 2;
					_offsetX = 37;
					_offsetY = 8;
					_height = 39;
					_width = 30;
					_framerate = 150;
					break;
				case 'down':
					_frames = 1;
					_offsetY = 21;
					_offsetX = 157;
					_height = 26;
					_width = 30;
					_framerate = 0;
					break;
				case 'jump':
					_frames = 1;
					_offsetY = 2;
					_offsetX = 186;
					_height = 45;
					_width = 30;
					_framerate = 0;
					break;
				case 'walk':
					_frames = 6;
					_offsetY = 50;
					_offsetX = 6;
					_height = 39;
					_width = 34;
					_framerate = 100;
					_animationChangeTimer.delay = 1000;
					_animationChangeTimer.addEventListener( TimerEvent.TIMER, animationChange );
					_animationChangeTimer.start();
					_speed = _speedWalk;
					break;
				case 'run':
					_frames = 4;
					_offsetY = 94;
					_offsetX = 2;
					_height = 35;
					_width = 34;
					_framerate = 100;
					_speed = _speedRun;
					break;
				case 'push':
					_frames = 1;
					_offsetY = 263;
					_offsetX = 8;
					_height = 37;
					_width = 25;
					_framerate = 100;
					break;
			}
			
			_currentFrame = 0;
			_animation = name;
			_animationTimer.reset();
			if ( _framerate != 0 )
			{
				_animationTimer.addEventListener(TimerEvent.TIMER, animate );
				_animationTimer.delay = _framerate;
				_animationTimer.start();
			}
			else
			{
				_animationTimer.removeEventListener( TimerEvent.TIMER, animate );
				animate();
			}
			
		}
		
		private function animate( e:TimerEvent=null ) : void
		{
			this.graphics.clear();
			var img:BitmapData = new BitmapData( _width, _height, true, 0x2C6A8A );
			img.copyPixels( _spritesheet.bitmapData, new Rectangle( _offsetX + (_currentFrame * _width), _offsetY, _width, _height ), new Point(0, 0) );
			
			if ( _inverted )
			{
				var matrix:Matrix = new Matrix( -1, 0, 0, 1, img.width, 0);
				var flipped:BitmapData = new BitmapData( img.width, img.height, img.transparent );
				flipped.draw( img, matrix );
				img = flipped;
			}
			
			this.graphics.beginBitmapFill( img );
			this.graphics.drawRect( 0, 0, _width, _height );
			this.graphics.endFill();
			
			if ( ++_currentFrame == _frames )
				_currentFrame = 0;

		}
		
		private function animationChange( e:TimerEvent ) : void
		{
			_animationChangeTimer.removeEventListener(TimerEvent.TIMER, animationChange);
			_animationChangeTimer.reset();
			
			switch( _animation )
			{
				case 'idle':
					animation = 'wait';
					break;
				case 'walk':
					animation = 'run';
					break;
			}
		}
		
		public function moveRight() : void
		{
			//if ( _onGround )
			if ( true )
			{
				this.x += _speed;
				if ( _animation != 'walk' && _animation != 'run' )
				animation = 'walk';
			}
			_inverted = false;
		}
		
		public function moveLeft() : void
		{
			//if ( _onGround )
			if ( true )
			{
				this.x -= _speed;
				if ( _animation != 'walk' && _animation != 'run' )
				animation = 'walk';
			}
			_inverted = true;
		}
		
		public function jump() : void
		{
			if ( _onGround == true && _jumping == false )
			{
				_jumping = true;
				_onGround = false;
				animation = 'jump';
				_jumpToY = y - 100;
			}
		}
		
		public function crouch() : void
		{
			if ( _onGround  )
				animation = 'down';
		}
		
		public function loop() : void
		{
			if ( _jumping )
			{
				if ( y > _jumpToY )
					this.y -= _fallSpeed * 1.5;
				else 
					_jumping = false;
			}
		}
	
		public function set onGround( value:Boolean ) : void
		{
			_onGround = value;
			
			if ( _onGround == true )
			{
				if ( _jumping )
					_jumping = false;
					
				_fallSpeed = 5;
			}
		}
		
		public function fall() : void
		{
			if ( !_jumping )
			{
				this.y += _fallSpeed;				
			}
			
		}
		
	}

}