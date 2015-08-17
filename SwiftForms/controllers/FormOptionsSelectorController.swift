//
//  FormOptionsSelectorController.swift
//  SwiftForms
//
//  Created by Miguel Ángel Ortuño Ortuño on 23/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public class FormOptionsSelectorController: UITableViewController, FormSelector {

    /// MARK: FormSelector
    
    public var formCell = FormBaseCell()
    
    /// MARK: Init

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = formCell.rowDescriptor.title
    }
    
    /// MARK: UITableViewDataSource

    public override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        
        return formCell.rowDescriptor.configuration.options?.count ?? 0
    }
    
    public override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let reuseIdentifier = NSStringFromClass(self.dynamicType)
        
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: reuseIdentifier)
        }
        
        let options = formCell.rowDescriptor.configuration.options
        let optionValue = options?[indexPath.row]
        
        cell!.textLabel!.text = formCell.rowDescriptor.titleForOptionValue(optionValue!)
        
        if let selectedOptions = formCell.rowDescriptor.value as? [NSObject] {
            if (selectedOptions.indexOf(optionValue!) != nil) {
                
                if let checkMarkAccessoryView = formCell.rowDescriptor.configuration.checkmarkAccessoryView {
                    cell!.accessoryView = checkMarkAccessoryView
                }
                else {
                    cell!.accessoryType = .Checkmark
                }
            }
            else {
                cell!.accessoryType = .None
            }
        }
        else if let selectedOption = formCell.rowDescriptor.value {
            if optionValue == selectedOption {
                cell!.accessoryType = .Checkmark
            }
            else {
                cell!.accessoryType = .None
            }
        }
        return cell!
    }
    
    /// MARK: UITableViewDelegate
    
    public override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        var allowsMultipleSelection = false
        if let allowsMultipleSelectionValue = formCell.rowDescriptor.configuration.allowsMultipleSelection {
            allowsMultipleSelection = allowsMultipleSelectionValue
        }
        
        let options = formCell.rowDescriptor.configuration.options
        let optionValue = options?[indexPath.row]
        
        if allowsMultipleSelection {
            
            if formCell.rowDescriptor.value == nil {
                formCell.rowDescriptor.value = NSMutableArray()
            }
                        
            if let selectedOptions = formCell.rowDescriptor.value as? NSMutableArray {
                
                if selectedOptions.containsObject(optionValue!) {
                    selectedOptions.removeObject(optionValue!)
                    cell?.accessoryType = .None
                }
                else {
                    selectedOptions.addObject(optionValue!)
                    
                    if let checkmarkAccessoryView = formCell.rowDescriptor.configuration.checkmarkAccessoryView {
                        cell?.accessoryView = checkmarkAccessoryView
                    }
                    else {
                        cell?.accessoryType = .Checkmark
                    }
                }
                
                if selectedOptions.count > 0 {
                    formCell.rowDescriptor.value = selectedOptions
                }
                else {
                    formCell.rowDescriptor.value = nil
                }
            }
        }
        else {
            formCell.rowDescriptor.value = NSMutableArray(object: optionValue!)
        }
        
        formCell.update()
        
        if allowsMultipleSelection {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        else {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
}
