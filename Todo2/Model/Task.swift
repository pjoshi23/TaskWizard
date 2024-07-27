//
//  Task.swift
//  Todo2
//
//  Created by Pranav on 7/26/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Task: Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var completed: Bool
}

#if DEBUG

let testDataTasks = [
    Task(title: "Implement the UI", completed: true),
    Task(title: "Connect to Firebase", completed: false),
    Task(title: "???", completed: false),
    Task(title: "Money", completed: false)
]

#endif
