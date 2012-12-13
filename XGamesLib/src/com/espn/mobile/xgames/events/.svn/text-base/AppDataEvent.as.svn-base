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
	public class AppDataEvent extends Event
	{
		
		public static const APP_XML_LOADED : String = "app_xml_loaded";
		public static const APP_CONFIG_LOADED : String = "app_config_loaded";
		public static const CLUSTER_DATA_LOADED : String = "cluster_data_loaded";
		
		/**
		 * Event constructor
		 * 
		 */ 
		public function AppDataEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		/**
		 * overrride of clone()
		 * 
		 */ 
		override public function clone():Event
		{
			return new AppDataEvent(type, true);
		}

	}
}