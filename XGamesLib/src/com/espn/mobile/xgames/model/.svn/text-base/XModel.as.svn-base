package com.espn.mobile.xgames.model
{
	import com.sapient.mobile.library.data.orm.IFlexORMDelegate;
	import com.sapient.mobile.library.data.orm.events.ORMError;
	import com.espn.mobile.xgames.events.AppErrorEvent;
	import com.espn.mobile.xgames.model.vo.XFavoriteVO;
	import com.espn.mobile.xgames.model.vo.XVoteVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	public class XModel extends EventDispatcher implements IXModel
	{
		
		private const FAVORITE_LIST_UPDATED:String = "favoriteListUpdated";
		private const VOTE_LIST_UPDATED:String = "voteListUpdated";
		
		
		private const DB_NAME:String = 'XGames';
		
		[Inject]
		public var delegate:IFlexORMDelegate;
		
		public function XModel(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		/**
		 * When initialization is complete, we connect to the local database
		 */
		[PostConstruct]
		public function postConstruct():void
		{
			delegate.connect(DB_NAME);
			delegate.addEventListener(ORMError.CONNECTION_FAILED, onORMErrorHandler)
			delegate.addEventListener(ORMError.DATA_ACCESS_ERROR, onORMErrorHandler)
		}
		
		private function onORMErrorHandler(e:ORMError):void
		{
			dispatchEvent(new AppErrorEvent(AppErrorEvent.SQLITE_ERROR, e.text));
		}
		
		/**
		 * Save a single favoruite.
		 * When the favoruite is added or updated in the db, we dispatch
		 * the updated event, to trigger data binding 
		 *
		 * @param favoruite The new data
		 */
		public function saveFavorite(value:XFavoriteVO):void
		{
			delegate.saveItem(value);
			dispatchEvent(new Event(FAVORITE_LIST_UPDATED));
		}
		
		/**
		 *
		 * 
		 */
		public function saveVote(value:XVoteVO):void
		{
			delegate.saveItem(value);
			dispatchEvent(new Event(VOTE_LIST_UPDATED));
		}
		
		/**
		 * Remove a single favoruite.
		 * When the favoruite is removed from the db, we dispatch
		 * the updated event, to trigger data binding 
		 *
		 * @param favoruite The favoruite to be removed
		 */
		public function removeFavorite(value:XFavoriteVO):void
		{
			delegate.removeItem(value);
			dispatchEvent(new Event(FAVORITE_LIST_UPDATED));
		}
		
		/**
		 * 
		 * 
		 */
		public function removeVote(value:XVoteVO):void
		{
			delegate.removeItem(value);
			dispatchEvent(new Event(VOTE_LIST_UPDATED));
		}
		
		/**
		 * Reset and delete all data from db, then dispatch
		 * the updated event, to trigger data binding of 
		 */
		public function resetFavorite():void
		{
			delegate.removeAll(XFavoriteVO);
			dispatchEvent(new Event(FAVORITE_LIST_UPDATED));
		}
		
		
		/**
		 * Reset and delete all data from db, then dispatch
		 * the updated event, to trigger data binding of 
		 */
		public function resetVote():void
		{
			delegate.removeAll(XVoteVO);
			dispatchEvent(new Event(VOTE_LIST_UPDATED));
		}
		/**
		 * The full list of favoruites
		 */
		[Bindable (event="favoriteListUpdated")]
		public function get favoriteList():ArrayCollection
		{
			return delegate.loadAll(XFavoriteVO);
		}
		
		/**
		 * The full list of votes
		 */
		[Bindable (event="voteListUpdated")]
		public function get voteList():ArrayCollection
		{
			return delegate.loadAll(XVoteVO);
		}
		
		/**
		 * This funciton will not be used as per teh XGames requirement, 
		 * however this may be required for any future requirements
		 */
		public function set favoriteList(favorites:ArrayCollection):void
		{
			for each (var favorite:XFavoriteVO in favorites)
			{
				delegate.saveItem(favorite);
			}
			dispatchEvent(new Event(FAVORITE_LIST_UPDATED));
		}
		
		/**
		 * This funciton will not be used as per teh XGames requirement, 
		 * however this may be required for any future requirements
		 */
		public function set voteList(value:ArrayCollection):void
		{
			for each (var vote:XVoteVO in value)
			{
				delegate.saveItem(vote);
			}
			dispatchEvent(new Event(VOTE_LIST_UPDATED));
		}
	}
}