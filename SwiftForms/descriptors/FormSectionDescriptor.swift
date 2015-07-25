//
//  FormSectionDescriptor.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import Foundation

public class FormSectionDescriptor: NSObject {
    
    public var headerTitle = ""
    public var footerTitle = ""
    public var rows: [FormRowDescriptor] = []
    
    public func addRow(row: FormRowDescriptor) {
        rows.append(row)
    }
    
    public func removeRow(row: FormRowDescriptor) {
        if let index = rows.indexOf(row) {
            rows.removeAtIndex(index)
        }
    }
}
