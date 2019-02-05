# CountryPickerModal

[![Build Status](https://travis-ci.org/aeke/CountryPickerModal.svg?branch=master)](https://travis-ci.org/aeke/CountryPickerModal)
[![Platform](https://img.shields.io/badge/Platform-iOS-00BCD4.svg)](http://cocoapods.org/pods/CountryPickerModal)
[![Version](https://img.shields.io/cocoapods/v/CountryPickerModal.svg?style=flat)](http://cocoapods.org/pods/CountryPickerModal)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/badge/License-MIT-8D6E63.svg)](https://github.com/aeke/CountryPickerModal/blob/master/LICENSE.md)

CountryPickerModal is a simple, customizable view for selecting countries in iOS apps.

You can clone/download the repository and run the [demo project](https://github.com/aeke/CountryPickerModal/tree/master/CountryPickerModalDemo) to see CountryPickerModal in action. First run `pod install` from the CountryPickerModalDemo directory.

<img align="left" src="https://raw.githubusercontent.com/aeke/CountryPickerModal/master/CountryPickerModalDemo/Screenshots/1.png" width="300">
<img src="https://raw.githubusercontent.com/aeke/CountryPickerModal/master/CountryPickerModalDemo/Screenshots/2.png" width="300">

<img align="left" src="https://raw.githubusercontent.com/aeke/CountryPickerModal/master/CountryPickerModalDemo/Screenshots/3.png" width="300">
<img src="https://raw.githubusercontent.com/aeke/CountryPickerModal/master/CountryPickerModalDemo/Screenshots/4.png" width="300">


## Installation

> Note that 2.x releases are Swift 4 compatible. For the Swift 3 compatibility, please use 1.x releases.

### Cocoapods

CountryPickerModal is available through [CocoaPods](http://cocoapods.org). Simply add the following to your Podfile:

```ruby
use_frameworks!

target '<Your Target Name>' do
  pod 'CountryPickerModal'
end
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

To install CountryPickerModal through Carthage, simply add the following to your Cartfile:

```ruby
github "aeke/CountryPickerModal"
```

### Manual

1. Put CountryPickerModal repo somewhere in your project directory.
2. In Xcode, add `CountryPickerModal.xcodeproj` to your project.
3. On your app's target, add the CountryPickerModal framework:
   1. as an embedded binary on the General tab.
   2. as a target dependency on the Build Phases tab.

## Usage

If you're using Storyboards/Interface Builder you can create a CountryPickerModal instance by adding a UIView to your Storyboard, and then manually changing the view's class to CountryPickerModal in the "Custom Class" field of the Identity Inspector tab on the Utilities panel (the right-side panel)

You can also create an instance of CountryPickerModal programmatically:

```swift
import CountryPickerModal

let cpv = CountryPickerModal(frame: /**Desired frame**/)
```

To get the selected country from your `CountryPickerModal` instance at any time, use the `selectedCountry` property.

```swift
let country = cpv.selectedCountry
print(country)
```
This property is not optional, the default value is the user's current country, derived from the device's current Locale.

### Customization

Customization options for the view itself are available directly via the CountryPickerModal instance while options for the internal CountryPicker table view are available via the `CountryPickerModalDataSource` protocol. Setting the `CountryPickerModalDelegate` protocol is also necessary if you wish to be notified when the user selects a country from the list.

```swift
import CountryPickerModal

class DemoViewController: UIViewController, CountryPickerModalDelegate, CountryPickerModalDataSource {

    @IBOutlet weak var countryPickerModal: CountryPickerModal!

    override func viewDidLoad() {
        super.viewDidLoad()

        countryPickerModal.delegate = self
        countryPickerModal.dataSource = self

        /*** Direct customizations on CountryPickerModal instance ***/

        // Show the selected country's phone(e.g +234) code on the view
        countryPickerModal.showPhoneCodeInView = true

        // Show the selected country's iso code(e.g NG) on the view
        countryPickerModal.showCountryCodeInView = true
    }

}
```

#### CountryPickerModalDelegate
- Called when the user selects a country from the list or when you manually set the `selectedCountry` property of the `CountryPickerModal`

  ```swift
  func countryPickerModal(_ countryPickerModal: CountryPickerModal, didSelectCountry country: Country)
  ```

- Called before the CountryPickerModalController is presented or pushed. The CountryPickerModalController is a UITableViewController subclass.
  
  ```swift
  func countryPickerModal(_ countryPickerModal: CountryPickerModal, willShow viewController: CountryPickerModalController)
  ```

- Called after the CountryPickerModalController is presented or pushed. The CountryPickerModalController is a UITableViewController subclass.
  
  ```swift
  func countryPickerModal(_ countryPickerModal: CountryPickerModal, didShow viewController: CountryPickerModalController)
  ```

**Note: If you already have a `Country` class or struct in your project then implementing the `didSelectCountry` delegate method can cause a compile error with a message saying that your conforming class does not comform to the `CountryPickerModalDelegate` protocol. This is because Xcode can't figure out which Country model to use in the method. The solution is to replace the `Country` in the method signature with the typealias `CPVCountry`, your delegate method should now look like this:**

```swift
func countryPickerModal(_ countryPickerModal: CountryPickerModal, didSelectCountry country: CPVCountry)
``` 
  
  You can also use `CPVCountry` as a replacement for the framework's `Country` model in other parts of your project.

Also, `willShow` and `didShow` delegate methods are optional. If the CountryPickerModalController is presented(not pushed), it is embedded in a UINavigationController.
The `CountryPickerModalController` class is made available so you can customize its appearance if needed. You can also access the public `searchController(UISearchController)` property in the `CountryPickerModalController` for customization.


#### CountryPickerModalDataSource
The datasource methods define the internal(country list) ViewController's behavior. Run the demo project to play around with the options. All methods are optional.

- An array of countries you wish to show at the top of the list. This is useful if your app is targeted towards people in specific countries.
  
  ```swift
  func preferredCountries(in countryPickerModal: CountryPickerModal) -> [Country]
  ```

- The desired title for the preferred section.
  
  ```swift  
  func sectionTitleForPreferredCountries(in countryPickerModal: CountryPickerModal) -> String?
  ```
  **Note:** You have to return a non-empty array of countries from `preferredCountries(in countryPickerModal: CountryPickerModal)` as well as this section title if you wish to show preferred countries on the list. Returning only the array or title will not work.

- Show **ONLY** the preferred countries section on the list. Default value is `false`
  
  ```swift  
  func showOnlyPreferredSection(in countryPickerModal: CountryPickerModal) -> Bool
  ```
  Return `true` to hide the internal list so your users can only choose from the preferred countries list.

- The desired font for the section title labels on the list. Can be used to configure the text size.
  
  ```swift  
  func sectionTitleLabelFont(in countryPickerModal: CountryPickerModal) -> UIFont
  ```

- The desired text color for the section title labels on the list.
  
  ```swift  
  func sectionTitleLabelColor(in countryPickerModal: CountryPickerModal) -> UIColor?
  ```

- The desired font for the cell labels on the list. Can be used to configure the text size.
  
  ```swift  
  func cellLabelFont(in countryPickerModal: CountryPickerModal) -> UIFont
  ```

- The desired text color for the country names on the list.
  
  ```swift  
  func cellLabelColor(in countryPickerModal: CountryPickerModal) -> UIColor?
  ```

- The desired size for the flag images on the list.
  
  ```swift  
  func cellImageViewSize(in countryPickerModal: CountryPickerModal) -> CGSize
  ```

- The desired corner radius for the flag images on the list.
  
  ```swift  
  func cellImageViewCornerRadius(in countryPickerModal: CountryPickerModal) -> CGFloat
  ```

- The navigation item title when the internal view controller is pushed/presented. Default value is `nil`
  
  ```swift   
  func navigationTitle(in countryPickerModal: CountryPickerModal) -> String?
  ```

- A navigation item button to be used if the internal view controller is presented(not pushed). If nil is returned, a default "Close" button is used. This method only enables you return a button customized the way you want. Default value is `nil`
  
  ```swift    
  func closeButtonNavigationItem(in countryPickerModal: CountryPickerModal) -> UIBarButtonItem?
  ```
  **Note:** Any `target` or `action` associated with this button will be replaced as this button's sole purpose is to close the internal view controller.

- Desired position for the search bar. Default value is `.tableViewHeader`
  
  ```swift    
  func searchBarPosition(in countryPickerModal: CountryPickerModal) -> SearchBarPosition
  ```
  Possible values are: `.tableViewHeader`, `.navigationBar` and `.hidden`

- Show the phone code alongside the country name on the list. e.g Nigeria (+234). Default value is `false`
  
  ```swift    
  func showPhoneCodeInList(in countryPickerModal: CountryPickerModal) -> Bool
  ```

### Using CountryPickerModal with UITextField

A good use case for `CountryPickerModal` is when used as the left view of a phone number input field.

```swift
class DemoViewController: UIViewController {

    @IBOutlet weak var phoneNumberField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        let cpv = CountryPickerModal(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        phoneNumberField.leftView = cpv
        phoneNumberField.leftViewMode = .always
    }
}
```
This means your users do not have to worry about entering the country's phone code in the text field. This also ensures you get a valid phone code from `CountryPickerModal` instead of relying on your users.

### Using the internal picker independently

If for any reason you do not want to show the default view or have your own implementation for showing country information, you can still use the internal picker to allow your users select countries from the list by calling the method `showCountriesList(from: UIViewController)` on a `CountryPickerModal` instance.

It's important to keep a field reference to the `CountryPickerModal` instance else it will be garbage collected and any attempt to use it will result to a crash.

```swift
class DemoViewController: UIViewController {

    // Keep a field reference
    let countryPickerModal = CountryPickerModal()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonPressed(_ sender: Any) {
        countryPickerModal.showCountriesList(from: self)
    }
}
```
In the example above, calling `countryPickerModal.showCountriesList(from: self)` will result in the internal picker view controller being presented in its own navigation stack because `DemoViewController` is not a navigation controller.

If you already have a navigation stack, you can push the internal picker view controller onto that stack by calling `countryPickerModal.showCountriesList(from: self.navigationController!)` or do it the safe way:

```swift
if let nav = self.navigationController {
	countryPickerModal.showCountriesList(from: nav)
}
```
Don't forget to set a delegate to be notified when the use selects a country from the list. An example of how to use the internal picker view controller is included in the demo project.


## License

CountryPickerModal is distributed under the MIT license. [See LICENSE](https://github.com/aeke/CountryPickerModal/blob/master/LICENSE.md) for details.
