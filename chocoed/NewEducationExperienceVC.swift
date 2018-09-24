//
//  NewEducationExperienceVC.swift
//  chocoed
//
//  Created by barkha sikka on 18/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class NewEducationExperienceVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var buttonQualification: UIButton!
    
    @IBOutlet weak var buttonLocation: UIButton!
    
    @IBOutlet weak var buttonYearofpassing: UIButton!
    
    @IBOutlet weak var textfieldClgName: UITextField!
    @IBOutlet weak var textfieldBoardUniv: UITextField!
    @IBOutlet weak var buttonSpecification: UIButton!
    var arrayvalues = ["19999","21354","2155","2146","1534"]
    func getDropdownList(){
        let params = ["access_token":"03db0f67032a1e3a82f28b476a8b81ea"] as Dictionary<String, String>
        MakeHttpPostRequest(url: userDropDown , params: params, completion: {(success, response) -> Void in
        print(response)
            
            })
//        //        let params = ["access_token":"03db0f67032a1e3a82f28b476a8b81ea"] as Dictionary<String, String>
//        //        let response = MakeHttpPostRequest(url: getUserInfo, params: params)
//        //        print(response)
//        //        let vcEduProf = storyboard?.instantiateViewController(withIdentifier: "signup") as!
//        //
//
//        let url = NSURL(string: "\(userDropDown)")
//
//        //create the session object
//        let session = URLSession.shared
//
//        //now create the NSMutableRequest object using the url object
//        let request = NSMutableURLRequest(url: url! as URL)
//        request.httpMethod = "POST"
//        let params = ["access_token":"03db0f67032a1e3a82f28b476a8b81ea"] as Dictionary<String, String>
//
//        do {
//            let httpBody =  try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
//            let httpBodyString = String(data: httpBody, encoding: String.Encoding.utf8)
//            request.httpBody = httpBodyString?.data(using: String.Encoding.utf8)
//
//        } catch let error {
//            print("error in serialization==",error.localizedDescription)
//        }
//
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
//            guard error == nil else {
//                print("error in the request", error ?? "")
//                DispatchQueue.main.async(execute: {
//                    let alertcontrol = UIAlertController(title: "alert!", message: error?.localizedDescription, preferredStyle: .alert)
//                    let alertaction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                    alertcontrol.addAction(alertaction)
//                    self.present(alertcontrol, animated: true, completion: nil)
//                })
//                return
//            }
//
//            guard let data = data else {
//                print("something is wrong")
//                DispatchQueue.main.async(execute: {
//                    let alertcontrol = UIAlertController(title: "alert!", message: "not found", preferredStyle: .alert)
//                    let alertaction = UIAlertAction(title: "OK", style: .default, handler: nil)
//
//                    alertcontrol.addAction(alertaction)
//                    self.present(alertcontrol, animated: true, completion: nil)
//                })
//                return
//            }
//            if let httpResponse = response as? HTTPURLResponse {
//                let statusCode = httpResponse.statusCode
//                // do whatever with the status code
//                print(statusCode)
//            }
//
//            do {
//                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
//                    print(json)
//
//                    //                    let jsonobject = json[""] as? NSDictionary
//                    //                    let temp = jsonobject?.object(forKey: "userID") as? String ?? ""
//                    //
//                    //                    print(temp)
//                }
//            }catch let error {
//                print(error.localizedDescription)
//            }
//        }
//        task.resume()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayvalues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celledu") as! EducationExpTableViewCell
        let titlename = arrayvalues[indexPath .row]
        cell.valueEdu.text = titlename
        return cell
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func qualificationButtonAction(_ sender: Any) {
    }
    
    @IBAction func locationButtonAction(_ sender: Any) {
    }
    
    @IBAction func spectificationButtonAction(_ sender: Any) {
    }
    @IBAction func YearOfPassingButtonAction(_ sender: Any) {
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
