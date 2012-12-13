//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.model
{
	import com.espn.mobile.xgames.service.BaseService;

	/**
	 * Model to store all data related to the Facebook Authentication.
	 */	
	public class FacebookModel extends BaseService
	{
		private var _authInfo:Object;
		
		/**
		 * Class constructor.
		 */	
		public function FacebookModel()
		{
		}
		
		/**
		 * Setter for authentication information.
		 */	
		public function set authInfo(obj:Object):void
		{
			_authInfo = obj;
		}
		
		/**
		 * Getter for authentication information.
		 */	
		public function get authInfo():Object
		{
			return _authInfo;
		}
		
	}
}