package se.raweden.ui
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import se.raweden.ui.view.UIView;
	
	/**
	 * Dispatchen when some of the view controller's attributes is changed.
	 */
	[Event(name="change", type="flash.events.Event")]
	
	/**
	 * The <code>UIViewController</code> class provides the fundation for the view-manager model for a application.
	 * 
	 * <p>The basic view controlelr class supports the presentation of associated views in addition to basic support
	 * for managing modal views. The controller is designed to manage a self-contained unit of content.</p>
	 * 
	 * <p>Subclasses such as NavigationController and TabBarController provide additional behavior for managing
	 * complex hierarchies of view controllers and views.</p>
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public class UIViewController extends EventDispatcher{
		
		private var _title:String;
		// Related view controllers.
		private var _modalViewController:UIViewController;
		private var _parentViewController:UIViewController;
		private var _children:Array;
		// Related items.
		
		// Related views.
		private var _view:UIView;
		// Related to modal presentation
		private var _modalPresentation:String;
		private var _modalTransition:String;
		private var _session:UIModalSession;			// holds the current modal session if any.
		
		/**
		 * Constuctor.
		 */
		public function UIViewController(){
			super();
			
			// Setting default modal style.
			_modalPresentation = UIModalPresentation.FullScreen;
			_modalTransition = UIModalTransition.CoverVertical;
		}
		
		//------------------------------------
		// Manage the view
		//------------------------------------
		
		/**
		 * A localized string that represents the title of the view that this controller manages.
		 * 
		 * <p>This properity should be set to a human-readble string that represents the view to the user.
		 * If the receiver is a navigation controller, the default is the top view controller's title.</p>
		 * 
		 * @default <code>null</code>
		 */
		public function set title(value:String):void{
			if(_title != value){
				_title = value;
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		// returns the value of the title attribute.
		public function get title():String{
			return _title;
		}
		
		/**
		 * The view stored in this property represents the view for this view controller.
		 * 
		 * <p>The default implementation of this properity is null, 
		 * but other subclasses may by default set this value to a view.</p>
		 * 
		 * @default <code>null</code>
		 */
		public function set view(value:UIView):void{
			/*
			if(_view){
				_view.removeEventListener(Event.ADDED_TO_STAGE,onViewWillAppear);
				_view.removeEventListener(Event.ADDED_TO_STAGE,onViewWillDisappear);
			}
			*/
			_view = value;
			/*
			if(_view){
				_view.addEventListener(Event.ADDED_TO_STAGE,onViewWillAppear);
				_view.addEventListener(Event.ADDED_TO_STAGE,onViewWillDisappear);
			}
			*/
			
		}
		// returns the value of the view attribute.
		public function get view():UIView{
			return _view;
		}
		
		//------------------------------------
		// Getting related Controllers.
		//------------------------------------
		
		/** 
		 * The controller that is activly presented as a modal controller for this <code>UIViewController</code> instance.
		 * 
		 * <p>Typically, a modal view is used to present an edit page or additional detals of a model object.
		 * The modal view is optionally displayed using a vertical sheet transition.</p>
		 */
		public function get modalViewController():UIViewController{
			return _modalViewController;
		}
		
		/**
		 * The parent of the current view controller.
		 * 
		 * <p>Parent view controller are relevant in navigation, tab bar, and modal view controller hierarchies.
		 * In each of these hierarchies, the parent is the object responsible for displaying the current view controller.
		 * If you are using a view controller as a standalone object-that is, not as part of a view controller hierarchy-the
		 * Value in this property is null.</p>
		 */
		public function get parentViewController():UIViewController{
			return _parentViewController;
		}
		
		//------------------------------------
		// Managing Child View Controllers
		//------------------------------------
		
		/**
		 * 
		 */
		protected function get childViewControllers():Array{
			return _children ? _children.concat() : null;
		}
		
		/**
		 * 
		 */
		protected function addChild(viewController:UIViewController):void{
			if(viewController && !_children){
				_children = new Array();
			}
			if(_children.indexOf(viewController) == -1){
				_children.push(viewController);
				if(viewController.parentViewController){
					viewController.parentViewController.removeChild(viewController);
				}
				viewController._parentViewController = this;
			}
		}
		
		/**
		 * 
		 */
		protected function removeChild(viewController:UIViewController):void{
			var index:int = _children.indexOf(viewController);
			if(index != -1){
				_children.splice(index,1);
				viewController._parentViewController = null;
			}
		}
		
		//------------------------------------
		// Configuring and presenting modal views.
		//------------------------------------
		
		/**
		 * The presentation style used when this controller is presented modaly.
		 * 
		 * <p>The presentation style determines how this controller is resized 
		 * and positoned when presented as modal controller on the screen.</p>
		 * 
		 * @default <code>UIModalPresentation.FullScreen</code>
		 * @see UIModalPresentation
		 */
		public function set modalPresentation(value:String):void{
			_modalPresentation = value;
		}
		// returns the value of the modalPresentation attribute.
		public function get modalPresentation():String{
			return _modalPresentation;
		}
		
		/**
		 * Specifies the transiton style used when this view controller is presented modaly.
		 * 
		 * <p>This property determines how the view is presented to the user.</p>
		 * 
		 * @default <code>UIModalTransition.CoverVertical</code> 
		 * @see UIModalTransition
		 */
		public function set modalTransition(value:String):void{
			_modalTransition = value;
		}
		// returns the value of the modalTransition attribute.
		public function get modalTransition():String{
			return _modalTransition;
		}
		
		/**
		 * Presents a modal view managed by the <code>viewController</code> to the user.
		 * 
		 * <p>Typically, a modal view is presented to provide a edit page or to show
		 * additional details about a object.</p>
		 */
		public final function presentModalViewController(viewController:UIViewController):void{
			if(_modalViewController == viewController)return;
			if(!_session){
				var animated:Boolean = view ? view.stage != null : false;
				_session = new UIModalSession(this,viewController);	
				_session.present();
			}else{
				dismissModalViewController();
				// this impl will not work.
				_session.dismiss(viewController);
				_session = null;
			}
			_modalViewController = viewController;
			viewController._parentViewController = this;
		}
		
		/**
		 * Dismiss the modal view that where presented on this UIViewController.
		 * 
		 * <p></p>
		 */
		public final function dismissModalViewController():void{
			if(_session){
				var animated:Boolean = view ? view.stage != null : false;
				_session.dismiss();
				_session = null;
				_modalViewController._parentViewController = null;
				_modalViewController = null;
			}
		}
		
	}
}

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.PerspectiveProjection;
import flash.geom.Point;

