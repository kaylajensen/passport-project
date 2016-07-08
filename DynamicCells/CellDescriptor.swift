

import Foundation

protocol CellDescriptor: class {
    var count: Int { get }
    var identifier: String! { get }
}

/// The default value for a non expandable cell should always be 1
extension CellDescriptor {
    var count: Int { return 1 }
}

/// Base protocol for any cell that contains children and can be expanded
protocol ExpandableCellDescriptor: CellDescriptor {
    var active: Bool { get set }
    var children: [CellDescriptor] { get set }
    
    subscript(index: Int) -> CellDescriptor? { get }
    func indexOf(cellDescriptor: CellDescriptor) -> Int?
}

/// Any class that conforms to ExpandibleCellDescriptor has a default implementation of: 
/// count, countIfActive, subscript(index:) and indexOf(cellDescriptor:)
extension ExpandableCellDescriptor {
    var count: Int {
        var total = 1
        if active {
            children.forEach({ total += $0.count })
        }
        return total
    }
    
    var countIfActive: Int {
        var total = 1
        children.forEach({ total += $0.count })
        return total
    }
    
    subscript(index: Int) -> CellDescriptor? {
        var total = 0
        for cell in children {
            if index == total {
                return cell
            }
            if let expandableCell = cell as? ExpandableCellDescriptor {
                if expandableCell.active {
                    if let indexCell = expandableCell[index - total - 1] {
                        return indexCell
                    }
                }
            }
            total += cell.count
        }
        return nil
    }
    
    func indexOf(cellDescriptor: CellDescriptor) -> Int? {
        if self === cellDescriptor { return 0 }
        var total = 1
        for cell in children {
            if cell === cellDescriptor {
                return total
            }
            if let expandableCell = cell as? ExpandableCellDescriptor {
                if expandableCell.active {
                    if let index = expandableCell.indexOf(cellDescriptor) {
                        return total + index
                    }
                }
            }
            total += cell.count
        }
        return nil
    }

    func append(cellDescriptor: CellDescriptor) {
        children.append(cellDescriptor)
    }
}

protocol CellDescrptionConfigurable: class {
    var cellDescription: CellDescriptor! { get set }
    var lower : Int! { get set }
    var upper : Int! { get set }
    var tapBlock: dispatch_block_t? { get set }
}

protocol ExpandableCellDelegate {
    func expandableCell(expandableCell: ExpandableCellDescriptor, didChangeActive active: Bool)
}

protocol ExpandCellInformer: class {
    var delegate: ExpandableCellDelegate? { get set }
}

class CellDescriptionArray: ExpandableCellDescriptor {
    var active = true
    var children: [CellDescriptor] = []
    var identifier: String! = ""
    
    var count: Int {
        if !active { return 0 }
        var total = 0
        children.forEach({ total += $0.count })
        return total
    }
    
    func indexOf(treeCell: CellDescriptor) -> Int? {
        var total = 0
        for cell in children {
            if cell === treeCell {
                return total
            }
            if let expandableCell = cell as? ExpandableCellDescriptor {
                if expandableCell.active {
                    if let index = expandableCell.indexOf(treeCell) {
                        return total + index
                    }
                }
            }
            total += cell.count
        }
        return nil
    }
}
