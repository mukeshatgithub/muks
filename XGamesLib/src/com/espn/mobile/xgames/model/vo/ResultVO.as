package com.espn.mobile.xgames.model.vo
{
	import mx.collections.ArrayCollection;

	public class ResultVO
	{
		public var roundName:String; 
		public var roundNo:int; 
		[Bindable]
		public var competitors:ArrayCollection;
		
		
	}
}