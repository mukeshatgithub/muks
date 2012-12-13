package com.espn.mobile.xgames.events
{
	import flash.events.Event;
	
	/**
	 * 
	 * @author rmish8
	 * SearchItemEvent is dispatched from 
	 * SearchBox component
	 *  
	 */	
	public class SearchItemEvent extends Event
	{
		public static const ITEM_SELECT:String = "itemSelect";
		
		/**
		 * selected item 
		 * 
		 */		
		public var selectedItem:Object;
		
		/**
		 * 
		 * constructor
		 */		
		public function SearchItemEvent(type:String)
		{
			super(type);
		}
		
		/**
		 * @override 
		 */		
		override public function clone():Event
		{
			return new SearchItemEvent(type);
		}
		
	}
}