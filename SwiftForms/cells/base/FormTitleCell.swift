//
//  FormTitleCell.swift
//  SwiftForms
//
//  Created by Miguel Ángel Ortuño Ortuño on 13/11/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public class FormTitleCell: FormBaseCell {

    /// MARK: Cell views
    
    public let titleLabel = UILabel()
    
    public required init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = (self as? FormFontDefaults).map {
            $0.titleLabelFont
        } ?? UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        
        // apply constant constraints
        contentView.addSubview(titleLabel)
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: contentView, attribute: .Height, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
    }
    
    public override func constraintsViews() -> [String : UIView] {
        return ["titleLabel" : titleLabel]
    }
    
    public override func defaultVisualConstraints() -> [String] {
        return ["H:|-16-[titleLabel]-16-|"]
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
