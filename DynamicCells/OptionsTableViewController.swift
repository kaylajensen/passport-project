

import UIKit
import Firebase
import FirebaseDatabase


class OptionsTableViewController: UITableViewController, ExpandableCellDelegate {
    var options = CellDescriptionArray()
    var ref: FIRDatabaseReference!
    
    var currentRow : Int = 0
    var nodes : [String] = []
    var myNodes = [Nodes]()
    var children : [Int] = [0]
    var nodeName : String = ""
    var upper = 0
    var lower = 0
    var numKids = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        ref = FIRDatabase.database().reference()
        
        tableView.reloadData()
        
        tableView.tableFooterView = UIView()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let o = CellDescriptionArray()
        options = o
        let noo = [Nodes]()
        myNodes = noo
        
        ref.child("root").observeEventType(.ChildAdded, withBlock: { snapshot in
            print("\(snapshot.value!.objectForKey("title") as! String)")
            self.nodes.append(snapshot.value!.objectForKey("title") as! String)
            let n = Nodes(nodeName: snapshot.value!.objectForKey("title") as! String, upperBound: snapshot.value!.objectForKey("upper") as! Int, lowerBound: snapshot.value!.objectForKey("lower") as! Int, key: snapshot.value!.objectForKey("key") as! String)
            
            let base = ExpandableOption(identifier: "ExpandableCell", title: (n.getNodeName()))
            if let x = snapshot.value!.objectForKey("children") as? [Int] {
                n.children = x
                for i in 0...x.count-1 {
                    let inner = Option(identifier: "SimpleCell", title: String(x[i]))
                    base.append(inner)
                }
            }
            else {
                self.children = [0]
                n.children = self.children
            }
            self.options.append(base)
            self.myNodes.append(n)
            self.tableView.reloadData()
            
        })
    }
    
    
    @IBAction func createNodeButton(sender: AnyObject) {
        var alertController:UIAlertController?
        alertController = UIAlertController(title: "Create New Factory",
                                            message: "Enter Factory Name and Upper/Lower Bounds",
                                            preferredStyle: .Alert)
        
        alertController!.addTextFieldWithConfigurationHandler(
            {(textField: UITextField!) in
                textField.placeholder = "Factory Name"
        })
        alertController!.addTextFieldWithConfigurationHandler(
            {(textField: UITextField!) in
                textField.placeholder = "Upper Bound"
        })
        alertController!.addTextFieldWithConfigurationHandler(
            {(textField: UITextField!) in
                textField.placeholder = "Lower Bound"
        })
        
        let action = UIAlertAction(title: "Submit",
                                   style: UIAlertActionStyle.Default,
                                   handler: {//[weak self]
                                    (paramAction:UIAlertAction!) in
                                    if let textFields = alertController?.textFields{
                                        let theTextFields = textFields as [UITextField]
                                        self.nodeName = String(theTextFields[0].text!)
                                        self.upper = Int(theTextFields[1].text!)!
                                        self.lower = Int(theTextFields[2].text!)!
                                        self.createNode()
                                        
                                        self.tableView.reloadData()
                                        //self.viewWillAppear(true)
                                        print("here")
                                    }
        })
        
        alertController?.addAction(action)
        self.presentViewController(alertController!,
                                   animated: true,
                                   completion: nil)
       
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let option = options[indexPath.row]!
        let cell = tableView.dequeueReusableCellWithIdentifier(option.identifier, forIndexPath: indexPath)
        
        (cell as! CellDescrptionConfigurable).tapBlock = {
            print("button tapped")
            var alertController:UIAlertController?
            alertController = UIAlertController(title: "Edit Factory",
                                                message: "Enter Number of Nodes",
                                                preferredStyle: .Alert)
            
            alertController!.addTextFieldWithConfigurationHandler(
                {(textField: UITextField!) in
                    textField.placeholder = "Number of Nodes (Max 15)"
            })
            
            let action1 = UIAlertAction(title: "Add",
                                        style: UIAlertActionStyle.Default,
                                        handler: {//[weak self]
                                            (paramAction:UIAlertAction!) in
                                            if let textFields = alertController?.textFields{
                                                let theTextFields = textFields as [UITextField]
                                                self.numKids = Int(theTextFields[0].text!)!
                                                self.dismissViewControllerAnimated(true, completion: nil)
                                                print("\(self.numKids)")
                                                
                                                if self.numKids > 15 || self.numKids < 1 {
                                                    var alertController:UIAlertController?
                                                    alertController = UIAlertController(title: "Error",
                                                        message: "Enter Up to 15 Children",
                                                        preferredStyle: .Alert)
                                                    let action = UIAlertAction(title: "OK",
                                                        style: UIAlertActionStyle.Default,
                                                        handler: nil)
                                                    alertController?.addAction(action)
                                                    self.presentViewController(alertController!,
                                                        animated: true,
                                                        completion: nil)
                                                }
                                                else {
                                                    self.createKids(indexPath.row)
                                                    self.tableView.reloadData()
                                                }
                                            }
            })
            let action2 = UIAlertAction(title: "Edit",
                                        style: UIAlertActionStyle.Default,
                                        handler: {//[weak self]
                                            (paramAction:UIAlertAction!) in
                                            self.dismissViewControllerAnimated(true, completion: nil)
                                            self.editFactory(indexPath.row)
                                            self.tableView.reloadData()
            })
            let action3 = UIAlertAction(title: "Delete",
                                        style: UIAlertActionStyle.Default,
                                        handler: {//[weak self]
                                            (paramAction:UIAlertAction!) in
                                            self.dismissViewControllerAnimated(true, completion: nil)
                                            self.childRemoved(indexPath.row)
                                            self.viewWillAppear(true)
                                            self.tableView.reloadData()
            })
            
            alertController?.addAction(action1)
            alertController?.addAction(action2)
            alertController?.addAction(action3)
            self.presentViewController(alertController!,
                                       animated: true,
                                       completion: nil)
        }
        (cell as! CellDescrptionConfigurable).cellDescription = option
        
        if option.identifier == "ExpandableCell" {
            let low = myNodes[indexPath.row].getLowerBound()
            let high = myNodes[indexPath.row].getUpperBound()
            (cell as! CellDescrptionConfigurable).lower = low
            (cell as! CellDescrptionConfigurable).upper = high
        }
        
        (option as? ExpandCellInformer)?.delegate = self

        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let option = options[indexPath.row] else { return }
        guard let expandableOption = option as? ExpandableOption else { return }
        if expandableOption.identifier == "ExpandableCell" {
            expandableOption.active = !expandableOption.active
        }
    }
    
    func expandableCell(expandableCell: ExpandableCellDescriptor, didChangeActive active: Bool) {
        guard let index = options.indexOf(expandableCell) else { return }
        var indexPaths = [NSIndexPath]()
        for row in 1..<expandableCell.countIfActive {
            indexPaths.append(NSIndexPath(forRow: index + row, inSection: 0))
        }
        if active {
            tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Fade)
        } else {
            tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Fade)
        }
        
    }
    
    func createNode() {
        let key = ref.child("root").childByAutoId().key
        let node = ["title": nodeName,
                    "upper": upper,
                    "lower": lower,
                    "children": children,
                    "key": key]
        let childUpdates = ["root/\(key)": node]
        ref.updateChildValues(childUpdates)
        
        tableView.reloadData()
    }
    
    func createKids(index: Int) {
        myNodes[index].generateChildren(numKids)
        myNodes[index].printChildren()
        
        
        children = myNodes[index].children
        let key = myNodes[index].key
        let childUpdates = ["root/\(key)/children": children]
        ref.updateChildValues(childUpdates)
        self.viewWillAppear(true)
        tableView.reloadData()
    }
    
    func editFactory(index: Int) {
        print("makes it index: \(index)")
        var alertController:UIAlertController?
        alertController = UIAlertController(title: "Edit Bounds",
                                            message: "Enter Upper/Lower Bounds",
                                            preferredStyle: .Alert)
        alertController!.addTextFieldWithConfigurationHandler(
            {(textField: UITextField!) in
                textField.placeholder = "Upper Bound"
        })
        alertController!.addTextFieldWithConfigurationHandler(
            {(textField: UITextField!) in
                textField.placeholder = "Lower Bound"
        })
        
        let action = UIAlertAction(title: "Submit",
                                   style: UIAlertActionStyle.Default,
                                   handler: {//[weak self]
                                    (paramAction:UIAlertAction!) in
                                    if let textFields = alertController?.textFields{
                                        let theTextFields = textFields as [UITextField]
                                        self.upper = Int(theTextFields[0].text!)!
                                        self.lower = Int(theTextFields[1].text!)!
                                        print("\(self.upper) \(self.lower)")
                                        self.editFactoryBounds(index)
                                    }
        })
        
        alertController?.addAction(action)
        self.presentViewController(alertController!,
                                   animated: true,
                                   completion: nil)
        self.viewWillAppear(true)
        tableView.reloadData()
    }
    
    func editFactoryBounds(index: Int) {
        myNodes[index].setUpper(upper)
        myNodes[index].setLower(lower)
        
        let key = myNodes[index].key
        
        let noKids : [Int] = []
        myNodes[index].children = noKids
        
        let childUpdates = ["root/\(key)/upper": upper,
                            "root/\(key)/lower": lower,
                            "root/\(key)/children": noKids]
        
        ref.updateChildValues(childUpdates as [NSObject : AnyObject])
        self.viewWillAppear(true)
        self.tableView.reloadData()
    }
    
    func childRemoved(index: Int) {
        let key = myNodes[index].key
        print("key \(key)")
        ref.child("root/\(key)").removeValue()
        //myNodes.removeAtIndex(index)
        //self.viewWillAppear(true)
        //tableView.reloadData()
    }


}
