package com.espn.mobile.xgames.model
{
	import com.espn.mobile.xgames.constants.AppConstants;
	import com.espn.mobile.xgames.events.AppErrorEvent;
	import com.espn.mobile.xgames.events.ArticleDataEvent;
	import com.espn.mobile.xgames.model.vo.ArticleVO;
	import com.espn.mobile.xgames.service.BaseService;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;

	
	public class ArticleModel extends BaseService
	{
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
			
		[Inject]
		public var appConfigModel:AppConfigModel;
		
		[Bindable]
		public var articleVO:ArticleVO;
		
		public function ArticleModel()
		{
			
		}
		
		public function getArticleById(id:String):void 
		{
			var serviceURL:String = appConfigModel.getModuleServicePath(AppConstants.ARTICLE);
			serviceURL = serviceURL.replace("{id}", id );
			//serviceURL = "http://xgames.qa.espn.go.com" + id + "?xhr=1";
			read(serviceURL);
		}
		
		/**
		 *onResult handler for the JSON service call
		 */
		
		override protected function onResult(event:Event):void
		{
			try
			{
				super.onResult(event);
				
				var obj:Object = JSON.parse(event.target.data.toString());
				
				articleVO = new ArticleVO();
				var articleObject:Object = obj.clusters[0].data;
				
				if(articleObject) {
					if(articleObject.body) {
						articleVO.body = articleObject.body;
					}
					
					if(articleObject.author) {
						articleVO.author = articleObject.author.name;
					}
					
					if(articleObject.date) {
						articleVO.date = articleObject.date;
					}
					
					if(articleObject.headline) {
						articleVO.headline = articleObject.headline;
					}
					
					if(articleObject.photos) {
						articleVO.photos = articleObject.photos;
					}
				}
				dispatchEvent(new ArticleDataEvent(ArticleDataEvent.ARTICLE_DATA_LOADED));
			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
			
		}
		
		/**
		 *onResult handler for the JSON service call
		 */
		protected function onFault(event:FaultEvent):void
		{
			
		}
		
	}
}