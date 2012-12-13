package com.espn.mobile.xgames.model.vo
{
	/**
	 * Value object to store data for a single event Item.
	 */	
	[Bindable]
	public class EventItemVO
	{
		
		public var date:String;
		public var eventName:String;
		public var eventId:String;
		public var sport:String;
		public var venue:String;
		public var time:String;
		public var timezone:String;
		public var network:String;
		
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