import se.raweden.motion.Tween;
import se.raweden.ui.UIModalPresentation;
import se.raweden.ui.UIModalTransition;
import se.raweden.ui.UIViewController;
import se.raweden.ui.view.UIView;
import se.raweden.utils.IDisposable;

/**
 * UIModalSession Manages a modal presentation of another view controller.
 */
class UIModalSession implements IDisposable{
	
	private var _transition:ITransition;
	private var presentation:String;
	private var transition:String;
	private var m_width:int;
	private var m_height:int;
	// controllers.
	private var parentController:UIViewController;
	private var modalController:UIViewController;
	
	// used when dismissed.
	private var replacement:UIViewController;
	
	private var m_blocker:Sprite;
	
	/**
	 * 
	 */
	public function UIModalSession(parentController:UIViewController,modalController:UIViewController){
		// setting reference.
		this.parentController = parentController;
		this.modalController = modalController;
		// getting the presentation style to use.
		if(modalController.modalPresentation != UIModalPresentation.Current){
			presentation = modalController.modalPresentation;
		}else if(parentController.modalPresentation != UIModalPresentation.Current){
			presentation = parentController.modalPresentation;
		}else{
			presentation = UIModalPresentation.FullScreen;
		}
		// getting the transtion style to be used.
		transition = modalController.modalTransition;
		
		// setting state.
		m_width = modalController.view.width;
		m_height = modalController.view.height;
		// adding listner to parent resize.
		parentController.view.addEventListener(Event.RESIZE,onParentViewResize);
	}
	
