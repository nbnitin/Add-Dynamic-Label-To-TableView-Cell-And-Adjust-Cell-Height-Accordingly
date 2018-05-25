//
//  ViewController.swift
//  Adding Dynamic Label In Table Cell
//
//  Created by Nitin Bhatia on 23/05/18.
//  Copyright © 2018 Nitin Bhatia. All rights reserved.
//

import UIKit

let height : CGFloat = 25


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tbl: UITableView!
    let tagStr = "travel ,madrid,Bunch Club,Crepes & Waffles,Royal Palace of Madrid,Almudena Cathedral,Spain,Test,United Airlnes,United"
    let tagIdStr = "55,119,301,302,303,304,305,98,1,32"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.tableFooterView = UIView()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TagTableViewCell
        let tagTitle = tagStr.components(separatedBy: ",")
        let tagId = tagIdStr.components(separatedBy: ",")
        var initialX : CGFloat = 9
        var initialY : CGFloat = (cell.lblTag.frame.height)
        let oldX : CGFloat = 9
        var oldY : CGFloat = height
        var totalWidth : CGFloat = 0
        
        for (index,i) in tagTitle.enumerated() {
            let lbl = UILabel()
            lbl.frame = CGRect.zero
            let testString =  NSString(string: (i+",").trimmingCharacters(in: .whitespaces))
            
            let size = CGSize(width:.greatestFiniteMagnitude,height:21.0)
            
            let attribute = [NSAttributedStringKey.font:UIFont.systemFont(ofSize:17)]
            let estimatedFrame = testString.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attribute, context: nil)
            
            let temp = totalWidth - initialX
            let cal =  self.view.frame.width - temp
            
            if ( cal <= estimatedFrame.width){
                initialX = oldX
                initialY = oldY+height
                oldY = initialY
                totalWidth = 0
            }
            
            lbl.frame.origin = CGPoint(x:initialX,y:initialY)
            lbl.frame.size.width = estimatedFrame.width
            lbl.frame.size.height = height
            lbl.tag = Int(tagId[index])!
            print("i am tag \(tagId[index])")
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openArticleFromTag))
            lbl.addGestureRecognizer(tapGesture)
            lbl.isUserInteractionEnabled = true
            initialX = estimatedFrame.width + initialX
            totalWidth += initialX
            
            if ( index < tagTitle.count - 1 ) {
                lbl.text = i + ","
            } else {
                lbl.text = i
            }
            cell.contentView.addSubview(lbl)
        }
            
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var rows : CGFloat = 2
        
        let tt = tagStr.components(separatedBy: ",")
        var initialX : CGFloat = 9
        var initialY : CGFloat = height
        let oldX : CGFloat = 9
        var oldY : CGFloat = height
        var totalWidth : CGFloat = 0
        
        for i in tt {
            let lbl = UILabel()
            lbl.frame = CGRect.zero
            let testString =  NSString(string: (i+",").trimmingCharacters(in: .whitespaces))
            
            let size = CGSize(width:.greatestFiniteMagnitude,height:21.0)
            
            let attribute = [NSAttributedStringKey.font:UIFont.systemFont(ofSize:17)]
            let estimatedFrame = testString.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attribute, context: nil)
            
            
            if (totalWidth >= self.view.frame.width){
                initialX = oldX
                initialY = oldY+height
                oldY = initialY
                totalWidth = 0
                rows = rows + 1
            }
            initialX = estimatedFrame.width + initialX
            totalWidth += initialX
            
        }
        return rows * height
    }
    
    //Mark:- Tag label gesture handler
    @objc func openArticleFromTag(_ sender:UIGestureRecognizer){
        let lbl = sender.view as! UILabel
        
        print(lbl.text?.replacingOccurrences(of: ",", with: ""))
        print(lbl.tag)
    }

}

