//
//  MyTagUlistViewController.swift
//  chocoed
//
//  Created by Tejal on 05/01/19.
//  Copyright © 2019 barkha sikka. All rights reserved.
//

import UIKit

class MyTagUlistViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
        @IBOutlet weak var tabelViewStickyList: UITableView!
    var arrayTagUlist = ["List1","List2"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: self.view.bounds)
        backgroundImage.image = UIImage(named: "background_pattern")
        backgroundImage.contentMode = UIViewContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backButton(_ sender: Any) {
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTagUlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "mytagu", for: indexPath) as! MytagUlistTableViewCell
        cell.gradiantImage.image = UIImage(named: "pin")
        cell.imagePin.image = UIImage(named: "pin")
        cell.labelName.text = arrayTagUlist[indexPath.row]
        cell.labelDiscription.text = "Sometext"
        
        return cell
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
