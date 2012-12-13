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
	public class ArticleDataEvent extends Event
	{
		
		public static const ARTICLE_DATA_LOADED : String = "article_data_loaded";
		
		/**
		 * Event constructor
		 * 
		 */ 
		public function ArticleDataEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		/**
		 * overrride of clone()
		 * 
		 */ 
		override public function clone():Event
		{
			return new ArticleDataEvent(type, true);
		}

	}
}