	//------------------------------------
	// Session Presenting.
	//------------------------------------
	
	/**
	 * 
	 */
	public function present():void{
		var parent:DisplayObjectContainer = parentController.view;
		var view:UIView = modalController.view;
		switch(transition){
			case UIModalTransition.CoverVertical:{
				_transition = new CoverVertical();
				_transition.present(parentController.view,modalController.view);
			}break;
			case UIModalTransition.CrossDissolve:{
				_transition = new CrossDissolve();
				_transition.present(parentController.view,modalController.view);
				_transition.resize(parent.width,parent.height);
				_transition.present(parent,view);
			}break;
			case UIModalTransition.Cubic:{
				parent = parent.parent;
				_transition = new CubeTransition();
				_transition.resize(parent.width,parent.height);
				_transition.present(parentController.view,modalController.view);
			}break;
		}
		render();
	}

	//------------------------------------
	// Session Dismissal.
	//------------------------------------
	
	/**
	 * Dismisses the session.
	 * @param replacement A optional replacement for this modal view.
	 */
	public function dismiss(replacement:UIViewController = null):void{
		var view:UIView = modalController.view;
		if(_transition){
			_transition.dismiss();
			return;
		}
		switch(transition){
			case UIModalTransition.CoverVertical:{
				_transition.dismiss();
			}break;
			case UIModalTransition.CrossDissolve:{
				_transition.dismiss();
			}break;
			case UIModalTransition.Cubic:{
				_transition.dismiss();
			}break;
		}
		this.replacement = replacement;
		// we need to dismiss that too.
		if(modalController.modalViewController){
			modalController.dismissModalViewController();
		}
	}

	// triggerd after the dismiss animation is complete
	private function onDismissComplete():void{
		if(replacement){
			parentController.presentModalViewController(replacement);
		}
		this.dispose();
	}
		
	//------------------------------------
	// Responding to resize.
	//------------------------------------
	
	// responds to the parent resize.
	private function onParentViewResize(e:Event):void{
		render();
	}
	
	// positionates and/or resizes the view presented modaly.
	private function render():void{
		var w:int = parentController.view.width;
		var h:int = parentController.view.height;
		trace("render UIModalSession Resize"); 
		var view:UIView = modalController.view;
		switch(presentation){
			// applying modal fullsceen presentation style.
			case UIModalPresentation.FullScreen:{
				view.width = w;
				view.height = h;
			}break;
			// applying modal form-like presentation style.
			case UIModalPresentation.Form:{
				// resizing or centering the modal view horizontal.
				if(m_width > w){
					view.width = w;
					if(view.x != 0)
						view.x = 0;
				}else{
					view.x = (w-view.width)*0.5;
				}
				// resizing or centering the modal view verticaly.
				if(m_height > h){
					view.height = h;
					if(view.y != 0)
						view.y = 0;
				}else{
					view.y = (h-view.height)*0.5;
				}
				// resizing the dimming block.
				if(m_blocker){
					m_blocker.width = w;
					m_blocker.height = h;	
				}
			}break;
			// applying modal page-like presentation style.
			case UIModalPresentation.Page:{
				// resizing or centering the modal view horizontal.
				if(m_width > w){
					view.width = w;
					if(view.x != 0)
						view.x = 0;
				}else{
					view.x = (w-m_width)*0.5;
				}
				// resizing or centering the modal view verticaly.
				view.height = h;
				if(view.y != 0)
					view.y = 0;
				// resizing the dimming block.
				if(m_blocker){
					m_blocker.width = w;
					m_blocker.height = h;	
				}
			}break;
		}
	}
	
