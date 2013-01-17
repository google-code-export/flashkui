package cn.flashk.controls 
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.getDefinitionByName;
	
	import cn.flashk.controls.support.UIComponent;

	/**
	 * GraphicSkinButton 是一个轻量的自定义皮肤按钮类，用来显示非文本按钮
	 * @author flashk
	 */
	public class GraphicSkinButton extends UIComponent
	{
		protected var _gbtn:SimpleButton;
		protected var _overSoundLink:String = "";
		protected var _clickSoundLink:String = "";
		protected var _soundVolume:Number = 0.8;
		protected var _soundPanning:Number = 0;
		protected var _soundChannel:SoundChannel;
		protected var _isSoundLinkIsFile:Boolean = false;
		protected var _soundContext:SoundLoaderContext;
		
		public function GraphicSkinButton() 
		{
			super();
			if(this.toString() == "[object GraphicSkinButton]")
			{
				_gbtn = new SimpleButton();
				_gbtn.useHandCursor = false;
			}
		}

		public function get soundContext():SoundLoaderContext
		{
			return _soundContext;
		}

		public function set soundContext(value:SoundLoaderContext):void
		{
			_soundContext = value;
		}

		public function get isSoundLinkIsFile():Boolean
		{
			return _isSoundLinkIsFile;
		}

		public function set isSoundLinkIsFile(value:Boolean):void
		{
			_isSoundLinkIsFile = value;
		}

		public function get soundPanning():Number
		{
			return _soundPanning;
		}

		public function set soundPanning(value:Number):void
		{
			_soundPanning = value;
		}

		public function get soundVolume():Number
		{
			return _soundVolume;
		}

		public function set soundVolume(value:Number):void
		{
			_soundVolume = value;
		}

		public function get clickSoundLink():String
		{
			return _clickSoundLink;
		}

		public function set clickSoundLink(value:String):void
		{
			_clickSoundLink = value;
			if(_clickSoundLink != "")
			{
				_gbtn.addEventListener(MouseEvent.CLICK,playClickSound);
			}else
			{
				_gbtn.removeEventListener(MouseEvent.CLICK,playClickSound);
			}
		}
		
		protected function playClickSound(event:MouseEvent):void
		{
			playLinkSound(_clickSoundLink);
		}
		
		public function get overSoundLink():String
		{
			return _overSoundLink;
		}
		
		protected function playLinkSound(linkName:String):void
		{
			if(_isSoundLinkIsFile == false)
			{
				var classRef:Class = getDefinitionByName(linkName) as Class;
				var sound:Sound = new classRef() as Sound;
			}else
			{
				sound = new Sound();
				sound.load(new URLRequest(linkName),_soundContext);
			}
			_soundChannel = sound.play();
			if(_soundChannel)
			{
				_soundChannel.soundTransform = new SoundTransform(_soundVolume,_soundPanning);
			}
		}

		public function set overSoundLink(value:String):void
		{
			_overSoundLink = value;
			if(_overSoundLink != "")
			{
				_gbtn.addEventListener(MouseEvent.MOUSE_OVER,playOverSound);
			}else
			{
				_gbtn.removeEventListener(MouseEvent.MOUSE_OVER,playOverSound);
			}
		}
		
		protected function playOverSound(event:MouseEvent):void
		{
			playLinkSound(_overSoundLink);
		}
		
		public function set downState(value:DisplayObject):void
		{
			_gbtn.downState = value;
		}
		
		public function get downState():DisplayObject
		{
			return _gbtn.downState;
		}
		
		public function set hitTestState(value:DisplayObject):void
		{
			_gbtn.hitTestState = value;
		}
		
		public function get hitTestState():DisplayObject
		{
			return _gbtn.hitTestState;
		}
		
		public function set overState(value:DisplayObject):void
		{
			_gbtn.overState = value;
		}
		
		public function get overState():DisplayObject
		{
			return _gbtn.overState;
		}
		
		public function set upState(value:DisplayObject):void
		{
			_gbtn.upState = value;
		}
		
		public function get upState():DisplayObject
		{
			return _gbtn.upState;
		}
		
	}
}