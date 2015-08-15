//
//  FormSegmentedControlCell.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 21/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public extension FormSegmentedControlCell {
    func titleLabelFont() -> UIFont {
        return UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
    }
}

public class FormSegmentedControlCell: FormBaseCell, FormFontDefaults {
    
    /// MARK: Cell views
    
    public let titleLabel = UILabel()
    public let segmentedControl = UISegmentedControl()
    
    /// MARK: Properties
    
    private var customConstraints: [AnyObject]!
    
    /// MARK: FormBaseCell
    
    public override func configure() {
        super.configure()
        
        selectionStyle = .None
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.setContentCompressionResistancePriority(500, forAxis: .Horizontal)
        segmentedControl.setContentCompressionResistancePriority(500, forAxis: .Horizontal)
        
        titleLabel.font = titleLabelFont()
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(segmentedControl)
        
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: segmentedControl, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        
        segmentedControl.addTarget(self, action: "valueChanged:", forControlEvents: .ValueChanged)
    }

    public override func update() {
        super.update()

        titleLabel.text = rowDescriptor.title
        updateSegmentedControl()

        if let value = rowDescriptor.value,
           let options = rowDescriptor.configuration.options,
           let idx = options.indexOf(value) {
            segmentedControl.selectedSegmentIndex = idx
        }
    }
    
    public override func constraintsViews() -> [String : UIView] {
        return ["titleLabel" : titleLabel, "segmentedControl" : segmentedControl]
    }
    
    public override func defaultVisualConstraints() -> [String] {
        if let text = titleLabel.text where !text.isEmpty {
            return ["H:|-16-[titleLabel]-16-[segmentedControl]-16-|"]
        }
        else {
            return ["H:|-16-[segmentedControl]-16-|"]
        }
    }
    
    /// MARK: Actions
    
    internal func valueChanged(sender: UISegmentedControl) {
        let options = rowDescriptor.configuration.options
        let optionValue = options?[sender.selectedSegmentIndex]
        rowDescriptor.value = optionValue
    }
    
    /// MARK: Private
    
    private func updateSegmentedControl() {
        segmentedControl.removeAllSegments()
        if let options = rowDescriptor.configuration.options {
            for (idx, optionValue) in options.enumerate() {
                segmentedControl.insertSegmentWithTitle(rowDescriptor.titleForOptionValue(optionValue), atIndex: idx, animated: false)
            }
        }
    }
}
