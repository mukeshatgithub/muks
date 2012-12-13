package com.espn.mobile.xgames.events
{
	import com.espn.mobile.xgames.model.vo.XVoteVO;
	
	import flash.events.Event;
	
	public class XVoteEvent extends Event
	{
		
		public static const REMOVE_ITEM:String = "removeItem";
		public static const ADD_ITEM:String = "addItem";
		
		private var _data:XVoteVO;
		
		public function XVoteEvent(type:String, data:XVoteVO = null):void
		{
			super(type, true, false);
			_data = data;
		}
		
		public function get data():XVoteVO
		{
			return _data;
		}
	}
}