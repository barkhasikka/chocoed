//
//  Msg+CoreDataProperties.swift
//  chocoed
//
//  Created by Mahesh Bhople on 31/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import Foundation

import CoreData


extension Msg {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Msg> {
        return NSFetchRequest<Msg>(entityName: "Msg");
    }
    
    @NSManaged public var  created : String?
    @NSManaged public var   file_url: String
    @NSManaged public var   from_id : String
    @NSManaged public var   is_download : String
    @NSManaged public var   is_mine : String
    @NSManaged public var   is_streaming : String
    @NSManaged public var   is_upload : String
    @NSManaged public var   modified : String
    @NSManaged public var   msg : String
    @NSManaged public var   msg_ack : String
    @NSManaged public var   msg_id : String
    @NSManaged public var   msg_type : String
    @NSManaged public var   status : String
    @NSManaged public var   to_id : String
    @NSManaged public var   is_permission : String


    
}
