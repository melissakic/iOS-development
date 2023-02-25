//
//  CustomCell.swift
//  TODO list
//
//  Created by Melis on 2. 12. 2022..
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var CellTime: UILabel!
    @IBOutlet weak var CellName: UILabel!
    @IBOutlet weak var CellView: UIView!
    @IBOutlet weak var CheckedBox: UIImageView!
    @IBOutlet weak var Box: UIImageView!
    @IBOutlet weak var CellButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    @IBAction func button(_ sender: UIButton) {
        
        if Box.alpha == 1 {
            CheckedBox.alpha=1
            Box.alpha=0
            CellTime.alpha=0
                CellName.attributedText=returnEditedLabel(label: CellName, option: 1)
        }
        else {
            CellName.attributedText=returnEditedLabel(label: CellName, option: 0)
            CellTime.alpha=1
            Box.alpha=1
            CheckedBox.alpha=0
        }
    }
    
    // Strikethrough edit for task labels
    func returnEditedLabel(label:UILabel,option:Int)->NSMutableAttributedString{
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string:label.text! )
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        
        let TaskName:NSMutableAttributedString = NSMutableAttributedString(string:label.text! )
        TaskName.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 0, range: NSRange(location: 0, length: TaskName.length))
        if option==1 {return attributeString}
        return TaskName
    }
}
