package com.espn.mobile.xgames.utilities
{
	import com.espn.mobile.xgames.constants.AppConstants;
	import com.espn.mobile.xgames.model.AppConfigModel;
	
	import flash.text.ReturnKeyLabel;
	
	import spark.effects.Scale;

	public class ImageCombinerUtility
	{
	/*	[Inject]
		public var appConfigModel:AppConfigModel;*/
		
		public static var IMAGE_HOST:String;
		
		public function ImageCombinerUtility()
		{
		}
		
		/**
		 * Function to get combiner image from servlet.
		 */
		
		public static function getCombinerImage(imgPath:String,imgWidth:int,imgHeight:int,imgScale:String = null):String{
			if(imgPath)
			{
				if(!isAbsolutePath(imgPath)){
					imgPath = imgPath.split(IMAGE_HOST)[1];	
				}
				if(imgScale != null)
					return (AppConstants.COMBINER_SERVLET_PATH + "img=" + imgPath + "&w=" + imgWidth + "&h=" + imgHeight + "&scale=crop");
				else 
					return (AppConstants.COMBINER_SERVLET_PATH + "img=" + imgPath + "&w=" + imgWidth + "&h=" + imgHeight);	
			}
			else 
				return "";
		}
		
		/**
		 * Function to check whether image is having absolute path or not.
		 */
		
		public static function isAbsolutePath(imgPath:String):Boolean{
			if(imgPath.indexOf("http") == -1){
				return true;
			}
			return false;
		}
	}
}