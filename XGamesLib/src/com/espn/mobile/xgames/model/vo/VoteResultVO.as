package com.espn.mobile.xgames.model.vo
{
	/**
	 * Value object to store data for a single vote result returned on each voting.
	 */	
	[Bindable]
	public class VoteResultVO
	{
		public var pollId:String
		public var athleteId:String;
		public var athelteName:String;
		public var votePercentage:Number;
		public var athleteTotalVotes:Number;
		public var pollTotalVotes:Number;
		public var pollClosed:Boolean;
		
	}
}