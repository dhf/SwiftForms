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

/*
To override the font styling, or to use your own custom font,
conform `FormBaseCell` to the `FormFontDefaults` protocol.

Example:

extension FormBaseCell: FormFontDefaults {
    public var titleLabelFont: UIFont { return UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline) }
    public var valueLabelFont: UIFont { return UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1) }
    public var textFieldFont: UIFont { return UIFont.preferredFontForTextStyle(UIFontTextStyleCaption2) }
}

*/
