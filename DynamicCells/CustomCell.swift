//
//  CustomCell.swift
//  PassportProject
//
//  Created by Kayla Jensen on 7/6/16.
//  Copyright © 2016 kaylajensencoding. All rights reserved.


import UIKit


class CustomCell {
    
    var tapBlock: dispatch_block_t?
    var kidArr : [Int] = []
    
    @IBOutlet weak var cellLabel: UILabel!
    
    @IBOutlet weak var upperBoundLabel: UILabel!
    
    @IBOutlet weak var lowerBoundLabel: UILabel!
    
    @IBAction func settingsButtonDidTouch(sender: AnyObject) {
        
        if let tapBlock = self.tapBlock {
            tapBlock()
        }
    }
    //    required init?(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //        setUpTable()
    //    }
    //    required init(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //        setUpTable()
    //    }
    //    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    //        super.init(style: style , reuseIdentifier: reuseIdentifier)
    //        setUpTable()
    //    }
    //    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    //        super.init(style: style , reuseIdentifier: reuseIdentifier)
    //        setUpTable()
    //    }
    //
    //    required init?(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    //    override func awakeFromNib() {
    //        super.awakeFromNib()
    //        // Initialization code
    //        setUpTable()
    //    }
    //    func setUpTable() {
    //        subTable = UITableView(frame: CGRectZero, style:UITableViewStyle.Plain)
    //        subTable!.delegate = self
    //        subTable!.dataSource = self
    //        self.addSubview(subTable!)
    //    }
    //    override func layoutSubviews() {
    //        super.layoutSubviews()
    //        subTable?.frame = CGRectMake(0.2, 0.3, self.bounds.size.width-5, self.bounds.size.height-5)
    //    }
    //    override func setSelected(selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //
    //        // Configure the view for the selected state
    //    }
    //
    //    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return kidArr.count
    //    }
    //
    //    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    //        return 1
    //    }
    //
    //    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    //
    //        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("cellID")
    //
    //        if(cell == nil){
    //            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cellID")
    //        }
    //        
    //        cell?.textLabel?.text = String(kidArr[indexPath.row])
    //        
    //        return cell!
    //    }
    
    
}
