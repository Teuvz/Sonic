package com.ukuleledog.games.sonic
{
	import air.update.ApplicationUpdaterUI;
	import air.update.events.StatusUpdateEvent;
	import air.update.events.UpdateEvent;
	import com.ukuleledog.games.sonic.elements.Level;
	import com.ukuleledog.games.sonic.elements.Sonic;
	import com.ukuleledog.games.sonic.events.LevelEvent;
	import com.ukuleledog.games.sonic.events.MenuEvent;
	import com.ukuleledog.games.sonic.states.GameState;
	import com.ukuleledog.games.sonic.states.MenuState;
	import com.ukuleledog.games.sonic.states.State;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
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
		
		private var _currentState:State;
		
		public function Main():void 
		{		
			checkForUpdate();	
			
			_currentState = new MenuState();
			_currentState.addEventListener( MenuEvent.MENU_START, menuStartHandle );
			addChild( _currentState );
			
			if ( CONFIG::debug ) {
				_stats = new Stats();
				addChild( _stats );
			}
			
			if ( CONFIG::fullscreen ) {
				stage.scaleMode = StageScaleMode.EXACT_FIT;
				stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			}
		}
		
		private function checkForUpdate() : void
		{
			appUpdater.configurationFile = new File("app:/updateConfig.xml"); 
			appUpdater.initialize();
		}
		
		private function menuStartHandle( e:MenuEvent ) : void
		{
			_currentState.removeEventListener( MenuEvent.MENU_START, menuStartHandle );
			removeChild( _currentState );
			_currentState = null;
			_currentState = new GameState();
			addChild( _currentState );
			
			if ( CONFIG::debug ) {
				removeChild( _stats );
				addChild( _stats );
			}
		}
		
	}
	
}