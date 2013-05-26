package com.ukuleledog.games.sonic.elements 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author matt
	 */
	public class Level extends Sprite
	{
		
		private var _sonic:Sonic;
		
		public function Level() 
		{
			_sonic = new Sonic();
			addChild( _sonic );
		}
		
		public function loop() : void
		{
			
		}
		
		public function get sonic() : Sonic
		{
			return _sonic;
		}
		
	}

}