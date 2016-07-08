

import UIKit

class ExpandableOption: ExpandableCellDescriptor, ExpandCellInformer {
    
    var delegate: ExpandableCellDelegate?
    
    var identifier: String!
    var active: Bool = false {
        didSet {
            delegate?.expandableCell(self, didChangeActive: active)
        }
    }
    
    var children: [CellDescriptor] = []
    
    var title: String?
    
    convenience init(identifier: String, title: String) {
        self.init()
        self.identifier = identifier
        self.title = title
    }
}