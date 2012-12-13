package com.espn.mobile.xgames.model.vo
{
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectUtil;

	public class MatchVO
	{
		public var matchID:Number; 
		public var totalVotes:Number;
		public var status:String;
		public var pollID:String;
		[Bindable]
		public var firstContestant:ContestantVO;
		[Bindable]
		public var secondContestant:ContestantVO;
		[Bindable]
		public var judgeWinner:ContestantVO;
		
		
		public function toString():String
		{
			var str:String = "";
			for(var propCounter:uint; propCounter<ObjectUtil.getClassInfo(this).properties.length; propCounter++)
			{
				var item:String = ObjectUtil.getClassInfo(this).properties[propCounter];
				str += item + " " + this[item] + "\r";
			}
			
			return str;
		}
	}
}