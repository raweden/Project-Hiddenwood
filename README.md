# Project Hiddenwood

Project Hiddenwood where developed as the User Interface and and is the kit behind the Openbox Project, it's written in pure Actionscript 3 and the libary focuses on a extensible MVC pattern and is heavily based on delegation and interfaces which provides a great flexibility compared to other libraries/frameworks.

The library is written in pure ActionScript 3.0 against the Flash 10.1 runtime.

### Features

* Contains wrappers (`WebStorage`, `WebFile` and `User`) for some commands in the [collab (php)]() backend.
* Resource Management, with a uniform type lookup and a internal clipboard class `UIPasteboard`.
* No Dependencies, the library stands on it's own legs.
* More.. more.. So much that there is no way to writting them here.

### Developers Notes.

The development of "Project Hiddenwood" have currently been put on ice, the project current state could be described as pre-alpha, which means that some bugs and even missing features exists. However due to the unstable future of the flash platform I have chosen to not investment the time to complete this project. 

## Hiddenwood Highlights 

### Views
The `Project Hiddenwood` provides a basic set of views and components. All views inherits from the `UIView` class, which provides a base for managing content displayed on screen, to ensure minimal performance usage a special but simple drawing cycle is implemented. Among with many other classes in the Core UI you find `UIScrollView` which is a advanced view for scrolling and zooming content.

### Drag and Drop
The library has it's own drag-and-drop api named `UIDragging` which together with `UIPasteboard` provides a interface for dragging multiple items and it's data internally between views, modules and applications. The user experience have been taken into account when designing this api, and modern features for inline destination preview, and easing for the dragging itself with a slide back animation alternative if the drop where rejected by the destination.

### Documents
The `Project Hiddenwood` provides classes for developing document based applications, the `UIDocument` which is base to all document's data model from which you should subclass for fit your document's specifications. Together with `UIUndoManager` a basic undo and redo features can easily be accomplished.

### Script Editor
The `UIScriptView` class is the Project Hiddenwood's equivalent of the code editor found inside the WordPress platform. UIScriptEditor supports tab formatting and more features to come, like syntax highlighting API and code snippet injection.

### Card-based Navigation
The `UIPagingView` is a card-based navigation view, the component dynamically renders the page cells, much like the `UITableView` those cells can be refused for minimal memory usage. This component is based on [Core UI](https://github.com/raweden/Core-UI/) framework and is currently in a experimental stage.

### Video Kit
The `UIVideoView` is a MVC based video component that will integrate with Youtube and regular streaming but also support custom Flash Media Server integration without a major code base change.

### Console Kit
A experimental projects to intergrate a Command-line component. The `console` package contains a basic interface for command-line input and organizing commands, the principal classes is `Console` a central piece of code that provides a arguments extraction and much more and the `IConsoleCommand` which is a abstract interface for commands to run with the `Console` class.

### Localization
Develop multi-language application by loading external strings, the `LocalizedStrings` class provides a resource of strings which together with `printf()` built in provides means for creating dynamic content.

### Runtime Support for common icons
Images and in this case **icons** are far more recognized by the human brain than text, with `ICNS.decode()` and `ICO.decode()` you can now decode files of the most common icon types on todays operative systems into a resource of `BitmapData` to use dynamically within your project. Not enough? with `ICNS.encode()` and `ICO.encode()` you can no export `BitmapData` resources to a binary output. These classes are found with their own package at `se.raweden.types`.

### Remoting made easy
A dynamic runtime requiers external data. Project Hiddenwood provides the `RemoteMessage` for making calls to remote backend, for example: [collab (php)](https://github.com/raweden/Collab.php) and [amfphp](https://github.com/silexlabs/amfphp-2.0).

### Logging
A common need for developers is to trace their steps, the Core Common framework provides this feature with a backend class `Logger` which organizes and stores output made with built in `log()` method at runtime. A abstract interface `IConsoleOutput` is provided for readers and visual outputs.

### WebFile
The `WebFile` class is wrapper for managing remotely located files asynchronous on the [Collab (php)](https://github.com/raweden/Collab.php) platform.

### WebStorage
The `WebStorage` class provides a storage where application's can store preferences and also properties which represents the application current state. With user authentication these properties may also be stored in the cloud to which makes the application state and preferences restorable on any device. The transfer of this data is Incremental, and only handles the properties that have been changed, developed as wrapper for commands in the [Collab (php)](https://github.com/raweden/Collab.php) platform.

*  *  *

### TODO

* Add support for customization with use of `BitmapData` and `UIImage` with Scale9 as skin for almost all UI components.
* Replace All text renders with Flash Text Engine.
* Rebuild GridView component.

*  *  *

Copyright © 2011 [Raweden](http://raweden.se)

### Term of Use
**You are free:** to copy, distribute, display, and perform the work
to make derivative works
to make commercial use of the work
**Under the following conditions:**

* **Attribution** — You must give the original author credit.
* **Share Alike** — If you alter, transform, or build upon this work, you may distribute the resulting work only under a licence identical to this one.

![CC Licence](http://raweden.se/public/github/by.png)  ![CC Licence](http://raweden.se/public/github/sa.png)
	
	

		