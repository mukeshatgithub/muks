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
	public class ClusterDataEvent extends Event
	{
		
		public static const CLUSTER_DATA_LOADED : String = "cluster_data_loaded";
		
		/**
		 * Event constructor
		 * 
		 */ 
		public function ClusterDataEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		/**
		 * overrride of clone()
		 * 
		 */ 
		override public function clone():Event
		{
			return new ClusterDataEvent(type, true);
		}

	}
}