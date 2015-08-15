//
//  FormTextViewCell.swift
//  SwiftForms
//
//  Created by Joey Padot on 12/6/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public class FormTextViewCell : FormBaseCell, FormFontDefaults, UITextViewDelegate {

    /// MARK: Cell views
    
    public let titleLabel = UILabel()
    public let textField = UITextView()
    
    /// MARK: Properties
    
    private var customConstraints: [AnyObject] = []
    
    /// MARK: Class Funcs
    public override class func formRowCellHeight() -> CGFloat {
        return 110.0
    }
    
    /// MARK: FormBaseCell
    
    public override func configure() {
        super.configure()
        
        selectionStyle = .None
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = titleLabelFont()
        textField.font = textFieldFont()
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
        
        titleLabel.setContentHuggingPriority(500, forAxis: .Horizontal)
        
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: contentView, attribute: .Height, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: textField, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: textField, attribute: .Bottom, relatedBy: .Equal, toItem: contentView, attribute: .Bottom, multiplier: 1.0, constant: 0.0))
        
        textField.delegate = self
    }
    
    public override func update() {
        
        titleLabel.text = rowDescriptor.title
        textField.text = rowDescriptor.value as? String
        
        textField.secureTextEntry = false
        textField.autocorrectionType = .Default
        textField.autocapitalizationType = .Sentences
        textField.keyboardType = .Default
    }
    
    public override func constraintsViews() -> [String : UIView] {
        var views = ["titleLabel" : titleLabel, "textField" : textField]
        if let _ = imageView?.image {
            views["imageView"] = imageView
        }
        return views
    }
    
    public override func defaultVisualConstraints() -> [String] {
        switch (self.imageView?.image, self.titleLabel.text) {
        case (.Some, .Some(let t)) where !t.isEmpty:
            return ["H:[imageView]-[titleLabel]-[textField]-16-|"]
        case (.Some, .None):
            return ["H:[imageView]-[textField]-16-|"]
        case (.None, .Some(let t)) where !t.isEmpty:
            return ["H:|-16-[titleLabel]-[textField]-16-|"]
        default:
            return ["H:|-16-[textField]-16-|"]
        }
    }
    
    /// MARK: UITextViewDelegate
    
    public func textViewDidChange(textView: UITextView) {
        let trimmedText = textView.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        rowDescriptor.value = trimmedText.characters.count > 0 ? trimmedText : nil
    }
}
