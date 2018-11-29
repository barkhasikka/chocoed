//
//  MediaVC.swift
//  chocoed
//
//  Created by Mahesh Bhople on 10/11/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit
import CoreData

class MediaVC: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate {
   
    
    
    var number : String  = ""
    
    var images = [Msg]()
    
    

    @IBOutlet var tblView: UICollectionView!
    
    
    @IBAction func back_btn_clicked(_ sender: Any) {

        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func value_changes(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
             print("photos")
            
             if images.count > 0 {
                images.removeAll()
                self.tblView.reloadData()
            }
            
             getData(type: kXMPP.TYPE_IMAGE)


        case 1:
            print("pdf")
            
            if images.count > 0 {
                images.removeAll()
                self.tblView.reloadData()
            }
            
            getData(type: kXMPP.TYPE_PDF)

        default:
            break
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getData(type: kXMPP.TYPE_IMAGE)
    }
    
    
    func getData(type : String ){
 
            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext

            do {
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Msg")
                fetchRequest.predicate = NSPredicate(format: "to_id == %@ and msg_type == %@",self.number,type)
                let fetchedResults = try context.fetch(fetchRequest) as! [Msg]
              
                print(fetchedResults)
                
                for msg in fetchedResults {
                    self.images.append(msg)
                }
                
                self.tblView.reloadData()
                
            }
            catch {
                
                print ("fetch task failed", error)
            }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as! MediaCell
        
        let msg = self.images[indexPath.row]
       
        if msg.msg_type == kXMPP.TYPE_IMAGE {
            
            cell.imageView!.sd_setImage(with: URL(string: msg.file_url))

        }else{
            
            cell.imageView!.image = UIImage(named: "pdf_place")

        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let msg = self.images[indexPath.row]
        if let vcNewSectionStarted = self.storyboard?.instantiateViewController(withIdentifier: "FileViewerVC") as? FileViewerVC {
            vcNewSectionStarted.fileURL = msg.file_url
            vcNewSectionStarted.type = msg.msg_type
            self.present(vcNewSectionStarted, animated: true, completion: nil)
        }

    }
    

}
