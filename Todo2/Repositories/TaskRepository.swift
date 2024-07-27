//
//  TaskRepository.swift
//  Todo2
//
//  Created by Pranav on 7/26/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class TaskRepository : ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var tasks = [Task]()
    
    init() {
        loadData()
        print("count \(tasks.count)")
    }
    
    func loadData() {
        db.collection("tasks").addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.tasks = querySnapshot.documents.compactMap { document in
                    do {
                        let x = try document.data(as: Task.self)
                        return x
                    }
                    catch {
                        print(error)
                    }
                    return nil
                }
            }
        }
        
    }
    
    func addTask( task: Task) {
        do {
            let _ = try db.collection("tasks").addDocument(from: task)
        }
        catch {
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
    }
    
}
