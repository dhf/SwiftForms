//
//  FormPickerCell.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 22/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public class FormPickerCell: FormValueCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    /// MARK: Properties
    
    private let picker = UIPickerView()
    private let hiddenTextField = UITextField(frame: CGRectZero)
    
    /// MARK: FormBaseCell
    
    public override func configure() {
        super.configure()
        accessoryType = .None
        
        picker.delegate = self
        picker.dataSource = self
        hiddenTextField.inputView = picker
        
        contentView.addSubview(hiddenTextField)
    }
    
    public override func update() {
        super.update()
        
        titleLabel.text = rowDescriptor.title
        
        if let value = rowDescriptor.value {
            valueLabel.text = rowDescriptor.titleForOptionValue(value)
            if let options = rowDescriptor.configuration.options,
               let index = find(options, value) {
                picker.selectRow(index, inComponent: 0, animated: false)
            }
        }
    }

    public override class func formViewController(formViewController: FormViewController, didSelectRow selectedRow: FormBaseCell) {
        if let row = selectedRow as? FormPickerCell {
            if let optionValue = selectedRow.rowDescriptor.value {
                row.valueLabel.text = selectedRow.rowDescriptor.titleForOptionValue(optionValue)
            } else if let optionValue = selectedRow.rowDescriptor.configuration.options?.first {
                selectedRow.rowDescriptor.value = optionValue
                row.valueLabel.text = selectedRow.rowDescriptor.titleForOptionValue(optionValue)
            }
            row.hiddenTextField.becomeFirstResponder()
        }
    }

    /// MARK: UIPickerViewDelegate
    
    public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        return rowDescriptor.titleForOptionAtIndex(row)
    }
    
    public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let optionValue = rowDescriptor.configuration.options?[row] {
            rowDescriptor.value = optionValue
            valueLabel.text = rowDescriptor.titleForOptionValue(optionValue)
        }
    }
    
    /// MARK: UIPickerViewDataSource
    
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return maybe(defaultValue: 0, rowDescriptor.configuration.options?.count) { $0 }
    }
}
