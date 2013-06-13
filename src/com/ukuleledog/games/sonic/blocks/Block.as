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
	public class Block extends Sprite 
	{
				
		protected var _id:uint;
		protected var _colliderElements:Vector.<Element>;
		protected var _ocean:MovieClip = new asset_ocean();
		protected var _backdrop:MovieClip = new asset_backdrop();
		protected var _ground:Sprite = new asset_ground();
		
		public function Block( id:uint, type:String ) 
		{
			super();
			this._id = id;
		}
				
		public function get id() : uint
		{
			return _id;
		}
		
		public function get colliderElements() : Vector.<Element>
		{
			return _colliderElements;
		}
		
		public static function generateRandomBlock(id:uint) : Block
		{
			if ( Math.round(Math.random()) == 0 )
			{
				return new Block2(id);
			} else {
				return new Block1(id);
			}
		}
		
	}

}