package com.ukuleledog.games.sonic.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author matt
	 */
	public class MenuEvent extends Event 
	{
		
		public static const MENU_START:String = "menu_start";
		
		public function MenuEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new MenuEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MenuEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}