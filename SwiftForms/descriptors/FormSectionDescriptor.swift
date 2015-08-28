//
//  FormSectionDescriptor.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import Foundation

public class FormSectionDescriptor: NSObject {
    
    public var headerTitle: String
    public var footerTitle: String
    public var rows: [FormRowDescriptor] = []
    
    public init(headerTitle: String = "", footerTitle: String = "") {
        self.headerTitle = headerTitle
        self.footerTitle = footerTitle
    }
    
    public func addRow(row: FormRowDescriptor) {
        rows.append(row)
    }
    
    public func removeRow(row: FormRowDescriptor) {
        if let index = rows.indexOf(row) {
            rows.removeAtIndex(index)
        }
    }
}

public func +(section: FormSectionDescriptor, row: FormRowDescriptor) -> FormSectionDescriptor {
    section.addRow(row)
    return section
}
