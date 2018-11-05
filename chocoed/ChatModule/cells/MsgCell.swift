//
//  MsgCell.swift
//  chocoed
//
//  Created by Mahesh Bhople on 31/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class MsgCell: UITableViewCell {
    
    
   /* override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        accessoryType = selected ? UITableViewCellAccessoryType.checkmark : UITableViewCellAccessoryType.none
    } */

    let photoImageview: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        iv.layer.masksToBounds = true
        return iv
    }()
   
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        //label.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
   /* let tagsLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        //label.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
 */
    
    let dividerLineView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isUserInteractionEnabled = false
        
        addSubview(photoImageview)
        addSubview(authorLabel)
       //  addSubview(tagsLabel)
       //  addSubview(dividerLineView)
        
      
        photoImageview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        photoImageview.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        photoImageview.widthAnchor.constraint(equalToConstant: 100).isActive = true
        photoImageview.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        authorLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        authorLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        authorLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        authorLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        
      /*
        dividerLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        dividerLineView.leftAnchor.constraint(equalTo: leftAnchor, constant: 14).isActive = true
        dividerLineView.rightAnchor.constraint(equalTo: rightAnchor, constant: -14).isActive = true
        dividerLineView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor).isActive = true
        
        
        authorLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -14).isActive = true
        authorLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 14).isActive = true
       // authorLabel.topAnchor.constraint(equalTo: photoImageview.bottomAnchor).isActive = true
    */
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
     func setMsgCellWith(item: Msg) {
        
        DispatchQueue.main.async {
            
            
            if item.msg_type == kXMPP.TYPE_TEXT {

                self.authorLabel.text = item.msg
                self.authorLabel.isHidden = false
                self.photoImageview.isHidden = true
                
                
            }else if item.msg_type == kXMPP.TYPE_IMAGE {
                
                self.authorLabel.isHidden = false
                self.photoImageview.isHidden = false
                
                self.authorLabel.text = item.file_url

                
              /*  let fileUrl = URL(string: item.file_url)
                if fileUrl != nil {
                    if let data = try? Data(contentsOf: fileUrl!) {
                        if let image = UIImage(data: data) {
                            self.photoImageview.image = image
                        }
                    }
                    
                } */
                
            }
            
          
        }
    }
}

