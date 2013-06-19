package com.ukuleledog.games.sonic.ui 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author matt
	 */
	public class Hud extends Sprite 
	{
		
		private var firstNumber:MovieClip = new asset_hudnumber();
		private var secondNumber:MovieClip = new asset_hudnumber();
		private var thirdNumber:MovieClip = new asset_hudnumber();
		
		private var score:uint = 0;
		
		public function Hud() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init( e:Event ) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var scoreText:Sprite = new asset_hudscore();
			scoreText.scaleX = 3;
			scoreText.scaleY = 3;
			scoreText.x = 10;
			scoreText.y = 10;
			addChild( scoreText );
			
			firstNumber.scaleX = 3;
			firstNumber.scaleY = 3;
			firstNumber.x = scoreText.x + scoreText.width + 5;
			firstNumber.y = scoreText.y + 5;
			firstNumber.gotoAndStop( 10 );
			
			secondNumber.scaleX = 3;
			secondNumber.scaleY = 3;
			secondNumber.gotoAndStop( 10 );
			secondNumber.x = firstNumber.x + firstNumber.width;
			secondNumber.y = firstNumber.y;
			
			thirdNumber.scaleX = 3;
			thirdNumber.scaleY = 3;
			thirdNumber.gotoAndStop( 10 );
			thirdNumber.x = secondNumber.x + secondNumber.width;
			thirdNumber.y = firstNumber.y;
			
			addChild( firstNumber );
			addChild( secondNumber );
			addChild( thirdNumber );
		}
		
		public function addPoint() : void
		{
			score++;
			
			var scoreText:String = score.toString();
			var scoreSplit:Array = scoreText.split('');
				
			if ( score > 999 )
			{
				
				firstNumber.gotoAndStop(9);
				secondNumber.gotoAndStop(9);
				thirdNumber.gotoAndStop(9);
				return;
				
			} else if ( score < 10 ) {
				
				firstNumber.gotoAndStop( 10 );
				secondNumber.gotoAndStop( 10 );
			
				if ( scoreSplit[0] == "0" ) {
					thirdNumber.gotoAndStop( 10 )
				} else {
					thirdNumber.gotoAndStop( scoreSplit[0] );
				}
				
			} else if ( score < 100 ) {
				firstNumber.gotoAndStop( 10 );
				
				if ( scoreSplit[0] == "0" ) {
					secondNumber.gotoAndStop( 10 )
				} else {
					secondNumber.gotoAndStop( scoreSplit[0] );
				}
								
				if ( scoreSplit[1] == "0" ) {
					thirdNumber.gotoAndStop( 10 )
				} else {
					thirdNumber.gotoAndStop( scoreSplit[1] );
				}
				
				
			} else  {
				
				if ( scoreSplit[0] == "0" ) {
					firstNumber.gotoAndStop( 10 )
				} else {
					firstNumber.gotoAndStop( scoreSplit[0] );
				}
								
				if ( scoreSplit[1] == "0" ) {
					secondNumber.gotoAndStop( 10 )
				} else {
					secondNumber.gotoAndStop( scoreSplit[1] );
				}
			
				if ( scoreSplit[2] == "0" ) {
					thirdNumber.gotoAndStop( 10 )
				} else {
					thirdNumber.gotoAndStop( scoreSplit[2] );
				}
				
			}
			
		}
		
	}

}