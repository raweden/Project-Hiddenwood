The Core UI is a collection of class and interfaces written in ActionScript 3.0 these classes provides a MVC based foundation for developing web based applications.

The framework provides a basic set of view components and controllers that are designed for creating rich and modern application for the web and any flash enabled device. 
One of the key concepts of the framework is that a application developed on top of the Core UI can be used as a stand-alone application or in a multi-tasking environment with a numbers of other application based on the same api. This can be done by using a custom main application which have no dependencies of classes which don't support of being shared between different applications running UIApplication is one example of those. In the near feature i create a wiki where i will go into feather detail about this.

Another key features is that core UI is built upon delegation or callback methods acting as delegation, which supports greater flexibility than the frameworks currently available to the flash platform. UICollectionView (a kind of tile list) for example is using a callback method which provides the cell render when, the cell is about to be visible in the list rather than using a universal model (ArrayCollection) used by many flex components. Using this approach a custom cell render could be provided easily and the list is no longer bound to certain data model.

### Other Key features

* Dragging data between view's and application using UIDraggingSession (se.raweden.ui.desktop.).

### Dependencies

* Currently dependent on the caurina tweening engine.

### Feature Plans

* Make most view components customizable with the use of Bitmaps and bitmap sheets.
* Complete the Core Tween framework to be used as the animation engine.
* Commit the ui prototypes of all controls with a default skin and look.

### Classes under development

view package (se.raweden.ui.view)
> UIActivityIndicator	- basic spinning preloader.
> UIAlertView		- alert dialog.
> UIButton		- basic and customizable button.
> UIButtonGroup		- controller for a group toggle buttons.
> UIKnob			- knob control.
> UINavigationBar		- Navigation bar.
> UIPageControl		- Paging control and indicator.
> UIProgressView		- basic preloaded bar (available as alpha release, final implementation will be developed in near feature).
> UIRating		- rating control, simular to Appstore and itunes.
> UIScroller		- scrollbar component and indicator.
> UIScrollView		- scrollview width bounce, paging, throwing and zooming.
> UISegmentedControl	- button bar.
> UISlider		- basic slider.
> UIStepper		- numeric stepper.
> UISwitch		- on/off toggle, similar to iOS.
> UITabBar		- tab bar.
> UIText			- scrollable text view.
> UITextField		- input textfield for text, password and more.
> UIToolbar		- basic toolbar.
> UICollectionView	- icon/tile list component.

desktop package (se.raweden.ui.desktop)
> UIDraggingSession	- api for dragging data between view's and application represented by images, (available as alpha as this is a part of UIView).
> UIPasteboard		- data holder for dragging,copy and paste internally between and in app, needs to be rebuilt to integrate with the flash own Clipboard api.
