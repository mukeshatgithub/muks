//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.events
{
	import flash.events.Event;
	
	/**
	 * AppDataEvent
	 */
	public class AthleteDataEvent extends Event
	{
		public static const ATHLETE_DATA_LOADED : String = "athlete_data_loaded";
		
		/**
		 * Event constructor
		 * 
		 */ 
		public function AthleteDataEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		/**
		 * overrride of clone()
		 * 
		 */ 
		override public function clone():Event
		{
			return new AthleteDataEvent(type, true);
		}
	}
}