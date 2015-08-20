//
//  FormSliderCell.swift
//  SwiftFormsApplication
//
//  Created by Miguel Angel Ortuno Ortuno on 23/5/15.
//  Copyright (c) 2015 Miguel Angel Ortuno Ortuno. All rights reserved.
//

public class FormSliderCell: FormTitleCell {
    
    /// MARK: Cell views
    
    public let sliderView = UISlider()
    
    public required init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .None
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(sliderView)
        
        titleLabel.setContentHuggingPriority(500, forAxis: .Horizontal)
        
        contentView.addConstraint(NSLayoutConstraint(item: sliderView, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        
        sliderView.addTarget(self, action: "valueChanged:", forControlEvents: .ValueChanged)
    }
    
    public override func update() {
        super.update()
        let config = rowDescriptor.configuration
        
        config.maximumValue.map { sliderView.maximumValue = Float($0) }
        config.minimumValue.map { sliderView.minimumValue = Float($0) }
        config.continuous.map { sliderView.continuous = $0 }
        
        titleLabel.text = rowDescriptor.title
        
        if let value = rowDescriptor.value as? Float {
            sliderView.value = value
        } else {
            sliderView.value = sliderView.minimumValue
            rowDescriptor.value = sliderView.minimumValue
        }
    }
    
    public override func constraintsViews() -> [String : UIView] {
        return ["titleLabel" : titleLabel, "sliderView" : sliderView]
    }
    
    public override func defaultVisualConstraints() -> [String] {
        return [
            "V:|[titleLabel]|",
            "H:|-16-[titleLabel]-16-[sliderView]-16-|"
        ]
    }
        
    internal func valueChanged(_: UISlider) {
        rowDescriptor.value = sliderView.value
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
