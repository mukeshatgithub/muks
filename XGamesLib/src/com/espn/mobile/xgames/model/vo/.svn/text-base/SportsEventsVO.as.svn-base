//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.model.vo
{
	/**
	 * Value object to store all the events related
	 * information for a particular sport
	 */
	[Bindable]
	public class SportsEventsVO
	{
		public var id:String;
		public var name:String;
		public var link:LinkVO;
		public var toggled:Boolean = false;
		
		/**
		 * Method to fill in data into the value object.
		 */	
		public function fill(o:Object):void
		{
			for(var s:String in o)
			{
				/* Fill the linkVO */
				if(s=="link")
				{
					link = new LinkVO();
					link.fill(o[s]);
				}
				else
					this[s] = o[s];
			}
		}
	}
}