	//------------------------------------
	// Handeling blocker.
	//------------------------------------
	
	// adds a blocking background this should only be used with presentation style UIModalPresentation.Page or UIModalPresentation.Form
	private function addBlocker():Sprite{
		if(m_blocker)return m_blocker;
		// creates a sprite to act as a blocker.
		m_blocker = new Sprite();
		m_blocker.graphics.beginFill(0x2D2D2D);
		m_blocker.graphics.drawRect(0,0,100,100);
		m_blocker.graphics.endFill();
		parentController.view.addChild(m_blocker);
		m_blocker.addEventListener(MouseEvent.CLICK,onBlockerClick);
		return m_blocker;
	}
		
	// repsonds to the click on the blocking background.
	private function onBlockerClick(e:Event):void{
		parentController.dismissModalViewController();
		m_blocker.removeEventListener(MouseEvent.CLICK,onBlockerClick);
	}
	
	//------------------------------------
	// Deconstruction
	//------------------------------------
	
	// disposes the session object.
	public function dispose():void{
		parentController.view.removeEventListener(Event.RESIZE,onParentViewResize);
		
		if(modalController.view.parent){
			modalController.view.parent.removeChild(modalController.view);
		}
		
		modalController = null;
		parentController = null;
		replacement = null;
		if(m_blocker){
			m_blocker.removeEventListener(MouseEvent.CLICK,onBlockerClick);
			removeBlocker();
		}
	}
	
	// removes the blocking background if any where created.
	private function removeBlocker():void{
		if(!m_blocker)return;
		m_blocker.graphics.clear();
		if(m_blocker.parent)
			m_blocker.parent.removeChild(m_blocker);
		m_blocker = null;
	}
	
}

interface ITransition{
	
	function present(parentView:DisplayObjectContainer,modalView:DisplayObjectContainer):void;
	
	function dismiss():void;
	
	function resize(width:Number,height:Number):void;
	
}

class CoverVertical implements ITransition{
	
	private var m_parentView:DisplayObjectContainer;
	private var m_modalView:DisplayObjectContainer;
	
	public function present(parentView:DisplayObjectContainer,modalView:DisplayObjectContainer):void{
		modalView.y = parentView.height;
		Tween.to(modalView,0.7,{y:0}).start();
		//Tweener.addTween(modalView,{time:0.7,y:0});
		parentView.addChild(modalView);
		m_parentView = parentView;
		m_modalView = modalView;
	}
	
	public function dismiss():void{
		Tween.to(m_modalView,0.7,{y:m_parentView.height},{onComplete:onDismissComplete}).start();	
	}
	
	public function resize(width:Number,height:Number):void{
		
	}
	
	private function onDismissComplete():void{
		
	}
	
}

class CrossDissolve implements ITransition{
	
	private var m_parentView:DisplayObjectContainer;
	private var m_modalView:DisplayObjectContainer;
	
	public function CrossDissolve(){
		
	}
	
	public function dismiss():void{
		// TODO Auto Generated method stub
		Tween.to(m_modalView,0.25,{alpha:0},{onComplete:onDismissComplete}).start();
	}
	/*
		if(presentation == UIModalPresentation.Page || presentation == UIModalPresentation.Form){
			Tweener.addTween(m_blocker,{time:0.4,alpha:0,delay:0.5,onComplete:onDismissComplete});
			Tweener.addTween(view,{time:0.7,alpha:0});
		}else{
			Tweener.addTween(view,{time:0.7,alpha:0,onComplete:onDismissComplete});
		}
	*/
	
	public function present(parentView:DisplayObjectContainer, modalView:DisplayObjectContainer):void{
				
		// TODO Auto Generated method stub
		modalView.y = 0;
		modalView.x = 0;
		modalView.alpha = 0;
		parentView.addChild(modalView);
		Tween.to(modalView,0.25,{alpha:1}).start();		
		m_parentView = parentView;
		m_modalView = modalView;
	}
	
