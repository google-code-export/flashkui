package cn.flashk.controls.managers
{
	import cn.flashk.controls.support.ColorConversion;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;

	public class SkinLoader
	{
		public static const SKIN_LOADED:String = "skinLoaded";
		public static const eventDispatcher:EventDispatcher = new EventDispatcher();
		
		public static var isSelfFile:Boolean = false;
		private static var ldr:Loader;
		
		public function SkinLoader()
		{
		}
		public static function loadSkinFile(path:String,bytes:ByteArray=null,context:LoaderContext=null):void{
			ldr = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE,initSkinSet);
            if(bytes== null)
            {
			    ldr.load(new URLRequest(path),context);
            }else
            {
                ldr.loadBytes(bytes,context);
            }
		}
		
		public static function getSpriteFromSkinFile(name:String):Sprite
		{
			var classRef:Class;
			try{
				if(isSelfFile == false){
					classRef =  ldr.contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
				}else
				{
					classRef = getDefinitionByName(name) as Class
				}
				return new classRef() as Sprite;
			}catch(e:Error){
				
			}
			return null;
		}
		
		public static function getClassFromSkinFile(name:String):Class{
			try{
				if(isSelfFile == false){
					return ldr.contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
				}
				return getDefinitionByName(name) as Class;
			}catch(e:Error){
				
			}
			return null;
		}
		
		public static function getBitmapData(name:String):BitmapData{
			var classRef:Class;
			try{
				if(isSelfFile == false){
					classRef =  ldr.contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
				}else{
					classRef =  getDefinitionByName(name) as Class;
				}
				var dis:DisplayObject = new classRef() as DisplayObject;
				var bd:BitmapData = new BitmapData(dis.width,dis.height,true,0);
				bd.draw(dis);
				return bd;
			}catch(e:Error){
				
			}
			return null;
		}
		
		public static function setSkinStyle(xml:XML):void{
			DefaultStyle.buttonOutTextColor = xml.buttonTextColor;
			DefaultStyle.buttonOverTextColor = xml.buttonOverTextColor;
			DefaultStyle.buttonDownTextColor = xml.buttonPressTextColor;
			DefaultStyle.menuBackgroundColor = xml.menuBackgroundColor;
			SkinThemeColor.itemOverTextColor = ColorConversion.transformWebColor(xml.itemOverTextColor);
			SkinThemeColor.border = ColorConversion.transformWebColor(xml.borderColor);
		}
		
		protected static function initSkinSet(event:Event):void
		{
            initSWFSkinSet(ldr);
        }
		
        public static function initSWFSkinSet(loader:Loader):void
        {
			SkinManager.isUseDefaultSkin = false;
            ldr = loader;
			var obj:Object = loader.content;
			var xml:XML = obj.skinSet as XML;
			setSkinStyle(xml);
			eventDispatcher.dispatchEvent(new Event(SKIN_LOADED));
			isSelfFile = false;
		}
		
	}
}