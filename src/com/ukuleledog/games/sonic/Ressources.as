package com.ukuleledog.games.sonic 
{
	/**
	 * ...
	 * @author matt
	 */
	public class Ressources 
	{
		
		//[Embed (source="../../../../../lib/assets/img/sonic.png" )]
    	//public static const SONIC:Class;
		
		[Embed (source="../../../../../lib/assets/img/menu.png" )]
    	public static const START_MENU:Class;
		
		[Embed (source="../../../../../lib/assets/img/level.png" )]
    	public static const LEVEL:Class;
		
		[Embed (source = '../../../../../lib/assets/mp3/menu.mp3')]
		public static const MUSIC_MENU:Class;
		
		[Embed (source = '../../../../../lib/assets/mp3/level.mp3')]
		public static const MUSIC_LEVEL:Class;
		
		[Embed (source = '../../../../../lib/assets/mp3/jump.mp3')]
		public static const SOUND_JUMP:Class;
		
		public function Ressources() 
		{
			
		}
		
	}

}