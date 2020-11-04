import UIKit

class FruitTableViewController: UITableViewController {
    
    var FruitNames = ["Watermelon🍉","Apple🍎","Orange🍊", "Strawberry🍓", "Peer🍐"]
    
    var FruitPrices =
        ["💰500", "💰100", "💰90", " 💰200", "💰150"]
    
    var CalPrices = [500,100,90,200,150]
    
    var FruitImages = ["Watermelon","Apple","Orange","Strawberry","Pear"]
    
    var FruitIsVisited = Array(repeating: false, count: 5)
    
    @IBOutlet var totalLabel: UILabel!
    
    //放入待計算的價錢
    var add = [Int]()
    func calculate (be_calculate:[Int]) -> (Int)
    {
        var total = 0
        
        if add.count == 0
        {
            return 0
        }
        else
        {
            for i in 0...add.count-1
            {
                total += add[i]
            }
            return total
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return FruitNames.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)as! FruitTableViewCell
        
        // Configure the cell...
        cell.namesLabel.text = FruitNames[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named: FruitImages[indexPath.row])
        cell.pricesLabel.text = FruitPrices[indexPath.row]
        
        if FruitIsVisited[indexPath.row] {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        cell.accessoryType = FruitIsVisited[indexPath.row] ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Create an option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "What do you want to buy ?", preferredStyle: .actionSheet)
        
        // Add actions to the menu
        let cancelAction = UIAlertAction(title: "Cancel 🔧", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        // Display the menu
        present(optionMenu, animated: true, completion: nil)
        
        // Check-in action
        let checkInAction = UIAlertAction(title: "I want to buy this ❤️", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
            self.FruitIsVisited[indexPath.row] = true
            
            //計算總價（丟進函式）
            let temp = self.CalPrices[indexPath.row]
            self.add.append(temp)
            let ans = self.calculate(be_calculate: self.add)
            self.totalLabel.text = "💎 Total Prices = " + String(ans)
        })
        optionMenu.addAction(checkInAction)
        
        
        //Undo Check-in action
        let UndocheckInAction = UIAlertAction(title: "I don't want this 💔", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            
            let cell = tableView.cellForRow(at: indexPath)
            if self.FruitIsVisited[indexPath.row]{
                cell?.accessoryType = .none
                self.FruitIsVisited[indexPath.row] = false
                
                let temp = self.CalPrices[indexPath.row]
                
                for i in 0...self.add.count-1
                 {
                    if self.add[i] == temp
                    {
                        self.add[i] = 0
                    }
                 }
                 let ans = self.calculate(be_calculate: self.add)
                 self.totalLabel.text = "💎 Total Prices = " + String(ans)
                
            }
            
            //扣除該物品價錢（丟進函式）
 
        })
        optionMenu.addAction(UndocheckInAction)
        // Deselect a row
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
