//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * AppDataEvent
	 */
	public class ScheduleParsingEvent extends Event
	{
		
		public static const SCHEDULE_DATA_LOADED : String = "SCHEDULE_DATA_LOADED";
		
		/**
		 * Event constructor
		 * 
		 */ 
		public function ScheduleParsingEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		/**
		 * overrride of clone()
		 * 
		 */ 
		override public function clone():Event
		{
			return new ScheduleParsingEvent(type, true);
		}

	}
}