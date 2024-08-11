//
//  TaskRepository.swift
//  Todo2
//
//  Created by Pranav on 7/26/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class TaskRepository : ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var tasks = [Task]()
    
    @Published var highTasks = [Task]()
    @Published var mediumTasks = [Task]()
    @Published var lowTasks = [Task]()
    @Published var completedTasks = [Task]()
    
    init() {
        //print("about to call load data from init")
        loadData()
        ////print("count \(tasks.count)")
    }
    
    func loadData() {
        
        let userId = Auth.auth().currentUser?.uid
        let calendar = Calendar.current
        let now = Date()
        
        let start = calendar.startOfDay(for: now)
        let end = calendar.date(byAdding: .day, value: 1, to: start)
        
        let startTime = Timestamp(date: start)
        let endTime = Timestamp(date: end!)
    
        
        ////print("in loadData")
        //print("in loadData - high")
        db.collection("tasks")
            .whereField("userId", isEqualTo: userId)
            .whereField("priorityLevel", isEqualTo: "High")
            .whereField("completed", isEqualTo: false)
            .whereField("createdTime", isGreaterThan: startTime)
            .whereField("createdTime", isLessThan: endTime)
            .order(by: "createdTime")
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.highTasks = querySnapshot.documents.compactMap { document in
                    do {
                        let x = try document.data(as: Task.self)
                        //print("high taek \(x)")
                        return x
                    }
                    catch {
                        //print(error)
                    }
                    return nil
                }
            }
        }
        
        ////print("high count \(highTasks.count)")
        //print("high-== \(self.highTasks)")
        //print("in loadData - medium")
        db.collection("tasks")
            .whereField("userId", isEqualTo: userId)
            .whereField("priorityLevel", isEqualTo: "Medium")
            .whereField("completed", isEqualTo: false)
            .whereField("createdTime", isGreaterThan: startTime)
            .whereField("createdTime", isLessThan: endTime)
            .order(by: "createdTime")
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.mediumTasks = querySnapshot.documents.compactMap { document in
                    do {
                        let x = try document.data(as: Task.self)
                        //print("medium taek \(x)")
                        return x
                    }
                    catch {
                        //print(error)
                    }
                    return nil
                }
            }
        }
        //print("in loadData - low")
        db.collection("tasks")
            .whereField("userId", isEqualTo: userId)
            .whereField("priorityLevel", isEqualTo: "Low")
            .whereField("completed", isEqualTo: false)
            .whereField("createdTime", isGreaterThan: startTime)
            .whereField("createdTime", isLessThan: endTime)
            .order(by: "createdTime")
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.lowTasks = querySnapshot.documents.compactMap { document in
                    do {
                        let x = try document.data(as: Task.self)
                        //print("low taek \(x)")
                        return x
                    }
                    catch {
                        //print(error)
                    }
                    return nil
                }
            }
        }
        //print("in loadData - completed")
        db.collection("tasks")
            .whereField("userId", isEqualTo: userId)
            .whereField("completed", isEqualTo: true)
            .whereField("createdTime", isGreaterThan: startTime)
            .whereField("createdTime", isLessThan: endTime)
            .order(by: "createdTime")
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.completedTasks = querySnapshot.documents.compactMap { document in
                    do {
                        let x = try document.data(as: Task.self)
                        //print("completed taek \(x)")
                        return x
                    }
                    catch {
                        //print(error)
                    }
                    return nil
                }
            }
        }
        
        //print("completed count \(completedTasks.count)")
        //print("completed \(self.completedTasks)")
        
    }
    
    func addTask( task: Task) {
        do {
            var addedTask = task
            addedTask.userId = Auth.auth().currentUser?.uid
            let _ = try db.collection("tasks").addDocument(from: addedTask)
        }
        catch {
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
    }
    
    func updateTask(_ task: Task) {
        if let taskID = task.id {
            do {
                //print("calling update on task: \(task.title) \(task.priorityLevel) \(task.completed)")
                try db.collection("tasks").document(taskID).setData(from: task)
            }
            catch {
                fatalError("Unable to encode task: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteTask(_ task: Task) {
        if let taskID = task.id {
            do {
                try db.collection("tasks").document(taskID).delete()
                //print("Document successfully removed!")
            } catch {
                //print("Error removing document: \(error)")
            }
        }
    }
    
}
