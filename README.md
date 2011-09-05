
# Core UI a ActionScript 3.0 Framework

**Core UI** is not yet another UI framework. It's a collection of classes which focus on User Experience and advanced web applications.  
The collection contains a basic set of view's and controls and also provides a environment in which a application can work as stand-alone or together with others; for example in a modular multi-tasking platform [on which a wiki exists on the subject here](https://github.com/raweden/Core-UI/wiki/Multi-tasking-and-multi-application-platform).  
The core of the framework is developed to promote **MVC** architecture and is heavily based on delegation and interfaces and is therefor more flexible than other ActionScript frameworks.

This framework is not a port of iOS's UIKit, but *may* share some features.

### Core Classes

#### Views
The `Core UI` provides a basic set of views and components. All views inherits from the `UIView` class, which provides a base for managing content displayed on screen, to ensure minimal performance usage a special but simple drawing cycle is implemented. Among with many other classes in the Core UI you find `UIScrollView` which is a advanced view for scrolling and zooming content. These is some of the highlights of the Core UI framework.

#### Drag and Drop
The `UIView` is integrated with `UIDraggingSession` which together with `UIPasteboard` provides a interface for dragging data and items internally between views, modules and applications. These classes focuses on making  drag 'n drop a smooth user experience with features like inline destination preview, feedback indicators, easing and animation not only for slide back to source if drop where rejected by the destination.

#### Documents
The `Core UI` provides classes for developing document based applications, the `UIDocument` which is base to all document's data model from which you should subclass for fit your document's specifications. Together with `UIUndoManager` provides as a default property of `UIDocument` undo and redo features can easily be provided. [Learn more about Document based applications](https://github.com/raweden/Core-UI/wiki/Document-Based-Application)

### Future Directions
* Add support for customization with use of `BitmapData` and `UIImage` with Scale9.
* Replace `Caurina` with `Core Tween` a self developed animation engine.
* Add support for multiple instances of the same `type-identifier` in `UIPasteboard`.
* Integrate `UIDragging` with a likely future HTML5 like api for dragging files into flash runtime.

### Classes under Development

* **view package** `se.raweden.ui.view`
	* `UIActivityIndicator`	- basic spinning preloader.
	* `UIAlertView`		- alert dialog.
	* `UIButton`			- basic and customizable button.
	* `UIButtonGroup`		- controller for a group toggle buttons.
	* `UINavigationBar`	- Navigation bar.
	* `UIPageControl`		- Paging control and indicator.
	* `UIProgressView`		- basic preloaded bar 
	* `UIRating`			- rating control, simular to Appstore and itunes.
	* `UIScroller`		- scrollbar component and indicator.
	* `UIScrollView`		- scrollview width bounce, paging, throwing and zooming.
	* `UISegmentedControl`	- button bar.
	* `UISlider`			- basic slider.
	* `UIStepper`			- numeric stepper.
	* `UISwitch`			- on/off toggle, similar to iOS.
	* `UITabBar`			- tab bar.
	* `UIText`			- scrollable text view.
	* `UITextField`		- input textfield for text, password and more.
	* `UIToolbar`			- basic toolbar.
	* `UICollectionView`	- icon/tile list component.

### Dependencies

* Currently dependent on the caurina tweening engine.

### Related Frameworks
[Core UI Addition](https://github.com/raweden/Core-UI-Addition)  
[Core Cloud](https://github.com/raweden/Core-Cloud)  
[Core Common](https://github.com/raweden/Core-Common)

Copyright © 2011 [Raweden](http://raweden.se).
All rights reserved.

###Term of Use
TERM OF USE
