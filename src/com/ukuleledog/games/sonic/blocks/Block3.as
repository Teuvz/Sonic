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
	public class Block3 extends Block 
	{

		
		public function Block3( id:uint ) 
		{
			super(id, "lala");
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init( e:Event ) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_ocean.width = stage.stageWidth;
			_ocean.height = stage.stageHeight;
			addChild( _ocean );
						
			_ground.width = stage.stageWidth;
			_ground.scaleY = _ground.scaleX;
			_ground.y = 400;
			
			if ( Math.round( Math.random() ) == 0 )
			_ground.gotoAndStop('bridge');
			
			addChild( _ground );
						
			_colliderElements = new Vector.<Element>();
			var floor:Element = new Element();
			floor.graphics.beginFill( 0x00AA00, 0.3);
			floor.graphics.drawRect( 0, 0, this.width, 50 );
			floor.graphics.endFill();
			floor.y = 415;
			floor.visible = false;
			floor.absoluteX = this.x;
			addChild( floor );
			_colliderElements.push(floor);
			
			_collectableElements = new Vector.<Element>();
			var ring:Element = new Element();
			ring.addChild( new asset_ring() );
			ring.x = this.width / 2;
			ring.y = 215;
			ring.scaleX = 3;
			ring.scaleY = 3;
			addChild( ring );
			
			var ring2:Element = new Element();
			ring2.addChild( new asset_ring() );
			ring2.x = ring.x - ring.width - 10;
			ring2.y = 215;
			ring2.scaleX = 3;
			ring2.scaleY = 3;
			addChild( ring2 );
			
			var ring3:Element = new Element();
			ring3.addChild( new asset_ring() );
			ring3.x = ring.x + ring.width + 10;
			ring3.y = 215;
			ring3.scaleX = 3;
			ring3.scaleY = 3;
			addChild( ring3 );
						
			_collectableElements.push( ring );
			_collectableElements.push( ring2 );
			_collectableElements.push( ring3 );
						
		}
		
	}

}