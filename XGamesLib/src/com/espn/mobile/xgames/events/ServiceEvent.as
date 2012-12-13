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
	 * ServiceEvent
	 */
	public class ServiceEvent extends Event
	{
		
		public static const REFRESH_TOPICS : String = "refresh_topics";

		/**
		 * Event constructor
		 * 
		 */ 
		public function ServiceEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		/**
		 * overrride of clone()
		 * 
		 */ 
		override public function clone():Event
		{
			return new ServiceEvent(type, true);
		}
	}
}