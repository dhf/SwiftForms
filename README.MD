
[![Version](https://img.shields.io/badge/pod-1.0-blue.svg)](http://cocoadocs.org/docsets/SwiftForms)
[![License](https://img.shields.io/badge/license-MIT-gray.svg)](http://cocoadocs.org/docsets/SwiftForms)
[![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)](http://cocoadocs.org/docsets/SwiftForms)

* * *

This is a fork of `SwiftForms` that aims to leverage more of the type safety of Swift. Rather than using a Dictionary of `[NSObject : Any]` for configuration of `FormRowDescriptor`, a statically typed struct is used. This change eliminates a significant amount of type coercing, simplifies code and allows the type checker to guarantee type correctness.

The `master` branch is for use with `Swift 2.0` (there's also a `Swift-1.2` branch).
* * *

SwiftForms
==========

Purpose
-------
SwiftForms is a powerful and extremely flexible library written in Swift that allows to create forms by just defining them in a couple of lines. It also provides the ability to customize cells appearance, use custom cells and define your own selector controllers.

#####Here is an screenshot from an example application using SwiftForms

![Screenshot of Example application](SwiftFormsApplication/Example.gif)

How to create a form
--------------------

Creating a form using SwiftForms is pretty straightforward. All you need is to derive your controller from `FormViewController` and define a `FormDescriptor` instance along with its sections and rows. Here is an example of how to create a simple form to input an email and a user password. 

```swift

// Create form instace 
let form = FormDescriptor()
form.title = "Example form"

// Define first section
let section1 = FormSectionDescriptor()
+ FormRowDescriptor(tag: Static.emailTag, rowType: .Email, title: "Email")
+ FormRowDescriptor(tag: "pass", rowType: .Password, title: "Password")

// Define second section
let section2 = FormSectionDescriptor()
+ FormRowDescriptor(tag: "button", rowType: .Button, title: "Submit")

form.sections = [section1, section2]
self.form = form
```
To see a more complex form definition you can take a look to the example application.

Cell appearance
----------------------

Every row descriptor has a `configuration` property that allows to customize cell's appearance and behavior. In order to change concrete visual aspects of a row simply set `row.configuration.cellConfiguration` value to a dictionary containing custom key-value coding properties.

Here's an example:

```swift
row.configuration.cellConfiguration = ["titleLabel.font" : UIFont.boldSystemFontOfSize(30.0), "segmentedControl.tintColor" : UIColor.redColor()]
```

Custom cells
-----------------

In addition, it is possible to create 100% custom cells by deriving from `FormBaseCell` class. In that case, don't forget to override `configure` and `update` methods. First method will be called only once and after cell has been created, and the second one every time cell content should be refreshed.

Here are the methods that help you to define custom cell behavior.
```swift
func configure() {
    /// override
}
    
func update() {
    /// override
}
    
class func formRowCellHeight() -> CGFloat {
    return 44.0
}
    
class func formViewController(formViewController: FormViewController, didSelectRow: FormBaseCell) {
}
```
Once you have defined your custom cell, and in order to use it for a concrete row, you'll have to set `FormRowDescriptor` cellClass property.

Custom selector controllers
-------------------------------------

In order to customize selector controller your class should conform to `FormSelector` protocol. That way you'll have access to the cell instance that pushed the controller, being able to alter its properties or setting it's row value accordingly to user interaction. 

After defining your class, don't forget to set `selectorControllerClass` value in the `configuration` struct to use your custom selector controller.

Requirements
---------------------

* iOS 7.0 and above

## Installation

> **Embedded frameworks require a minimum deployment target of iOS 8.**
>
> To use SwiftForms with a project targeting iOS 7, you must include all Swift files located inside the `SwiftForms` directory directly in your project.

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

CocoaPods 0.36 adds supports for Swift and embedded frameworks. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate SwiftForms into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'SwiftForms'
```

Then, run the following command:

```bash
$ pod install
```

Copyright
---------

SwiftForms is originally based on XLForm github project. (https://github.com/xmartlabs/XLForm)

Check LICENSE file for more details.

Contact
-------

If you are using SwiftForms in your project and have any suggestion or question:

Miguel Angel Ortuño, <ortuman@gmail.com>

[@ortuman](http://twitter.com/ortuman)
