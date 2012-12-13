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
	public class LazyLoadingServiceEvent extends Event
	{
		
		public static const SERVICE_LOADED : String = "service_loaded";
		public static const DATE_RECEIVED : String = "date_received"; 
		
		/** ClusterData obj  */
		public var clusterObj:Object;
		
		
		/**
		 * Event constructor
		 * 
		 */ 
		public function LazyLoadingServiceEvent(type:String, val:Object,  bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.clusterObj = val;
		}
		
		/**
		 * overrride of clone()
		 * 
		 */ 
		override public function clone():Event
		{
			return new LazyLoadingServiceEvent(type, clusterObj, true);
		}

	}
}