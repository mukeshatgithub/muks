//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.model.vo
{
	/**
	 * Value object to store the values for categories
	 */
	[Bindable]
	public class CategoryVO
	{
		public var title:String;
		public var link:LinkVO; 
		
		/**
		 * Method to fill in data into the value object.
		 */	
		public function fill(o:Object):void
		{
			for(var s:String in o)
			{
				if(s == "link")
				{
					link = new LinkVO();
					link.fill(o[s]);
				}
				else
				{
					this[s] = o[s];
				}
				
			}
		}
	}
}