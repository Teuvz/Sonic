package com.ukuleledog.games.sonic.elements 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author matt
	 */
	public class Element extends Sprite
	{
		
		public var absoluteX:int;
		public var absoluteY:int;
		
		public function Element() 
		{
			
			//if ( CONFIG::shapes )
			//this.addEventListener( Event.ADDED_TO_STAGE, init );
			
		}
		
		private function init( e:Event ) : void 
		{
			this.graphics.lineStyle( 1, 0xFF0000 );
			this.graphics.drawRect( 0, 0, this.width, this.height );
		}
		
	}

}