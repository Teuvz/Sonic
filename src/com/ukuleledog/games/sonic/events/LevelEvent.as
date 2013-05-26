package com.ukuleledog.games.sonic.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author matt
	 */
	public class LevelEvent extends Event 
	{
		
		public static const RESTART:String = 'restart';
		
		public function LevelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new LevelEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("LevelEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}