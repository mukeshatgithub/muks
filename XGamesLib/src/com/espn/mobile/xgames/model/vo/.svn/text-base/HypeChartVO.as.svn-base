package com.espn.mobile.xgames.model.vo
{
	import mx.utils.ObjectUtil;

	public class HypeChartVO
	{
		/**
		 * Social Hype Twitter
		 **/
		public var twitterHype:Number; 

		/**
		 * Social Hype Facebook
		 **/
		public var facebookHype:Number; 
	
		/**
		 * device Hype
		 **/
		public var deviceHype:Number; 
		
		/**
		 * Cue Point
		 **/
		public var cuePoint:CuePointVO;
		
		/**
		 * Time of the hype
		 **/
		public var time:Date;
		
		public function HypeChartVO()
		{
		}
		
		/**
		 * Method to trace and debug data
		 **/
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