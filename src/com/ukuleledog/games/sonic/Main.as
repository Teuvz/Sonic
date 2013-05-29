package com.ukuleledog.games.sonic
{
	import air.update.ApplicationUpdaterUI;
	import air.update.events.StatusUpdateEvent;
	import air.update.events.UpdateEvent;
	import com.ukuleledog.games.sonic.elements.Level;
	import com.ukuleledog.games.sonic.elements.Sonic;
	import com.ukuleledog.games.sonic.events.LevelEvent;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.filesystem.File;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import net.hires.debug.Stats;
	
	/**
	 * ...
	 * @author matt
	 */
	public class Main extends Sprite 
	{
		
		private var _stats:Stats;	
		private var appUpdater:ApplicationUpdaterUI = new ApplicationUpdaterUI();
		
		private var _currentState:GameState;
		
		public function Main():void 
		{						
			checkForUpdate();	
			
			_currentState = new GameState();
			addChild( _currentState );
			
			if ( CONFIG::debug ) {
				_stats = new Stats();
				addChild( _stats );
			}
		}
		
		private function checkForUpdate() : void
		{
			appUpdater.configurationFile = new File("app:/updateConfig.xml"); 
			appUpdater.initialize();
		}
		
	}
	
}