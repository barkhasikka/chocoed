//
//  NominationViewController.swift
//  chocoed
//
//  Created by Tejal on 03/01/19.
//  Copyright © 2019 barkha sikka. All rights reserved.
//

import UIKit
import DropDown

class NominationViewController: UIViewController {

    @IBOutlet weak var mobileNo: UITextField!
    @IBOutlet weak var mobNoLabel: UILabel!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var selectPollButton: imagetoButton!
    @IBOutlet weak var OrLabel: UILabel!
    @IBOutlet weak var NominateButton: imagetoButton!
    @IBOutlet weak var selectLangButton: UIButton!
    @IBOutlet weak var SelectOcupButton: UIButton!
    @IBOutlet weak var govtIdText: UITextField!
    @IBOutlet weak var govtIdLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var LastNameText: UITextField!
    @IBOutlet weak var firstnameText: UITextField!
    @IBOutlet weak var lastNameOutlet: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var labelHeaderOutlet: UILabel!
    var tableViewData = ["1","2","3"]
    var dropDown: DropDown!

    override func viewDidLoad() {
        super.viewDidLoad()

        firstnameText.setBottomBorder()
        LastNameText.setBottomBorder()
        ageText.setBottomBorder()
        govtIdText.setBottomBorder()
        mobileNo.setBottomBorder()
        
        dropDown = DropDown()
        dropDown.direction = .any
        dropDown.dismissMode = .automatic
        dropDown.hide()
        // Do any additional setup after loading the view.
    }
    @IBAction func SelectLanguage(_ sender: Any) {
        self.view.endEditing(true)
        
        //        for qualify in self.educationLevel1{
        //            tableViewData.append((qualify.name))
        //        }
        //        currentSelectedButton = "Qualification"
        dropDown.show()
        dropDown.anchorView = selectLangButton
        dropDown.dataSource = tableViewData

    }
    
    @IBAction func SelectOccupation(_ sender: Any) {
        self.view.endEditing(true)
        
//        for qualify in self.educationLevel1{
//            tableViewData.append((qualify.name))
//        }
//        currentSelectedButton = "Qualification"
        dropDown.show()
        dropDown.anchorView = SelectOcupButton
        dropDown.dataSource = tableViewData

    }




    @IBAction func nominateButtonAction(_ sender: Any) {
        
        
        
    }
    
    @IBAction func SelectPollButtonAction(_ sender: Any) {
        
        
        
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
