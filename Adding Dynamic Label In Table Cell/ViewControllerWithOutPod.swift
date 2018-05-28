//
//  ViewController2.swift
//  Adding Dynamic Label In Table Cell
//
//  Created by Nitin Bhatia on 25/05/18.
//  Copyright © 2018 Nitin Bhatia. All rights reserved.
//

import UIKit
import ActiveLabel

class ViewControllerWithOutPod: UIViewController {
    
    @IBOutlet weak var lblTest: UILabel!
    
    var text = "travel , madrid, Bunch Club, Crepes & Waffles, Royal Palace of Madrid, Almudena Cathedral, Spain, Test, My name is ios version 3, United Airlines, United, wer, kil, ghut, ghut pool"
    let tagIdStr = "55,119,301,302,303,304,305,98,78,56,34,34,54,890,87"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        lblTest.text = text.trimmingCharacters(in: .whitespaces)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapLabel(gesture:)))
        lblTest.addGestureRecognizer(tapGesture)
        lblTest.isUserInteractionEnabled = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        //let text = (lblTest.text)!
        
        let lbl = gesture.view as! UILabel
        let text = lbl.text!
        
        let temp = text.components(separatedBy: ",")
        let pol = tagIdStr.components(separatedBy: ",")
        var x : [String:String] = [:]
        
        for (index,i) in temp.enumerated() {
            x[i] = pol[index]
        }
        
        
        for (index,i) in temp.enumerated(){
            
            let termsRange = (text.trimmingCharacters(in: .whitespaces) as NSString).range(of: i)
            if gesture.didTapAttributedTextInLabel(label: lblTest, inRange: termsRange) {
                print(i)
                print(pol[index])
                break
            }
        }
        
    }
    
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        
        let textContainerOffset = CGPoint(x:(labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,y:(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x:locationOfTouchInLabel.x - textContainerOffset.x,y: locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}

