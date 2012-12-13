package com.espn.mobile.xgames.controllers
{
	import com.espn.mobile.xgames.constants.AppConstants;
	import com.espn.mobile.xgames.events.SimpleMessageEvent;
	import com.espn.mobile.xgames.events.XAlertFavoriteEvent;
	import com.espn.mobile.xgames.events.XFavoriteEvent;
	import com.espn.mobile.xgames.events.XVoteEvent;
	import com.espn.mobile.xgames.model.IXModel;
	import com.espn.mobile.xgames.model.vo.XFavoriteVO;
	import com.espn.mobile.xgames.model.vo.XVoteVO;
	import com.espn.mobile.xgames.model.vo.alerts.XAlertFavoriteVO;
	
	import flash.events.IEventDispatcher;

	public class XController
	{
		/**
		 * dispatcher is an event dispatcher injected by SWIZ 
		 */
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Inject]
		public var model:IXModel;
		[Inject]
		public var omnitureController:OmnitureController;
		
		
		/**
		 * Remove an item from the model
		 */
		[EventHandler(event="XFavoriteEvent.REMOVE_ITEM")]
		public function onRemoveFavorite(event:XFavoriteEvent):void
		{
			var favorite:XFavoriteVO;
			for(var count:Number=0; count< model.favoriteList.length; count++) 
			{
				var favVO:XFavoriteVO = model.favoriteList.getItemAt(count) as XFavoriteVO;
				if(favVO && favVO.favId && favVO.favId == event.data.favId.toString()) 
				{
					favorite = favVO;
				}
			}
			
			var pageName:String = "";
			var xFavorite:XAlertFavoriteVO = new XAlertFavoriteVO();
			xFavorite.sqliteObject = favorite;
			xFavorite.appId = "19";  // use 19 for mobile and 30 for tablet;
			xFavorite.type = "5";
			xFavorite.favoriteId = favorite.favId;
			xFavorite.itemName = favorite.name;
			if(favorite.type == AppConstants.FAVORITE_EVENTS)
			{
				xFavorite.keyName = "eventId";
				pageName = "results";
			}
			if(favorite.type == AppConstants.FAVORITE_ATHLETE)
			{
				xFavorite.keyName = "athleteId";
				pageName = "athletes";
			}
			dispatcher.dispatchEvent(new SimpleMessageEvent(SimpleMessageEvent.SHOW_SIMPLE_MESSAGE,AppConstants.FAVORITE_LIST_UPDATING_NOW));
			dispatcher.dispatchEvent(new XAlertFavoriteEvent(XAlertFavoriteEvent.FAVORITE_ALERT_OFF,xFavorite));
			
			omnitureController.trackFavoritesAlerts(pageName, null, favorite.name, "favoritesalert", "", false);
		}
		
		/**
		 * Add an item from the model
		 */
		[EventHandler(event="XFavoriteEvent.ADD_ITEM")]
		public function onAddFavorite(event:XFavoriteEvent):void
		{
			var favorite:XFavoriteVO = event.data;
			var xFavorite:XAlertFavoriteVO = new XAlertFavoriteVO();
			xFavorite.sqliteObject = favorite;
			xFavorite.appId = "19";  // use 19 for mobile and 30 for tablet;
			xFavorite.type = "5";
			xFavorite.favoriteId = favorite.favId;
			xFavorite.itemName = favorite.name;
			
			var pageName:String = "";
			if(favorite.type == AppConstants.FAVORITE_EVENTS)
			{
				xFavorite.keyName = "eventId";
				pageName = "results";
			}
			if(favorite.type == AppConstants.FAVORITE_ATHLETE)
			{
				xFavorite.keyName = "athleteId";
				pageName = "athletes";
			}
			dispatcher.dispatchEvent(new SimpleMessageEvent(SimpleMessageEvent.SHOW_SIMPLE_MESSAGE,AppConstants.FAVORITE_LIST_UPDATING_NOW));
			dispatcher.dispatchEvent(new XAlertFavoriteEvent(XAlertFavoriteEvent.FAVORITE_ALERT_ON,xFavorite));
			
			omnitureController.trackFavoritesAlerts(pageName, null, favorite.name, "favoritesalert", "", true);
		}
		
		
		
		[EventHandler(event="XAlertFavoriteEvent.FAVORITE_ALERT_ON_SUCCESS")]
		public function onAddFavoriteSucess(event:XAlertFavoriteEvent):void
		{
			var favVO:XFavoriteVO = event.data.sqliteObject;
			dispatcher.dispatchEvent(new SimpleMessageEvent(SimpleMessageEvent.SHOW_SIMPLE_MESSAGE,AppConstants.FAVORITE_LIST_UPDATED));
			dispatcher.dispatchEvent(new XFavoriteEvent(XFavoriteEvent.MOBILE_APP_SUCESS,favVO));
			model.saveFavorite(favVO);
			
			var pageName:String = "";
			if(favVO.type == AppConstants.FAVORITE_EVENTS)
				pageName = "results";
			else
				pageName = "athletes";
			
			omnitureController.trackBreakingNewsAlerts(pageName, null, favVO.name, "favoritesalert", "", true);
			
		}
		
		[EventHandler(event="XAlertFavoriteEvent.FAVORITE_ALERT_ON_FAILED")]
		public function onAddFavoriteFail(event:XAlertFavoriteEvent):void
		{	
			dispatcher.dispatchEvent(new SimpleMessageEvent(SimpleMessageEvent.SHOW_SIMPLE_MESSAGE,AppConstants.FAVORITE_LIST_NOT_UPDATED));
		}
		
		[EventHandler(event="XAlertFavoriteEvent.FAVORITE_ALERT_OFF_SUCCESS")]
		public function onAddFavoriteOffSucess(event:XAlertFavoriteEvent):void
		{
			var favVO:XFavoriteVO = event.data.sqliteObject;
			dispatcher.dispatchEvent(new SimpleMessageEvent(SimpleMessageEvent.SHOW_SIMPLE_MESSAGE,AppConstants.FAVORITE_LIST_UPDATED));
			dispatcher.dispatchEvent(new XFavoriteEvent(XFavoriteEvent.MOBILE_APP_SUCESS,favVO));
			model.removeFavorite(favVO);
			
			var pageName:String = "";
			if(favVO.type == AppConstants.FAVORITE_EVENTS)
				pageName = "results";
			else
				pageName = "athletes";
			
			omnitureController.trackBreakingNewsAlerts(pageName, null, favVO.name, "favoritesalert", "", false);
		}
		
		[EventHandler(event="XAlertFavoriteEvent.FAVORITE_ALERT_OFF_FAILED")]
		public function onAddFavoriteOffFail(event:XAlertFavoriteEvent):void
		{
			dispatcher.dispatchEvent(new SimpleMessageEvent(SimpleMessageEvent.SHOW_SIMPLE_MESSAGE,AppConstants.FAVORITE_LIST_NOT_UPDATED));
		}
		
		/**
		 * Remove vote from the model
		 */
		[EventHandler(event="XVoteEvent.REMOVE_ITEM")]
		public function onRemoveVote(event:XVoteEvent):void
		{
			var vote:XVoteVO = event.data;
			model.removeVote(vote);
		}
		
		/**
		 * Add vote to the model
		 */
		[EventHandler(event="XVoteEvent.ADD_ITEM")]
		public function onAddVote(event:XVoteEvent):void
		{
			var vote:XVoteVO = event.data;
			model.saveVote(vote);
		}
		
	}
}