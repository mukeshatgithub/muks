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
	public class StyleableGridRowEvent extends Event
	{
		
		public static const ICON_CLICKED : String = "iconClicked";
		public static const BUTTON_CLICKED : String = "buttonClicked";
		public static const STAR_CLICKED : String = "starClicked";		
		public static const ROWS_CREATED : String = "rowsCreated";
		public static const WATCH_ESPN_CLICKED : String = "watchESPNClicked";

		public var payload:Object;
		public var rowIndex:int;
		public var columnIndex:int;
		public var rowData:Object;
		
		public var makeFavorite:Boolean = false;
		
		/**
		 * Event constructor
		 * 
		 */ 
		public function StyleableGridRowEvent(type:String)
		{
			this.payload = payload
			super(type, true);
		}
		
		/**
		 * overrride of clone()
		 * 
		 */ 
		override public function clone():Event
		{
			return new StyleableGridRowEvent(type);
		}

	}
}