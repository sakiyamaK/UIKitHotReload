//
//  String+.swift
//  SampleFirebase
//
//  Created by sakiyamaK on 2020/10/12.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit

extension String {
  var viewPath: (dirName: String, jsonFileName: String)? {
    let strs = self.components(separatedBy: "/")
    guard strs.count == 2 else { return nil }
    return (strs[0], strs[1])
  }
}

extension String {
  var contentMode: UIView.ContentMode {
    switch self.lowercased() {
    case "scaleaspectfill", "aspectfill", "scale_aspect_fill", "aspect_fill", "fill":
      return .scaleAspectFill
    case "scaleaspectfit", "aspectfit", "scale_aspect_fit", "aspect_fit", "fit":
      return .scaleAspectFit
    default:
      return .scaleToFill
    }
  }

  var axis: NSLayoutConstraint.Axis {
    switch self.lowercased() {
    case "vertial", "v":
      return NSLayoutConstraint.Axis.vertical
    case "horizontal", "h":
      return NSLayoutConstraint.Axis.horizontal
    default:
      return NSLayoutConstraint.Axis.vertical
    }
  }

  var alignment: UIStackView.Alignment {
    switch self.lowercased() {
    case "fill":
      return UIStackView.Alignment.fill
    case "center":
      return UIStackView.Alignment.center
    case "leading":
      return UIStackView.Alignment.leading
    case "trailing":
      return UIStackView.Alignment.trailing
    case "top":
      return UIStackView.Alignment.top
    case "bottom":
      return UIStackView.Alignment.bottom
    default:
      return UIStackView.Alignment.fill
    }
  }

  var distribution: UIStackView.Distribution {
    switch self.lowercased() {
    case "equalcentering", "equal_centering", "centering":
      return UIStackView.Distribution.equalCentering
    case "equalspacing", "equal_spacing", "spacing":
      return UIStackView.Distribution.equalSpacing
    case "fill":
      return UIStackView.Distribution.fill
    case "fillequally", "fill_equally", "fille", "fill_e":
      return UIStackView.Distribution.fillEqually
    case "fillproportionally", "fill_proportionally", "fillp", "fill_p":
      return UIStackView.Distribution.fillProportionally
    default:
      return UIStackView.Distribution.fill
    }
  }
}

extension String {
  var textAlignment: NSTextAlignment {
    switch self.lowercased() {
    case "center":
      return .center
    case "right":
      return .right
    default:
      return .left
    }
  }
}

extension String {
  var separatorStyle: UITableViewCell.SeparatorStyle {
    switch self.lowercased() {
    case "none":
      return .none
    default:
      return .singleLine
    }
  }

  var indicatorStyle: UITableView.IndicatorStyle {
    switch self.lowercased() {
    case "black":
      return .black
    case "white":
      return .white
    default:
      return .default
    }
  }
}

extension String {
  var borderStyle: UITextField.BorderStyle {
    switch self.lowercased() {
    case "none":
      return .none
    case "bezel":
      return .bezel
    case "line":
      return .line
    case "roundedrect", "rounded_rect", "rect":
      return .roundedRect
    default:
      return .roundedRect
    }
  }
}

extension String {
  var textContentType: UITextContentType {
    switch self.lowercased() {
    case "name":
      return .name
    case "name_prefix":
      return .namePrefix
    case "given_name":
      return .givenName
    case "middle_name":
      return .middleName
    case "family_name":
      return .familyName
    case "name_suffix":
      return .nameSuffix
    case "nickname", "nick_name":
      return .nickname
    case "job_title":
      return .jobTitle
    case "organization_name", "o_name":
      return .organizationName
    case "location":
      return .location
    case "full_street_address", "full_st_ad":
      return .fullStreetAddress
    case "street_address_line_1", "st_ad_line_1":
      return .streetAddressLine1
    case "street_address_line_2", "st_ad_line_2":
      return .streetAddressLine2
    case "city":
      return .addressCity
    case "state":
      return .addressState
    case "city_state":
      return .addressCityAndState
    case "sublocality", "sub_locality":
      return .sublocality
    case "country_name":
      return .countryName
    case "postal_code":
      return .postalCode
    case "telephone_number", "tel_number", "tel_num":
      return .telephoneNumber
    case "email_address", "email":
      return .emailAddress
    case "url":
      return .URL
    case "credit_card_numer":
      return .creditCardNumber
    case "username", "user_name":
      return .username
    case "password":
      return .password
    case "new_password":
      if #available(iOS 12.0, *) {
        return .newPassword
      } else {
        return .name
      }
    case "one_time_code":
      if #available(iOS 12.0, *) {
        return .oneTimeCode
      } else {
        return .name
      }
    default:
      return .name
    }
  }
}

extension String {
  var capitalizationType: UITextAutocapitalizationType {
    switch self.lowercased() {
    case "none":
      return .none
    case "words":
      return .words
    case "sentences":
      return .sentences
    case "all_characters", "all", "all_char":
      return .allCharacters
    default:
      return .none
    }
  }
}

extension String {
  var keyboardType: UIKeyboardType {
    switch self.lowercased() {
    case "url":
      return .URL
    case "ascii_capable", "ascii":
      return .asciiCapable
    case "ascii_capable_number_pad", "ascii_capable_number", "ascii_number", "ascii_num":
      return .asciiCapableNumberPad
    case "decimal_pad", "decimal":
      return .decimalPad
    case "email_address", "email":
      return .emailAddress
    case "name_phone_pad", "name_phone":
      return .namePhonePad
    case "number_pad", "number":
      return .numberPad
    case "numbers_and_punctuation", "numbers_punctuation", "numbers_pun":
      return .numbersAndPunctuation
    case "phone_pad", "phone":
      return .phonePad
    case "twitter":
      return .twitter
    case "web_search", "web", "search":
      return .webSearch
    case "alphabet":
      return .alphabet
    default:
      return .default
    }
  }
}

extension String {
  var returnKeyType: UIReturnKeyType {
    switch self.lowercased() {
    case "continue":
      return .continue
    case "done":
      return .done
    case "emergency_call", "emergency":
      return .emergencyCall
    case "go":
      return .go
    case "google":
      return .google
    case "join":
      return .join
    case "next":
      return .next
    case "route":
      return .route
    case "web", "web_search", "search":
      return .search
    case "send":
      return .send
    case "yahoo":
      return .yahoo
    default:
      return .default
    }
  }
}

extension String {
  var fontWeight: UIFont.Weight {
    switch self.lowercased() {
    case "ultraLight":
      return .ultraLight
    case "thin":
      return .thin
    case "light":
      return .light
    case "regular":
      return .regular
    case "medium":
      return .medium
    case "semibold":
      return .semibold
    case "bold":
      return .bold
    case "heavy":
      return .heavy
    case "black":
      return .black
    default:
      return .regular
    }
  }
}
