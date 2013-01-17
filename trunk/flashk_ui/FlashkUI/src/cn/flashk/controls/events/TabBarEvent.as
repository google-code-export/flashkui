package cn.flashk.controls.events
{
    import flash.events.Event;

    public class TabBarEvent extends Event
    {
        public static const TAB_SWITCH:String = "tabSwicth";
		
        private var _newIndex:uint;
        
        public function TabBarEvent(eventName:String,index:uint)
        {
            _newIndex = index;
            super(eventName);
        }

        public function get newIndex():uint
        {
            return _newIndex;
        }

    }
}