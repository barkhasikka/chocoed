//
//  VC3ViewController.swift
//  chocoed
//
//  Created by Tejal on 17/12/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class VC3ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func doneButtonAction(_ sender: Any) {
        
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "firstview") as! ViewController
        self.present(nextVC, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
