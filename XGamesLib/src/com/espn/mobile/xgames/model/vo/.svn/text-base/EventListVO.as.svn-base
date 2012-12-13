//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.model.vo
{
	/**
	 * Value object to store Event List Item.
	 */	
	[Bindable]
	public class EventListVO
	{
		public var listLabel:String;
		public var category:String;
		public var eventComplete:String;
		public var toggled:Boolean = false;
		
		
		/**
		 * Method to fill in data into the value object.
		 */	
		public function fill(o:Object):void
		{
			for(var s:String in o)
			{
				this[s] = o[s];
			}
		}
	}
}