	/*
		view.alpha = 0;
		if(presentation == UIModalPresentation.Page || presentation == UIModalPresentation.Form){
			var blocker:Sprite = addBlocker();
			blocker.alpha = 0;
			Tweener.addTween(blocker,{time:0.4,alpha:0.75});
			Tweener.addTween(view,{time:0.7,alpha:1,delay:0.2});
		}else{
			Tweener.addTween(view,{time:0.7,alpha:1});
		}
		parentController.view.addChild(view);
	*/
	
	public function resize(width:Number, height:Number):void{
		// TODO Auto Generated method stub
		m_modalView.width = width;
		m_modalView.height = height;
	}	
	
	private function onDismissComplete():void{
		if(m_parentView.contains(m_modalView)){
			m_modalView.parent.removeChild(m_modalView);
		}
		m_modalView.alpha = 1;
	}
	
}

class CubeTransition implements ITransition{
	
	private var m_parentView:DisplayObjectContainer;
	private var m_modalView:DisplayObjectContainer;
	
	private var parent:DisplayObjectContainer;
	private var main:Sprite;
	private var con1:Sprite;
	private var con2:Sprite;
	// 
	private var projection:PerspectiveProjection;
	private var _width:int = 480;
	private var _height:int = 320;
	
	private var _progress:Number = 1;
	private var _reverse:Boolean = false;
	private var _active:Boolean = false;
	
	/**
	 * 
	 */
	private function init():void{
		if(main)return;
		// Setting up main container.
		main = new Sprite();
		main.rotationY = 90;
		main.x = _width;
		projection = new PerspectiveProjection();
		projection.projectionCenter = new Point(_width/2,_height/2);
		main.transform.perspectiveProjection = projection;
		// Setting up container to hold the child.
		con1 = new Sprite();
		main.addChild(con1);
		con2 = new Sprite();
		con2.rotationY = -90;
		main.addChild(con2);
	}
	
	/**
	 * 
	 */
	public function present(parentView:DisplayObjectContainer,modalView:DisplayObjectContainer):void{
		var parent:DisplayObjectContainer = parentView.parent;
		init();
		parent.addChild(main);
		con1.addChild(modalView);
		con2.addChild(parentView);
		con1.scaleX - 1.0;
		if(!_active){
			main.addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		_reverse = false;
		this.parent = parent;
		
		m_parentView = parentView;
		m_modalView = modalView;
	}
	
	/**
	 * 
	 */
	public function dismiss():void{
		// TODO Auto Generated method stub
		_reverse = true;
		if(!_active){
			main.addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
	}
	
	/**
	 * 
	 */
	private function onComplete():void{
		main.parent.removeChild(main);
		parent.addChild(m_parentView);
	}
	
	/**
	 * 
	 */
	public function resize(width:Number,height:Number):void{
		_width = width;
		_height = height;
		if(main){
			projection.projectionCenter = new Point(_width/2,_height/2);
			main.transform.perspectiveProjection = projection;
		}
	}
	
	/**
	 * 
	 */
	private function onEnterFrame(e:Event):void{
		// 
		if(_reverse){
			_progress += 0.01;
		}else{
			_progress -= 0.01;
		}
		
		if(_progress >= 0){
			main.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			_active = false;
			_progress = 1;
			trace("did deactive");
			//onComplete();
		}else if(_progress <= 1){
			main.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			_active = false;
			_progress = 0;
			trace("did deactive");
			onComplete();
		}
		// 
		main.rotationY = -(90*_progress);
		main.x = Math.round(_width*_progress);
		// Changes 
		if(_progress < 0.5 && main.getChildIndex(con1) != 0){
			main.setChildIndex(con1,0);
		}else if(_progress > 0.5 && main.getChildIndex(con2) != 0){
			main.setChildIndex(con2,0);
		}
	}	
}
