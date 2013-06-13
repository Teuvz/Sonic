package com.ukuleledog.games.sonic.blocks 
{
	import com.ukuleledog.games.sonic.elements.Element;
	import com.ukuleledog.games.sonic.Ressources;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author matt
	 */
	public class Block1 extends Block 
	{

		
		public function Block1( id:uint ) 
		{
			super(id, "lala");
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init( e:Event ) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_ocean.width = stage.stageWidth;
			_ocean.height = 415;
			addChild( _ocean );
						
			_ground.width = stage.stageWidth;
			_ground.scaleY = _ground.scaleX;
			_ground.y = 400;
			addChild( _ground );
						
			_colliderElements = new Vector.<Element>();
			var floor:Element = new Element();
			floor.graphics.beginFill( 0x00AA00, 0.3);
			floor.graphics.drawRect( 0, 0, this.width, 50 );
			floor.graphics.endFill();
			floor.y = 415;
			floor.visible = true;
			floor.absoluteX = this.x;
			addChild( floor );
			_colliderElements.push(floor);
						
		}
		
	}

}