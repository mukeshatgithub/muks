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
	public class CuePointEvent extends Event
	{
		
		public static const CUE_POINT_DETAILS_REQUESTED:String = "cue_point_details_requested";
		
		/**
		 * variable to hold error details
		 */ 
		public var data:Object;
		
		/**
		 * Event constructor
		 * 
		 */ 
		public function CuePointEvent(type:String, data:Object, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			this.data = data;
			super(type, bubbles, cancelable);
		}
		
		/**
		 * overrride of clone()
		 * 
		 */ 
		override public function clone():Event
		{
			return new CuePointEvent(type, data, true);
		}

	}
}