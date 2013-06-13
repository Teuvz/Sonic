package com.ukuleledog.games.sonic.states 
{
	import com.ukuleledog.games.sonic.Ressources;
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	/**
	 * ...
	 * @author matt
	 */
	public class State extends Sprite 
	{
		
		protected var _music:SoundChannel;
		
		public function State() 
		{
			super();
			
		}
		
		protected function startMusic( sound:Sound, loop:Boolean = false ) : void
		{
			if (CONFIG::sound != true || CONFIG::debug)
				return;
			
			if ( loop ) 
				_music = sound.play(0,9999);
			else
				_music = sound.play();
		}
		
		protected function stopMusic() : void
		{
			if ( _music != null )
			_music.stop();
		}
		
	}

}