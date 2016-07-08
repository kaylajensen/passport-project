

import UIKit

class SimpleTableViewCell: UITableViewCell, CellDescrptionConfigurable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    
    var cellDescription: CellDescriptor! {
        didSet {
            if let option = cellDescription as? Option {
                titleLabel.text = option.title
                leftConstraint.constant = CGFloat(option.indentLevel) * 20.0
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

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
