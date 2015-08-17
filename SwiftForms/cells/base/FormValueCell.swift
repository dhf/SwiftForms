//
//  FormValueCell.swift
//  SwiftForms
//
//  Created by Miguel Ángel Ortuño Ortuño on 13/11/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public class FormValueCell: FormBaseCell, FormFontDefaults {
    
    /// MARK: Cell views
    
    public let titleLabel = UILabel()
    public let valueLabel = UILabel()
    
    /// MARK: FormBaseCell
    
    public override func configure() {
        super.configure()
        
        accessoryType = .DisclosureIndicator
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = titleLabelFont()
        valueLabel.font = valueLabelFont()
        
        valueLabel.textColor = UIColor.lightGrayColor()
        valueLabel.textAlignment = .Right
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        
        titleLabel.setContentHuggingPriority(500, forAxis: .Horizontal)
        titleLabel.setContentCompressionResistancePriority(1000, forAxis: .Horizontal)
        
        // apply constant constraints
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: contentView, attribute: .Height, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: valueLabel, attribute: .Height, relatedBy: .Equal, toItem: contentView, attribute: .Height, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: valueLabel, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
    }
    
    public override func constraintsViews() -> [String : UIView] {
        return ["titleLabel" : titleLabel, "valueLabel" : valueLabel]
    }
    
    public override func defaultVisualConstraints() -> [String] {
        
        // apply default constraints
        let rightPadding = accessoryType == .None ? 16 : 0
        
        if let text = titleLabel.text where !text.isEmpty {
            return ["H:|-16-[titleLabel]-[valueLabel]-\(rightPadding)-|"]
        }
        else {
            return ["H:|-16-[valueLabel]-\(rightPadding)-|"]
        }
    }
}
