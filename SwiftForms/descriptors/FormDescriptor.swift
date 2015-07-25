//
//  FormDescriptor.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import Foundation

public class FormDescriptor: NSObject {

    public var title = ""
    public var sections: [FormSectionDescriptor] = []
    
    public func addSection(section: FormSectionDescriptor) {
        sections.append(section)
    }
    
    public func removeSection(section: FormSectionDescriptor) {
        if let index = find(sections, section) {
            sections.removeAtIndex(index)
        }
    }
    
    public func formValues() -> Dictionary<String, AnyObject> {

        var formValues: [String: AnyObject] = [:]

        for section in sections {
            for row in section.rows {
                if let val = row.value where row.rowType != .Button {
                    formValues[row.tag] = val
                }
            }
        }
        return formValues
    }
    
    public func validateForm() -> FormRowDescriptor! {
        for section in sections {
            for row in section.rows {
                if let required = row.configuration.required {
                    if required && row.value == nil {
                        return row
                    }
                }
            }
        }
        return nil
    }
}
