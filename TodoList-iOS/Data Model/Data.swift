//
//  Data.swift
//  TodoList-iOS
//
//  Created by lutfi on 29/10/19.
//  Copyright © 2019 mlutfiibra. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
