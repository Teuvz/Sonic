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
	public class Block2 extends Block 
	{

		
		public function Block2( id:uint ) 
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
			addChild( _ground );
						
			_colliderElements = new Vector.<Element>();
			var floor:Element = new Element();
			floor.graphics.beginFill( 0x00FF00, 0.3);
			floor.graphics.drawRect( 0, 0, this.width, 50 );
			floor.graphics.endFill();
			floor.y = 415;
			floor.visible = false;
			floor.absoluteX = this.x;
			addChild( floor );
			_colliderElements.push(floor);
			
			var wall:Element = new Element();
			
			if ( CONFIG::shapes ) {
				wall.graphics.lineStyle( 1, 0x00FF00 );
			}
			
			wall.graphics.drawRect( 0, 0, 64, 136 );
			wall.absoluteX = this.x + 300;
			wall.x = 300;
			wall.y = 320;
			wall.addChild( new asset_block() );
			wall.scaleX = 3;
			wall.scaleY = 3;
			addChild( wall );
			_colliderElements.push(wall);
			
			_collectableElements = new Vector.<Element>();
			var ring:Element = new Element();
			ring.addChild( new asset_ring() );
			ring.x = this.width / 2 + 10;
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
			
			_collectableElements.push( ring );
			_collectableElements.push( ring2 );
									
		}
		
	}

}