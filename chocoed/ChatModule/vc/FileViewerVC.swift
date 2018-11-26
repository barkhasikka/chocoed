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
            backgroundImage.contentMode = UIViewContentMode.scaleAspectFit
            self.mainview.insertSubview(backgroundImage, at: 0)
            
        }else if type == kXMPP.TYPE_PDF {
            
          /*
            let webView = UIWebView(frame: self.view.bounds)
            print(pdf!)
            let req = URLRequest(url: pdf!)
            webView.loadRequest(req)
            self.mainview.addSubview(webView)*/

            let fileManager = FileManager.default
            let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0] as NSURL
            print(documentsUrl)
            
            let url = URL(string:self.fileURL)?.lastPathComponent
            let pdf = documentsUrl.appendingPathComponent(url!)
  
            let pdfview = PDFView(frame: self.view.bounds)
            pdfview.translatesAutoresizingMaskIntoConstraints = false
            
            if let document = PDFDocument(url: pdf!){
                pdfview.document = document
                self.mainview.addSubview(pdfview)
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
