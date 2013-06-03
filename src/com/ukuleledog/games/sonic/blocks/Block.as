package com.ukuleledog.games.sonic.blocks 
{
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
	public class Block extends Sprite 
	{
		
		protected var id:uint;
		private var _ocean:MovieClip = new asset_ocean();
		private var _backdrop:MovieClip = new asset_backdrop();
		private var _ground:Sprite = new asset_ground();
		
		public function Block( id:uint, type:String ) 
		{
			super();
			this.id = id;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init( e:Event ) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			/*_ocean.width = stage.stageWidth;
			_ocean.scaleY = _ocean.scaleX;*/
			_ocean.height = stage.stageHeight;
			_ocean.scaleX = _ocean.scaleY;
			//_ocean.y = 225;
			addChild( _ocean );
			
			if ( id % 7 == 0 ) {
				_backdrop.gotoAndStop(7);
			} else if ( id % 6 == 0 ) {
				_backdrop.gotoAndStop(6);
			} else if ( id % 5 == 0 ) {
				_backdrop.gotoAndStop(5);
			} else if ( id % 4 == 0 ) {
				_backdrop.gotoAndStop(4);
			} else if ( id % 3 == 0 ) {
				_backdrop.gotoAndStop(3);
			} else if ( id % 2 == 0 ) {
				_backdrop.gotoAndStop(2);
			} else if ( id % 1 == 0 ) {
				_backdrop.gotoAndStop(1);
			}
				
			_backdrop.width = stage.stageWidth;
			_backdrop.scaleY = _backdrop.scaleX;
			_backdrop.y = - 250;
			//addChild( _backdrop );
			
			_ground.width = stage.stageWidth;
			_ground.scaleY = _ground.scaleX;
			_ground.y = 400;
			addChild( _ground );
			
			
		}
		
	}

}