//
//  FormCheckCell.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 22/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public class FormCheckCell: FormTitleCell {

    /// MARK: FormBaseCell
    
    public override func configure() {
        super.configure()
        selectionStyle = .Default
        accessoryType = .None
    }
    
    public override func update() {
        super.update()
        
        titleLabel.text = rowDescriptor.title

        if let checkMk = rowDescriptor.value as? Bool where checkMk == true {
            accessoryType = .Checkmark
        } else {
            accessoryType = .None
        }
    }
    
    public override class func formViewController(formViewController: FormViewController, didSelectRow selectedRow: FormBaseCell) {
        if let row = selectedRow as? FormCheckCell {
            row.check()
        }
    }
    
    /// MARK: Private interface

    private func check() {
        rowDescriptor.value = (rowDescriptor.value as? Bool).map { !$0 } ?? true
        accessoryType = (rowDescriptor.value as! Bool) ? .Checkmark : .None
    }
}
