package com.espn.mobile.xgames.model.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class RealSeriesVoteVO
	{
		public var matchID:String;
		public var pollID:String;
		public var url:String;
		public var totalVotes:uint;
		
		public var contestants:ArrayCollection;
	}
}