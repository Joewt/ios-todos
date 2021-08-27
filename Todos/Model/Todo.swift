//
//  Todo.swift
//  Todos
//
//  Created by 乔酱 on 2021/7/26.
//

import UIKit
import RealmSwift

class Todo:Object {
    @Persisted  var name = ""
    @Persisted  var checked = false
}

class LocalOnlyQsTask: Object {
    @Persisted var name: String = ""
    @Persisted var owner: String?
    @Persisted var status: String = ""
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
