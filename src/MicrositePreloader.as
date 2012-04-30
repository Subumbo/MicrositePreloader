package {
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import org.assetloader.AssetLoader;
	import org.assetloader.base.AssetType;
	import org.assetloader.core.ILoader;
	import org.assetloader.signals.LoaderSignal;
	
	public class MicrositePreloader extends Sprite {
		
		private var _loader:AssetLoader;
		
		public function MicrositePreloader() {
			var configURL:String = 'config.xml';
			_loader = new AssetLoader();
			_loader.add('config', new URLRequest('config.xml'), AssetType.XML);
			_loader.onChildComplete.addOnce(configLoaded);
			_loader.start();
			
		}
		
		/**
		 * callback for loader when config data is ready;
		 */		
		protected function configLoaded(signal:LoaderSignal, child:ILoader):void {
			var config:XML = XML(child.data);
			var locale:String = config.item.(@key == 'locale');
			var root:String = config.item.(@key == 'root');
			_loader.add('copy', new URLRequest(root + '/xml/' + locale + '_copy.xml'), AssetType.XML);
			_loader.add('assets', new URLRequest(root + '/xml/' + locale + '_assets.xml'), AssetType.XML);
			_loader.onChildComplete.add(dataLoaded);
			_loader.start();
			
			trace("LOADING " + _loader);
		}
		
		private function dataLoaded(signal:LoaderSignal, data:Dictionary):void {
			trace('LOADED');
		}
	}
}