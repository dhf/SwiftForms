//
//  FormFontDefaultsProtocol.swift
//  SwiftFormsApplication
//
//  Created by Alan Skipp on 17/08/2015.
//  Copyright © 2015 Miguel Angel Ortuno Ortuno. All rights reserved.
//

public protocol FormFontDefaults {
    var titleLabelFont: UIFont { get }
    var valueLabelFont: UIFont { get }
    var textFieldFont: UIFont { get }
}

public extension FormFontDefaults {
    var titleLabelFont: UIFont { return UIFont.preferredFontForTextStyle(UIFontTextStyleBody) }
    var valueLabelFont: UIFont { return UIFont.preferredFontForTextStyle(UIFontTextStyleBody) }
    var textFieldFont: UIFont { return UIFont.preferredFontForTextStyle(UIFontTextStyleBody) }
}

/*
To override the font styling, or to use your own custom font,
add an extension to `FormBaseCell` that overrides the default extension

Example:

public extension FormBaseCell {
    var titleLabelFont: UIFont { return UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline) }
    var valueLabelFont: UIFont { return UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1) }
    var textFieldFont: UIFont { return UIFont.preferredFontForTextStyle(UIFontTextStyleCaption2) }
}

*/
