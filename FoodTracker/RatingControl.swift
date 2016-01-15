//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Shawn  on 18/11/15.
//  Copyright © 2015 Shawn . All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    //MARK: Properties
    var rating = 0 {
        didSet{
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    
    var emptyStar = UIImage(named: "emptyStar")
    var filledStar = UIImage(named: "filledStar")
    
    var spacing = 5
    var stars = 5
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        for _ in 0..<stars {
            let button = UIButton()
           
            button.setImage(emptyStar, forState: .Normal)
            button.setImage(filledStar, forState: .Selected)
            button.setImage(filledStar, forState: [.Highlighted, .Selected])
            button.adjustsImageWhenHighlighted = false
            
            button.addTarget(self, action: "ratingButton:", forControlEvents: .TouchDown)
            ratingButtons += [button]
            addSubview(button)
        }
    }
    
    override func layoutSubviews() {
        let buttonSize = (Int)(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        
        // Offset each button's origin by the length of the button plus spacing.
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        updateStars()
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize + spacing) * stars
        
        return CGSize(width: width, height: buttonSize)
    }
    
    // MARK: Actions
    func ratingButton(button: UIButton){
        rating = ratingButtons.indexOf(button)! + 1
        updateStars()
    }
    
    func updateStars(){
        // If the index of a button is less than the rating, that button should be selected.
        for(index,button) in ratingButtons.enumerate(){
            button.selected = index < rating
        }
    }
}
