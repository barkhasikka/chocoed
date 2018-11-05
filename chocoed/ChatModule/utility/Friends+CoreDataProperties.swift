//
//  Friends+CoreDataProperties.swift
//  chocoed
//
//  Created by Mahesh Bhople on 03/11/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import Foundation

import CoreData


extension Friends {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friends> {
        return NSFetchRequest<Friends>(entityName: "Friends");
    }
    
    @NSManaged public var   created : String?
    @NSManaged public var   contact_number: String
    @NSManaged public var   fcm_id : String
    @NSManaged public var   is_mine : String
    @NSManaged public var   is_typing : String
    @NSManaged public var   last_msg : String
    @NSManaged public var   last_msg_type : String
    @NSManaged public var   last_msg_time : String
    @NSManaged public var   modified : String
    @NSManaged public var   name : String
    @NSManaged public var   profile_image : String
    @NSManaged public var   read_count : String
    @NSManaged public var   status : String
    @NSManaged public var   user_id : String
    
    
}
