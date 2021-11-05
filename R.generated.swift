//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 20 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")
    /// Color `BlueThemeMainColor`.
    static let blueThemeMainColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "BlueThemeMainColor")
    /// Color `BlueThemeSubColor`.
    static let blueThemeSubColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "BlueThemeSubColor")
    /// Color `BlueThemeThirdColor`.
    static let blueThemeThirdColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "BlueThemeThirdColor")
    /// Color `CalendarHeaderColor`.
    static let calendarHeaderColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "CalendarHeaderColor")
    /// Color `CalendarTitleDefaultColor`.
    static let calendarTitleDefaultColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "CalendarTitleDefaultColor")
    /// Color `CalendarTitlePlaceHolderColor`.
    static let calendarTitlePlaceHolderColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "CalendarTitlePlaceHolderColor")
    /// Color `ClearButtonColor`.
    static let clearButtonColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "ClearButtonColor")
    /// Color `DiaryBackgroundColor`.
    static let diaryBackgroundColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "DiaryBackgroundColor")
    /// Color `DiaryDisabledColor`.
    static let diaryDisabledColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "DiaryDisabledColor")
    /// Color `GreenThemeMainColor`.
    static let greenThemeMainColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "GreenThemeMainColor")
    /// Color `GreenThemeSubColor`.
    static let greenThemeSubColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "GreenThemeSubColor")
    /// Color `GreenThemeThirdColor`.
    static let greenThemeThirdColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "GreenThemeThirdColor")
    /// Color `NavigationButtonColor`.
    static let navigationButtonColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "NavigationButtonColor")
    /// Color `SystemBlackColor`.
    static let systemBlackColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "SystemBlackColor")
    /// Color `SystemWhiteColor`.
    static let systemWhiteColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "SystemWhiteColor")
    /// Color `TableViewCellColor`.
    static let tableViewCellColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "TableViewCellColor")
    /// Color `TextFieldTextColor`.
    static let textFieldTextColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "TextFieldTextColor")
    /// Color `ThemeSelectionColor`.
    static let themeSelectionColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "ThemeSelectionColor")
    /// Color `WeekdayTextColor`.
    static let weekdayTextColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "WeekdayTextColor")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "BlueThemeMainColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func blueThemeMainColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.blueThemeMainColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "BlueThemeSubColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func blueThemeSubColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.blueThemeSubColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "BlueThemeThirdColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func blueThemeThirdColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.blueThemeThirdColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "CalendarHeaderColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func calendarHeaderColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.calendarHeaderColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "CalendarTitleDefaultColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func calendarTitleDefaultColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.calendarTitleDefaultColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "CalendarTitlePlaceHolderColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func calendarTitlePlaceHolderColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.calendarTitlePlaceHolderColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "ClearButtonColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func clearButtonColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.clearButtonColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "DiaryBackgroundColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func diaryBackgroundColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.diaryBackgroundColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "DiaryDisabledColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func diaryDisabledColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.diaryDisabledColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "GreenThemeMainColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func greenThemeMainColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.greenThemeMainColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "GreenThemeSubColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func greenThemeSubColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.greenThemeSubColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "GreenThemeThirdColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func greenThemeThirdColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.greenThemeThirdColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "NavigationButtonColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func navigationButtonColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.navigationButtonColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "SystemBlackColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func systemBlackColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.systemBlackColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "SystemWhiteColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func systemWhiteColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.systemWhiteColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "TableViewCellColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func tableViewCellColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.tableViewCellColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "TextFieldTextColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func textFieldTextColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.textFieldTextColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "ThemeSelectionColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func themeSelectionColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.themeSelectionColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "WeekdayTextColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func weekdayTextColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.weekdayTextColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "BlueThemeMainColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func blueThemeMainColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.blueThemeMainColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "BlueThemeSubColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func blueThemeSubColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.blueThemeSubColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "BlueThemeThirdColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func blueThemeThirdColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.blueThemeThirdColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "CalendarHeaderColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func calendarHeaderColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.calendarHeaderColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "CalendarTitleDefaultColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func calendarTitleDefaultColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.calendarTitleDefaultColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "CalendarTitlePlaceHolderColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func calendarTitlePlaceHolderColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.calendarTitlePlaceHolderColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "ClearButtonColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func clearButtonColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.clearButtonColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "DiaryBackgroundColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func diaryBackgroundColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.diaryBackgroundColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "DiaryDisabledColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func diaryDisabledColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.diaryDisabledColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "GreenThemeMainColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func greenThemeMainColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.greenThemeMainColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "GreenThemeSubColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func greenThemeSubColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.greenThemeSubColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "GreenThemeThirdColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func greenThemeThirdColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.greenThemeThirdColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "NavigationButtonColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func navigationButtonColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.navigationButtonColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "SystemBlackColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func systemBlackColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.systemBlackColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "SystemWhiteColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func systemWhiteColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.systemWhiteColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "TableViewCellColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func tableViewCellColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.tableViewCellColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "TextFieldTextColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func textFieldTextColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.textFieldTextColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "ThemeSelectionColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func themeSelectionColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.themeSelectionColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "WeekdayTextColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func weekdayTextColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.weekdayTextColor.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 25 images.
  struct image {
    /// Image `Add`.
    static let add = Rswift.ImageResource(bundle: R.hostingBundle, name: "Add")
    /// Image `AlarmIcon`.
    static let alarmIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "AlarmIcon")
    /// Image `ArrowIcon`.
    static let arrowIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "ArrowIcon")
    /// Image `BackButton`.
    static let backButton = Rswift.ImageResource(bundle: R.hostingBundle, name: "BackButton")
    /// Image `CalendarAsset`.
    static let calendarAsset = Rswift.ImageResource(bundle: R.hostingBundle, name: "CalendarAsset")
    /// Image `CalendarBackButton`.
    static let calendarBackButton = Rswift.ImageResource(bundle: R.hostingBundle, name: "CalendarBackButton")
    /// Image `CalendarFrontButton`.
    static let calendarFrontButton = Rswift.ImageResource(bundle: R.hostingBundle, name: "CalendarFrontButton")
    /// Image `DarkMode`.
    static let darkMode = Rswift.ImageResource(bundle: R.hostingBundle, name: "DarkMode")
    /// Image `DiaryDrawerButton`.
    static let diaryDrawerButton = Rswift.ImageResource(bundle: R.hostingBundle, name: "DiaryDrawerButton")
    /// Image `DismissButton`.
    static let dismissButton = Rswift.ImageResource(bundle: R.hostingBundle, name: "DismissButton")
    /// Image `EditButton`.
    static let editButton = Rswift.ImageResource(bundle: R.hostingBundle, name: "EditButton")
    /// Image `FeedbackIcon`.
    static let feedbackIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "FeedbackIcon")
    /// Image `LightMode`.
    static let lightMode = Rswift.ImageResource(bundle: R.hostingBundle, name: "LightMode")
    /// Image `LockIcon`.
    static let lockIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "LockIcon")
    /// Image `LogoutIcon`.
    static let logoutIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "LogoutIcon")
    /// Image `MainIconBlueTheme`.
    static let mainIconBlueTheme = Rswift.ImageResource(bundle: R.hostingBundle, name: "MainIconBlueTheme")
    /// Image `MainIconGreenTheme`.
    static let mainIconGreenTheme = Rswift.ImageResource(bundle: R.hostingBundle, name: "MainIconGreenTheme")
    /// Image `OpenSourceIcon`.
    static let openSourceIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "OpenSourceIcon")
    /// Image `SelectedButton`.
    static let selectedButton = Rswift.ImageResource(bundle: R.hostingBundle, name: "SelectedButton")
    /// Image `SocialLoginHolderImage`.
    static let socialLoginHolderImage = Rswift.ImageResource(bundle: R.hostingBundle, name: "SocialLoginHolderImage")
    /// Image `SystemMode`.
    static let systemMode = Rswift.ImageResource(bundle: R.hostingBundle, name: "SystemMode")
    /// Image `ThemeIcon`.
    static let themeIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "ThemeIcon")
    /// Image `UnSelectedButton`.
    static let unSelectedButton = Rswift.ImageResource(bundle: R.hostingBundle, name: "UnSelectedButton")
    /// Image `check`.
    static let check = Rswift.ImageResource(bundle: R.hostingBundle, name: "check")
    /// Image `searchButton`.
    static let searchButton = Rswift.ImageResource(bundle: R.hostingBundle, name: "searchButton")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Add", bundle: ..., traitCollection: ...)`
    static func add(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.add, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "AlarmIcon", bundle: ..., traitCollection: ...)`
    static func alarmIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.alarmIcon, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ArrowIcon", bundle: ..., traitCollection: ...)`
    static func arrowIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.arrowIcon, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "BackButton", bundle: ..., traitCollection: ...)`
    static func backButton(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.backButton, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "CalendarAsset", bundle: ..., traitCollection: ...)`
    static func calendarAsset(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.calendarAsset, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "CalendarBackButton", bundle: ..., traitCollection: ...)`
    static func calendarBackButton(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.calendarBackButton, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "CalendarFrontButton", bundle: ..., traitCollection: ...)`
    static func calendarFrontButton(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.calendarFrontButton, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "DarkMode", bundle: ..., traitCollection: ...)`
    static func darkMode(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.darkMode, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "DiaryDrawerButton", bundle: ..., traitCollection: ...)`
    static func diaryDrawerButton(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.diaryDrawerButton, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "DismissButton", bundle: ..., traitCollection: ...)`
    static func dismissButton(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.dismissButton, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "EditButton", bundle: ..., traitCollection: ...)`
    static func editButton(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.editButton, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "FeedbackIcon", bundle: ..., traitCollection: ...)`
    static func feedbackIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.feedbackIcon, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "LightMode", bundle: ..., traitCollection: ...)`
    static func lightMode(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.lightMode, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "LockIcon", bundle: ..., traitCollection: ...)`
    static func lockIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.lockIcon, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "LogoutIcon", bundle: ..., traitCollection: ...)`
    static func logoutIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.logoutIcon, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "MainIconBlueTheme", bundle: ..., traitCollection: ...)`
    static func mainIconBlueTheme(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.mainIconBlueTheme, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "MainIconGreenTheme", bundle: ..., traitCollection: ...)`
    static func mainIconGreenTheme(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.mainIconGreenTheme, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "OpenSourceIcon", bundle: ..., traitCollection: ...)`
    static func openSourceIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.openSourceIcon, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "SelectedButton", bundle: ..., traitCollection: ...)`
    static func selectedButton(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.selectedButton, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "SocialLoginHolderImage", bundle: ..., traitCollection: ...)`
    static func socialLoginHolderImage(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.socialLoginHolderImage, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "SystemMode", bundle: ..., traitCollection: ...)`
    static func systemMode(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.systemMode, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ThemeIcon", bundle: ..., traitCollection: ...)`
    static func themeIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.themeIcon, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "UnSelectedButton", bundle: ..., traitCollection: ...)`
    static func unSelectedButton(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.unSelectedButton, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "check", bundle: ..., traitCollection: ...)`
    static func check(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.check, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "searchButton", bundle: ..., traitCollection: ...)`
    static func searchButton(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.searchButton, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.infoPlist` struct is generated, and contains static references to 1 localization keys.
    struct infoPlist {
      /// en translation: Someday
      ///
      /// Locales: en, ko
      static let cfBundleDisplayName = Rswift.StringResource(key: "CFBundleDisplayName", tableName: "InfoPlist", bundle: R.hostingBundle, locales: ["en", "ko"], comment: nil)

      /// en translation: Someday
      ///
      /// Locales: en, ko
      static func cfBundleDisplayName(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("CFBundleDisplayName", tableName: "InfoPlist", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "InfoPlist", preferredLanguages: preferredLanguages) else {
          return "CFBundleDisplayName"
        }

        return NSLocalizedString("CFBundleDisplayName", tableName: "InfoPlist", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
