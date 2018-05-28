//
//  ViewController2.swift
//  Adding Dynamic Label In Table Cell
//
//  Created by Nitin Bhatia on 25/05/18.
//  Copyright © 2018 Nitin Bhatia. All rights reserved.
//

import UIKit
import ActiveLabel

class ViewControllerWithPod: UIViewController {
    @IBOutlet weak var lblTest: ActiveLabel!
    
    var text = "travel , madrid, Bunch Club, Crepes & Waffles, Royal Palace of Madrid, Almudena Cathedral, Spain, Test, Unitedt Airlines, #United, wer, kil, ghut, ghut pool"
    let tagIdStr = "55,119,301,302,303,304,305,98,78,56,34,34,54,890"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customType = ActiveType.custom(pattern: "(?:^|\\s|$)[\\p{L}0-9_ #&]*")
        lblTest.enabledTypes = [customType]
        lblTest.customColor[customType] = UIColor.blue
        
        lblTest.text = text
        lblTest.handleHashtagTap({hastag in print("\(hastag) tapped")})
        lblTest.handleCustomTap(for:customType){ element in
            print("customg type click \(element)")
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


