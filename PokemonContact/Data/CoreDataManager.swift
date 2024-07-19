//
//  CoreDataManager.swift
//  PokemonContact
//
//  Created by 김승희 on 7/17/24.
//

import Foundation
import CoreData

class CoreDataManager {
    static var shared: CoreDataManager = CoreDataManager()
    
    var container: NSPersistentContainer!

    init() {
        container = NSPersistentContainer(name: "PokemonContact")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }

    // Create
    func createData(name: String, num: String, img: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: PokemonContact.PokemonEntity, in: self.container.viewContext) else {
            return
        }
        let newContact = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        
        let id = UUID()
        newContact.setValue(id, forKey: "id")
        
        newContact.setValue(name, forKey: PokemonContact.Key.name)
        newContact.setValue(num, forKey: PokemonContact.Key.num)
        newContact.setValue(img, forKey: PokemonContact.Key.img)

        do {
            try self.container.viewContext.save()
            print("문맥 저장 성공")
        } catch {
            print("문맥 저장 실패")
        }
    }

    // Read
    func readData() -> [PokemonContact] {
        let fetchRequest: NSFetchRequest<PokemonContact> = PokemonContact.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key:"name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let contacts = try self.container.viewContext.fetch(fetchRequest)
            return contacts
        } catch {
            print("데이터 읽기 실패)")
            return []
        }
    }

    // Update
    func updateData(currentName: String, updateName: String, updateNum: String, updateImg: String) {
        let fetchRequest = PokemonContact.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", currentName)
        do {
            let result = try self.container.viewContext.fetch(fetchRequest)

            for data in result as [NSManagedObject] {
                //data 중 name의 값을 updateName으로 update
                data.setValue(updateName, forKey: PokemonContact.Key.name)
                data.setValue(updateNum, forKey: PokemonContact.Key.num)
                data.setValue(updateImg, forKey: PokemonContact.Key.img)
            }
            try self.container.viewContext.save()
            print("데이터 수정 성공")
        } catch {
            print("데이터 수정 실패")
        }
    }

    // Delete
    func deleteData(name: String) {
        let fetchRequest = PokemonContact.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", name)

        do {
            let result = try self.container.viewContext.fetch(fetchRequest)
            for data in result as [NSManagedObject] {
                self.container.viewContext.delete(data)
            }
            try self.container.viewContext.save()
        } catch {
            print("데이터 삭제 실패")
        }
    }
    
    // log
    func logAllData() {
        let fetchRequest: NSFetchRequest<PokemonContact> = PokemonContact.fetchRequest()
        do {
            let contacts = try self.container.viewContext.fetch(fetchRequest)
            for contact in contacts {
                print("Name: \(contact.name ?? "No Name"), Num: \(contact.num ?? "No Num"), Img: \(contact.img ?? "No Img")")
            }
        } catch {
            print("Failed to fetch data: \(error)")
        }
    }
}
