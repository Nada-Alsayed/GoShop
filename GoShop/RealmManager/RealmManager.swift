//
//  RealmManager.swift
//  GoShop
//
//  Created by MAC on 13/12/2023.
//

import Foundation
import RealmSwift

class RealmManager{
    
    //MARK: - Variables
    
    private var realmManager : Realm!
    static let sharedInstance = RealmManager()
    
    //MARK: - Migration

    let config = Realm.Configuration(
        schemaVersion: 2,
        migrationBlock: { migration, oldSchemaVersion in
            if oldSchemaVersion < 2 {
                // Add migration for the 'weeks' property
                migration.enumerateObjects(ofType: LocalProduct.className()) { oldObject, newObject in
                    // Handle migration logic for each object
                }
            }
        }
    )
    
    //MARK: - Init
    
    private init(){
        do{
            Realm.Configuration.defaultConfiguration = config
            realmManager = try Realm()
        }catch{
            print("Realm CreationError \(error.localizedDescription)")
        }
    }
    
    //MARK: - Methods
    
    func insertToRealm(product : LocalProduct){
        do{
            try realmManager.write{
                realmManager.add(product)
            }
        } catch {
            print("Error writing to Realm: \(error.localizedDescription)")
        }
    }
    
    func deleteFromRealm(product: LocalProduct) {
        do {
            try realmManager.write {
                realmManager.delete(product)
            }
        } catch {
            print("Error deleting from Realm: \(error.localizedDescription)")
        }
    }
    
    func deleteFromRealmById(id:String){
        guard let product = realmManager.object(ofType: LocalProduct.self, forPrimaryKey: id) else { return  }
        deleteFromRealm(product: product)
    }
    
    func getAllProducts() -> [LocalProduct] {
        let products = realmManager.objects(LocalProduct.self)
        return Array(products)
    }
    
    func getProduct(withId id: String) -> LocalProduct? {
        return realmManager.object(ofType: LocalProduct.self, forPrimaryKey: id)
    }
    
    func doesProductExist(withId id: String) -> Bool {
        if realmManager.object(ofType: LocalProduct.self, forPrimaryKey: id) != nil{
            return true
        } else {
            return false
        }
    }
    
}
