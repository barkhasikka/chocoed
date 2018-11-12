//
//  FileViewerVC.swift
//  chocoed
//
//  Created by Mahesh Bhople on 10/11/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit
import PDFKit

class FileViewerVC: UIViewController {
    
    var fileURL : String = ""
    var type : String = ""
    
    @IBOutlet var mainview: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if type == kXMPP.TYPE_IMAGE {
            
            let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.sd_setImage(with: URL(string: fileURL))
            backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
            self.mainview.insertSubview(backgroundImage, at: 0)
            
        }else if type == kXMPP.TYPE_PDF {
            
            let pdfview = PDFView()
            pdfview.translatesAutoresizingMaskIntoConstraints = false
            
            self.mainview.addSubview(pdfview)
            
            if let document = PDFDocument(url: URL(string: fileURL)!){
                pdfview.document = document
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back_btn_clicked(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
  
}
