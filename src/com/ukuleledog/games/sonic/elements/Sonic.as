package com.ukuleledog.games.sonic.elements 
{
	import com.ukuleledog.games.sonic.Ressources;
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
	public class Sonic extends Sprite
	{
		
		private var _spritesheet:Bitmap;	
		private var _animation:String;
		private var _frames:uint = 0;
		private var _currentFrame:uint = 0;
		private var _offsetX:uint = 0;
		private var _offsetY:uint = 0;
		private var _height:uint = 0;
		private var _width:uint = 0;
		private var _framerate:uint = 250;
		private var _speed:uint = 5;
		private var _inverted:Boolean = false;
		
		private var _animationTimer:Timer = new Timer(250);
		private var _animationChangeTimer:Timer = new Timer(1000);
		
		public function Sonic() 
		{
			_spritesheet = new Ressources.SONIC();
			animation = 'idle';
			this.scaleX = 2;
			this.scaleY = 2;
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
					_offsetY = 8;
					_offsetX = 157;
					_height = 39;
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
					trace('walk');
					_animationChangeTimer.delay = 1000;
					_animationChangeTimer.addEventListener( TimerEvent.TIMER, animationChange );
					_animationChangeTimer.start();
					break;
				case 'run':
					_frames = 4;
					_offsetY = 94;
					_offsetX = 2;
					_height = 35;
					_width = 34;
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
			//this.x += _speed;
			if ( _animation != 'walk' && _animation != 'run' )
			animation = 'walk';
			_inverted = false;
		}
		
		public function moveLeft() : void
		{
			//this.x -= _speed;
			if ( _animation != 'walk' && _animation != 'run' )
			animation = 'walk';
			_inverted = true;
		}
		
		public function loop() : void
		{
			
			trace(_currentFrame);
			
			switch( _animation )
			{
				case 'idle':
					if ( _currentFrame >= 120 )
					animation = 'wait';
					break;
				case 'wait':
					if ( _currentFrame >= 60 )
					animation = 'idle';
					break;
			}
			
		}
		
	}

}