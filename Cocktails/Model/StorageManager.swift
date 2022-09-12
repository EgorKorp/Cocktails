//
//  StorageManager.swift
//  Cocktails
//
//  Created by Egor Korp on 11.09.22.
//

import Foundation
import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func savedData(_ data: FavoriteCoctail){
        try! realm.write {
            realm.add(data)
        }
    }
    
    static func removedData(_ data: FavoriteCoctail){
        try! realm.write {
            realm.delete(realm.objects(FavoriteCoctail.self).where({
                $0.cocktailName == data.cocktailName
            }))
        }
    }
}


class FavoriteCoctail: Object {
    @Persisted var cocktailName: String
    @Persisted var instruction: String
    @Persisted var imageData: Data
    @Persisted var alcaholic: String
}
