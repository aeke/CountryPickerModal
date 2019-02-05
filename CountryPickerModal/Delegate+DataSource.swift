//
//  Delegate+DataSource.swift
//  CountryPickerModal
//
//  Created by Kizito Nwose on 16/02/2018.
//  Copyright © 2018 Kizito Nwose. All rights reserved.
//

import Foundation

public protocol CountryPickerModalDelegate: class {
    /// Called when the user selects a country from the list.
    func countryPickerModal(_ countryPickerModal: CountryPickerModal, didSelectCountry country: Country)
    
    /// Called before the internal CountryPickerModalController is presented or pushed.
    /// If the CountryPickerModalController is presented(not pushed), it is embedded in a UINavigationController.
    /// The CountryPickerModalController is a UITableViewController subclass.
    func countryPickerModal(_ countryPickerModal: CountryPickerModal, willShow viewController: CountryPickerModalController)
    
    /// Called after the internal CountryPickerModalController is presented or pushed.
    /// If the CountryPickerModalController is presented(not pushed), it is embedded in a UINavigationController.
    /// The CountryPickerModalController is a UITableViewController subclass.
    func countryPickerModal(_ countryPickerModal: CountryPickerModal, didShow viewController: CountryPickerModalController)
}

public protocol CountryPickerModalDataSource: class {
    /// An array of countries you wish to show at the top of the list.
    /// This is useful if your app is targeted towards people in specific countries.
    /// - requires: The title for the section to be returned in `sectionTitleForPreferredCountries`
    func preferredCountries(in countryPickerModal: CountryPickerModal) -> [Country]
    
    /// The desired title for the preferred section.
    /// - **See:** `preferredCountries` method. Both are required for the section to be shown.
    func sectionTitleForPreferredCountries(in countryPickerModal: CountryPickerModal) -> String?
    
    /// This determines if only the preferred section is shown
    func showOnlyPreferredSection(in countryPickerModal: CountryPickerModal) -> Bool
    
    /// The desired font for the section title labels on the list. Can be used to configure the text size.
    /// Default value is UIFont.boldSystemFont(ofSize: 17)
    func sectionTitleLabelFont(in countryPickerModal: CountryPickerModal) -> UIFont

    /// The desired text color for the section title labels on the list.
    func sectionTitleLabelColor(in countryPickerModal: CountryPickerModal) -> UIColor?
    
    /// The desired font for the cell labels on the list. Can be used to configure the text size.
    /// Default value is UIFont.systemFont(ofSize: 17)
    func cellLabelFont(in countryPickerModal: CountryPickerModal) -> UIFont
    
    /// The desired text color for the country names on the list.
    func cellLabelColor(in countryPickerModal: CountryPickerModal) -> UIColor?
    
    /// The desired size for the flag images on the list.
    func cellImageViewSize(in countryPickerModal: CountryPickerModal) -> CGSize
    
    /// The desired corner radius for the flag images on the list. Default value is 2
    func cellImageViewCornerRadius(in countryPickerModal: CountryPickerModal) -> CGFloat
    
    /// The navigation item title when the internal view controller is pushed/presented.
    func navigationTitle(in countryPickerModal: CountryPickerModal) -> String?
    
    /// A navigation item button to be used if the internal view controller is presented(not pushed).
    /// Return `nil` to use a default "Close" button.
    func closeButtonNavigationItem(in countryPickerModal: CountryPickerModal) -> UIBarButtonItem?
    
    /// The desired position for the search bar.
    func searchBarPosition(in countryPickerModal: CountryPickerModal) -> SearchBarPosition
    
    /// This determines if a country's phone code is shown alongside the country's name on the list.
    /// e.g Nigeria (+234)
    func showPhoneCodeInList(in countryPickerModal: CountryPickerModal) -> Bool
}

// MARK:- CountryPickerModalDataSource default implementations
public extension CountryPickerModalDataSource {
    
    func preferredCountries(in countryPickerModal: CountryPickerModal) -> [Country] {
        return []
    }
    
    func sectionTitleForPreferredCountries(in countryPickerModal: CountryPickerModal) -> String? {
        return nil
    }
    
    func showOnlyPreferredSection(in countryPickerModal: CountryPickerModal) -> Bool {
        return false
    }
    
    func sectionTitleLabelFont(in countryPickerModal: CountryPickerModal) -> UIFont {
        return UIFont.boldSystemFont(ofSize: 17)
    }

    func sectionTitleLabelColor(in countryPickerModal: CountryPickerModal) -> UIColor? {
        return nil
    }
    
    func cellLabelFont(in countryPickerModal: CountryPickerModal) -> UIFont {
        return UIFont.systemFont(ofSize: 17)
    }
    
    func cellLabelColor(in countryPickerModal: CountryPickerModal) -> UIColor? {
        return nil
    }
    
    func cellImageViewCornerRadius(in countryPickerModal: CountryPickerModal) -> CGFloat {
        return 2
    }
    
    func cellImageViewSize(in countryPickerModal: CountryPickerModal) -> CGSize {
        return CGSize(width: 34, height: 24)
    }
    
    func navigationTitle(in countryPickerModal: CountryPickerModal) -> String? {
        return nil
    }
    
    func closeButtonNavigationItem(in countryPickerModal: CountryPickerModal) -> UIBarButtonItem? {
        return nil
    }
    
    func searchBarPosition(in countryPickerModal: CountryPickerModal) -> SearchBarPosition {
        return .tableViewHeader
    }
    
    func showPhoneCodeInList(in countryPickerModal: CountryPickerModal) -> Bool {
        return false
    }
}


// MARK:- CountryPickerModalDelegate default implementations
public extension CountryPickerModalDelegate {

    func countryPickerModal(_ countryPickerModal: CountryPickerModal,
                           willShow viewController: CountryPickerModalController) {
    }
    
    func countryPickerModal(_ countryPickerModal: CountryPickerModal,
                           didShow viewController: CountryPickerModalController) {
    }

}

