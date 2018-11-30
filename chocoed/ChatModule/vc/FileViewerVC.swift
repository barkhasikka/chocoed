//
//  FileViewerVC.swift
//  chocoed
//
//  Created by Mahesh Bhople on 10/11/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit
import PDFKit
import WebKit


class FileViewerVC: UIViewController {
    
    var fileURL : String = ""
    var type : String = ""
    
    
    @IBOutlet var pdfView: UIView!
    
    @IBOutlet var mainview: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if type == kXMPP.TYPE_IMAGE {
            
            self.pdfView.isHidden = true
            self.mainview.isHidden = false
            
            let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.sd_setImage(with: URL(string: fileURL))
            backgroundImage.contentMode = UIViewContentMode.scaleAspectFit
            self.mainview.insertSubview(backgroundImage, at: 0)
            
        }else if type == kXMPP.TYPE_PDF {
            
          
            self.pdfView.isHidden = false
            self.mainview.isHidden = true
            
            let url = URL(fileURLWithPath: self.fileURL)
            print(url)
            let pdfview = WKWebView(frame: self.view.bounds)
            pdfview.loadFileURL(url, allowingReadAccessTo: url)
            //pdfview.load(URLRequest(url:url!))
            self.pdfView.addSubview(pdfview)
        
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
