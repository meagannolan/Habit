//
//  Habit.swift
//  habitApp
//
//  Created by Meagan Nolan on 1/28/20.
//  Copyright © 2020 Meagan Nolan. All rights reserved.
//

import Foundation
import CoreData

@objc(Habit)

class Habit: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var imageName: String
    @NSManaged var datesCompleted: [NSDate]
}
