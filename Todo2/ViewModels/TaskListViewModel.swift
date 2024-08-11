//
//  TaskListViewModel.swift
//  Todo2
//
//  Created by Pranav on 7/26/24.
//

import Foundation
import Combine

class TaskListViewModel : ObservableObject {
    
    @Published var taskRepository = TaskRepository()
    
    //@Published var taskCellViewModels = [TaskCellViewModel]()
    
    @Published var highTaskCellViewModels = [TaskCellViewModel]()
    
    @Published var mediumTaskCellViewModels = [TaskCellViewModel]()
    
    @Published var lowTaskCellViewModels = [TaskCellViewModel]()
    
    @Published var completedTaskCellViewModels = [TaskCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
        taskRepository.$highTasks
            .map { tasks in
                tasks.map { task in
                    TaskCellViewModel(task: task)
                }
            }
            .assign(to: \.highTaskCellViewModels, on: self)
            .store(in: &cancellables)
        
        //print("high count \(taskRepository.highTasks.count)")
        
        taskRepository.$mediumTasks
            .map { tasks in
                tasks.map { task in
                    TaskCellViewModel(task: task)
                }
            }
            .assign(to: \.mediumTaskCellViewModels, on: self)
            .store(in: &cancellables)
        
        taskRepository.$lowTasks
            .map { tasks in
                tasks.map { task in
                    TaskCellViewModel(task: task)
                }
            }
            .assign(to: \.lowTaskCellViewModels, on: self)
            .store(in: &cancellables)
        
        taskRepository.$completedTasks
            .map { tasks in
                tasks.map { task in
                    TaskCellViewModel(task: task)
                }
            }
            .assign(to: \.completedTaskCellViewModels, on: self)
            .store(in: &cancellables)
        
    }
    
    func addTask(task: Task) {
        
        taskRepository.addTask(task: task)
        
//        let taskVM = TaskCellViewModel(task: task)
//        self.taskCellViewModels.append(taskVM)
        
    }
}
