

import UIKit

class Option: CellDescriptor {
    
    var identifier: String!
    var title: String?
    var indentLevel: Int = 1
    
    convenience init(identifier: String, title: String) {
        self.init()
        self.identifier = identifier
        self.title = title
    }
}