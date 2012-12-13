//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.model.vo
{
	/**
	 * Value object to store data for a single video Item.
	 */	
	[Bindable]
	public class VideoItemVO
	{
		/*public var thumbnail:String;
		public var largePic:String;
		public var detail:String;
		public var eventType:String;
		public var video:String;*/
		
		public var id:String;
		public var headline:String;
		public var title:String;
		public var description:String;
		public var date:String;
		public var imageUrl:String;
		public var videoId:String;
		public var credit:String;
		
		public var shareUrl:String;
		
		
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