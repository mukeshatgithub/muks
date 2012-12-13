//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.managers
{
	
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	[ResourceBundle("language")]
	public class LanguageManager implements ILanguageManager
	{
		
		private static var resourceManager:IResourceManager;
		
		
		/**
		 *
		 * Get  
		 * 
		 * @param param1 Describe param1 here.
		 * @param param2 Describe param2 here.
		 * 
		 * @return A value of <code>true</code> means this; 
		 * <code>false</code> means that.
		 *
		 */
		public function getKey(key:String):String
		{
			if (!resourceManager) resourceManager = ResourceManager.getInstance();
			var value:String = resourceManager.getString("language", key);
			return value;
		}
		
	}
}