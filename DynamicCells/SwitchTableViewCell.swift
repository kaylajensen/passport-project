

import UIKit

class SwitchTableViewCell: UITableViewCell, CellDescrptionConfigurable {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var cellDescription: CellDescriptor! {
        didSet {
            if let option = cellDescription as? ExpandableOption {
                titleLabel.text = option.title
                
            }
        }
    }
    var lower: Int! {
        didSet {
            
        }
    }
    var upper: Int! {
        didSet {
            
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

    @IBAction func activeChanged(sender: UISwitch) {
        let expandableCellDescriptor = cellDescription as! ExpandableCellDescriptor
        expandableCellDescriptor.active = sender.on
    }

}
