package com.espn.mobile.xgames.model
{
	import com.espn.mobile.xgames.model.vo.XFavoriteVO;
	import com.espn.mobile.xgames.model.vo.XVoteVO;
	
	import mx.collections.ArrayCollection;

	public interface IXModel
	{
		function saveFavorite(value:XFavoriteVO):void;
		function removeFavorite(value:XFavoriteVO):void;
		function resetFavorite():void;
		function get favoriteList():ArrayCollection;
		function set favoriteList(value:ArrayCollection):void;
		
		
		function saveVote(value:XVoteVO):void;
		function removeVote(value:XVoteVO):void;
		function resetVote():void;
		function get voteList():ArrayCollection;
		function set voteList(value:ArrayCollection):void;
	}
}