package com.ukuleledog.games.sonic.elements 
{
	import com.ukuleledog.games.sonic.Ressources;
	import flash.display.AVM1Movie;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author matt
	 */
	public class Sonic extends Element
	{

		private const _speedWalk:uint = 20;
		private const _speedRun:uint = 40;
		
		private var _view:MovieClip;
		
		private var _animation:String;
		private var _speed:uint = 20;
		private var _fallSpeed:uint = 10;
		private var _fallSpeedMin:uint = 10;
		private var _fallSpeedMax:uint = 30;
		private var _inverted:Boolean = false;
		private var _onGround:Boolean = false;
		private var _jumping:Boolean = false;
		private var _jumpToY:uint = 0;
		
		private var _animationChangeTimer:Timer = new Timer(1000);
		
		private var _jumpSound:Sound = new Ressources.SOUND_JUMP();
		
		public function Sonic() 
		{
			_view = new asset_sonic();
			animation = 'idle';
			this.scaleX = 2;
			this.scaleY = 2;
			addChild(_view);
			
			if ( CONFIG::debug && CONFIG::shapes ) {
				_view.graphics.lineStyle( 1, 0xFF0000 );
				_view.graphics.drawRect( 0, 0, this.width / 2, this.height / 2 );
			}
		}
		
		public function get waiting() : Boolean
		{
			return (_animation == 'wait' || _animation == 'idle');
		}
		
		public function get crouching() : Boolean
		{
			return _animation == 'down';
		}
		
		public function get jumping() : Boolean
		{
			return _jumping;
		}
		
		public function set jumping( value:Boolean ) : void
		{
			
			trace( "jumping" );
			
			if ( value == true )
				jump();
			else
				_jumping = false;
		}
		
		public function set animation( name:String ) : void
		{
			
			if ( _jumping && name != 'jumpball' )
				name = 'jump';
			
			if ( name == _animation )
				return;
				
			switch( name )
			{
				case 'idle':
					_speed = _speedWalk;
					_view.gotoAndStop(name);
					_animationChangeTimer.delay = 2000;
					_animationChangeTimer.addEventListener( TimerEvent.TIMER, animationChange );
					_animationChangeTimer.start();
					break;
				case 'walk':
					_speed = _speedWalk;
					_view.gotoAndStop(name);
					_animationChangeTimer.delay = 1000;
					_animationChangeTimer.addEventListener( TimerEvent.TIMER, animationChange );
					_animationChangeTimer.start();
					break;
				case 'run':
					_speed = _speedRun;
					_view.gotoAndStop(name);
					break;
				case 'wait':
				case 'down':
				case 'jump':
				case 'jumpball':
				case 'push':
					_view.gotoAndStop(name);
					break;
				default:
					_view.gotoAndStop('down');
					break;
			}
			
			_animation = name;
			
			
		}
		
		private function animate( e:TimerEvent=null ) : void
		{
			_view.nextFrame();
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
			this.x += _speed;
			
			if ( _jumping || !_onGround )
			animation = 'jumpball';
			else if ( _speed == _speedRun )
			animation = 'run';
			else if ( _animation != 'walk' && _animation != 'run' )			
			animation = 'walk';
			
			if ( _inverted ) {
				_inverted = false;
				scaleX = 2;
				scaleY = 2;
				_view.x = 0;
			}
		}
		
		public function moveLeft() : void
		{
			this.x -= _speed;
			
			if ( _jumping || !_onGround )
			animation = 'jumpball';
			else if ( _speed == _speedRun )
			animation = 'run';
			else if ( _animation != 'walk' && _animation != 'run' )
			animation = 'walk';
			
			if ( !_inverted ) {
				_inverted = true;
				scaleX = -2;
				scaleY = 2;
				_view.x -= (_view.width - 7);
			}
		}
		
		public function jump() : void
		{
			
			if ( _onGround == true && _jumping == false )
			{
				
				trace( "jumping 2" );
				
				_jumping = true;
				_onGround = false;
				animation = 'jump';
				_jumpToY = y - 100;
				
				if (CONFIG::sound == true && !CONFIG::debug)
					_jumpSound.play();
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
				_fallSpeed++;
			}
			
		}
		
	}

}