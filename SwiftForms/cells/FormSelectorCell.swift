//
//  FormSelectorCell.swift
//  SwiftForms
//
//  Created by Miguel Ángel Ortuño Ortuño on 23/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public class FormSelectorCell: FormValueCell {
    
    /// MARK: FormBaseCell
    
    public override func update() {
        super.update()
        
        titleLabel.text = rowDescriptor.title
        
        var title = ""
        
        if let selectedValues = rowDescriptor.value as? [NSObject], // multiple values
           let options = rowDescriptor.configuration.options {
               let strs = options.filter { selectedValues.contains($0) }.map { rowDescriptor.titleForOptionValue($0) }
               title = strs.join(", ")
        } else if let selectedValue = rowDescriptor.value { // single value
            title = rowDescriptor.titleForOptionValue(selectedValue)
        }
        
        if !title.isEmpty {
            valueLabel.text = title
            valueLabel.textColor = UIColor.blackColor()
        }
        else {
            valueLabel.text = rowDescriptor.configuration.placeholder
            valueLabel.textColor = UIColor.lightGrayColor()
        }
    }
    
    public override class func formViewController(formViewController: FormViewController, didSelectRow selectedRow: FormBaseCell) {
        if let row = selectedRow as? FormSelectorCell {
            
            formViewController.view.endEditing(true)
            
            let selectorController: UIViewController

            if let selectorControllerClass = row.rowDescriptor.configuration.selectorControllerClass as? UIViewController.Type {
                selectorController = selectorControllerClass.init()
            }
            else { // fallback to default cell class
                selectorController = FormOptionsSelectorController()
            }
            
            // the type of `selectorControllerClass` is `FormSelector`, therefore:
            // `selectorController` is guaranteed to conform to `FormSelector`
            (selectorController as! FormSelector).formCell = row
            formViewController.navigationController?.pushViewController(selectorController, animated: true)
        }
    }
}
