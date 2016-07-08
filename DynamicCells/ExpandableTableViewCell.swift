

import UIKit

class ExpandableTableViewCell: UITableViewCell, CellDescrptionConfigurable {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func settingsButton(sender: AnyObject) {
        if let tapBlock = self.tapBlock {
            tapBlock()
        }
    }
    
    @IBOutlet weak var upperBLabel: UILabel!
    
    @IBOutlet weak var lowerBLabel: UILabel!

    
    var cellDescription: CellDescriptor! {
        didSet {
            if let option = cellDescription as? ExpandableOption {
                titleLabel.text = option.title
                
            }
        }
    }
    var lower: Int! {
        didSet {
            lowerBLabel.text = "Lower: " + String(lower)
            
        }
    }
    var upper: Int! {
        didSet {
            upperBLabel.text = "Upper: " + String(upper)
            
        }
    }
    var tapBlock: dispatch_block_t? {
        didSet {
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
