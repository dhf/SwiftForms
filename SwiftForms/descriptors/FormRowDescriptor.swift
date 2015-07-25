//
//  FormRowDescriptor.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public enum FormRowType {
    case Unknown
    case Text
    case URL
    case Number
    case NumbersAndPunctuation
    case Decimal
    case Name
    case Phone
    case NamePhone
    case Email
    case Twitter
    case ASCIICapable
    case Password
    case Button
    case BooleanSwitch
    case BooleanCheck
    case SegmentedControl
    case Picker
    case Date
    case Time
    case DateAndTime
    case Stepper
    case Slider
    case MultipleSelector
    case MultilineText
}

public typealias DidSelectClosure = (Void) -> Void
public typealias UpdateClosure = (FormRowDescriptor) -> Void
public typealias TitleFormatterClosure = (NSObject) -> String
public typealias VisualConstraintsClosure = (FormBaseCell) -> [String]

public class FormRowDescriptor: NSObject {

    /// MARK: Properties
    
    public var title: String
    public var rowType: FormRowType = .Unknown
    public var tag: String
    
    public var value: NSObject? {
        willSet {
            if let willUpdateBlock = self.configuration.willUpdateClosure {
                willUpdateBlock(self)
            }
        }
        didSet {
            if let didUpdateBlock = self.configuration.didUpdateClosure {
                didUpdateBlock(self)
            }
        }
    }
    
    public var configuration = RowConfiguration()
    
    /// MARK: Init

    public init(tag: String, rowType: FormRowType, title: String, placeholder: String? = nil) {
        configuration.required = true
        configuration.allowsMultipleSelection = false
        configuration.showsInputToolbar = false

        self.tag = tag
        self.rowType = rowType
        self.title = title
        
        if let p = placeholder {
            configuration.placeholder = p
        }
    }
    
    /// MARK: Public interface
    
    public func titleForOptionAtIndex(index: Int) -> String {
        if let options = configuration.options {
            return titleForOptionValue(options[index])
        }
        return ""
    }
    
    public func titleForOptionValue(optionValue: NSObject) -> String {
        if let titleFormatter = configuration.titleFormatterClosure {
            return titleFormatter(optionValue)
        }
        else if let opt = optionValue as? String {
            return opt
        }
        return "\(optionValue)"
    }
}

public struct RowConfiguration {
    public var required: Bool?
    
    public var cellClass: FormBaseCell.Type?
    public var checkmarkAccessoryView: UIView?
    public var cellConfiguration: [String: NSObject]?
    
    public var placeholder: String?
    
    public var willUpdateClosure: UpdateClosure?
    public var didUpdateClosure: UpdateClosure?
    
    public var maximumValue: Double?
    public var minimumValue: Double?
    public var steps: Double?
    
    public var continuous: Bool?
    
    public var didSelectClosure: DidSelectClosure?
    
    public var visualConstraintsClosure: VisualConstraintsClosure?
    
    public var options: [NSObject]?
    
    public var titleFormatterClosure: TitleFormatterClosure?
    
    public var selectorControllerClass: FormSelector?
    
    public var allowsMultipleSelection: Bool?
    
    public var showsInputToolbar: Bool?
    
    public var dateFormatter: NSDateFormatter?
}
