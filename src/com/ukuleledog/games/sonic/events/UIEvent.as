package com.ukuleledog.games.sonic.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author matt
	 */
	public class UIEvent extends Event 
	{
		
		public static const BUTTON_DOWN:String = "button_down";
		public static const BUTTON_UP:String = "button_up";
		
		private var _button:uint;
		
		public function UIEvent(type:String, button:uint) 
		{ 
			super(type, bubbles, cancelable);
			_button = button;
		} 
		
		public override function clone():Event 
		{ 
			return new UIEvent(type, _button);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("UIEvent", "type", "button"); 
		}
		
		public function get button() : uint
		{
			return _button;
		}
		
	}
	
}