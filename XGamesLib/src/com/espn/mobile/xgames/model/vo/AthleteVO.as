//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.model.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	/**
	 * Value object to store the information for athlete
	 */
	public class AthleteVO
	{
		public var id:Number;
		public var athleteID:Number;
		public var name:String;
		public var athleteName:String;
		public var sport:String;
		public var gender:String;
		public var age:Number;
		public var birthdate:Number;
		public var debutYear:String;
		public var height:Number;
		public var weight:Number;
		public var nickname:String;
		public var country:String;
		public var flagImg:String;
		public var city:String;
		public var state:String;
		public var bio:String;
		public var athleteWebsiteURL:String;
		public var athleteSpotifyKey:String;
		public var twitter:String;
		public var photoURL:String;
		public var link:LinkVO;
		public var competitionHistory:ArrayCollection;
		public var athleteVideos:ArrayCollection;
		
		public var isFavorite:Boolean;
		
		/**
		 * Method to fill in data into the value object.
		 */	
		public function fill(o:Object):void
		{
			for(var s:String in o)
			{
				if(s=="link")
				{
					link = new LinkVO();
					link.fill(o[s]);
				}
				else if(s=="competitionHistory")
				{
					
				}
				else if(s=="athleteVideos")
				{
					
				}
				else
				{
					this[s] = o[s];
				}
			}
		}
		
		/*public var homeTown:String;
		public var category:String;
		public var nationality:String;
		public var medals:String;
		*/
	}
}