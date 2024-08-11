//
//  ContentView.swift
//  Todo2
//
//  Created by Pranav on 7/26/24.
//

import SwiftUI

struct TaskListView: View {
    
    @ObservedObject var taskListVM = TaskListViewModel()
    
    //let tasks = testDataTasks
    
    @State var presentAddNewItem = false
    
    @State var showingCard: Bool = false
    
    @State var taskCellVMToPresent: TaskCellViewModel?
    
    let today: Date = Date()
        
        // Formatter to format the date as a string
        var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium // e.g., Aug 4, 2024
            formatter.timeStyle = .none // you can include .short or .long if needed
            return formatter
        }
    
    func deleteTask(_ taskCellVM: TaskCellViewModel) {
        taskCellVM.taskRepository.deleteTask(taskCellVM.task)
        
    }
    
    var body: some View {
        if showingCard == false {
            
            NavigationStack {
                VStack(alignment: .leading) {
                    List {
                        
                        HStack {
                            Rectangle()
                                .fill(Color.red)
                                .frame(height: 2) // height defines the thickness of the line
                            Text("High")
                                .foregroundColor(.red)
                                .bold()
                            Rectangle()
                                .fill(Color.red)
                                .frame(height: 2)
                        }
                        
                        ForEach(taskListVM.highTaskCellViewModels) { taskCellVM in
                            TaskCell(taskCellVM: taskCellVM)
                                .onTapGesture {
                                    //print("tapping")
                                    taskCellVMToPresent = taskCellVM
                                    showingCard = true
                                }
                                .swipeActions {
                                    Button(role: .destructive) {
                                        deleteTask(taskCellVM)
                                    } label: {
                                        Label("", systemImage: "trash")
                                    }
                                }
                        }
                        
                        HStack {
                            Rectangle()
                                .fill(Color.orange)
                                .frame(height: 2) // height defines the thickness of the line
                            Text("Medium")
                                .foregroundColor(.orange)
                                .bold()
                            Rectangle()
                                .fill(Color.orange)
                                .frame(height: 2)
                        }
                        
                        ForEach(taskListVM.mediumTaskCellViewModels) { taskCellVM in
                            TaskCell(taskCellVM: taskCellVM)
                                .onTapGesture {
                                    //print("tapping")
                                    taskCellVMToPresent = taskCellVM
                                    showingCard = true
                                }
                                .swipeActions {
                                    Button(role: .destructive) {
                                        deleteTask(taskCellVM)
                                    } label: {
                                        Label("", systemImage: "trash")
                                    }
                                }
                        }
                        
                        HStack {
                            Rectangle()
                                .fill(Color.yellow)
                                .frame(height: 2) // height defines the thickness of the line
                            Text("Low")
                                .foregroundColor(.yellow)
                                .bold()
                            Rectangle()
                                .fill(Color.yellow)
                                .frame(height: 2)
                        }
                        
                        ForEach(taskListVM.lowTaskCellViewModels) { taskCellVM in
                            TaskCell(taskCellVM: taskCellVM)
                                .onTapGesture {
                                    //print("tapping")
                                    taskCellVMToPresent = taskCellVM
                                    showingCard = true
                                }
                                .swipeActions {
                                    Button(role: .destructive) {
                                        deleteTask(taskCellVM)
                                    } label: {
                                        Label("", systemImage: "trash")
                                    }
                                }
                        }
                        
                        HStack {
                            Rectangle()
                                .fill(Color.green)
                                .frame(height: 2) // height defines the thickness of the line
                            Text("Completed")
                                .foregroundColor(.green)
                                .bold()
                            Rectangle()
                                .fill(Color.green)
                                .frame(height: 2)
                        }
                        
                        ForEach(taskListVM.completedTaskCellViewModels) { taskCellVM in
                            TaskCell(taskCellVM: taskCellVM)
                                .onTapGesture {
                                    //print("tapping")
                                    taskCellVMToPresent = taskCellVM
                                    showingCard = true
                                }
                                .swipeActions {
                                    Button(role: .destructive) {
                                        deleteTask(taskCellVM)
                                    } label: {
                                        Label("", systemImage: "trash")
                                    }
                                }
                        }
                        
                        if presentAddNewItem {
                            TaskCell(taskCellVM: TaskCellViewModel(task: Task(title: "", completed: false, priorityLevel: "nil"))) { task in
                                self.taskListVM.addTask(task: task)
                                self.presentAddNewItem.toggle()
                            }
                        }
                    }
                    Button(action: {
                        taskListVM.taskRepository.addTask(task: Task(title: "", completed: false, priorityLevel: "Low"))
                        taskListVM.taskRepository.loadData()
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .foregroundColor(.black)
                                .frame(width: 20, height: 20)
                            Text("Add new Task")
                                .foregroundColor(.black)
                        }
                    }
                    .padding()
                }
                .navigationTitle("Today's Tasks: \(dateFormatter.string(from: today))")
                .onAppear {
                    taskListVM.taskRepository.loadData()
                }
            }
        }
        else {
            ZStack {
                NavigationStack {
                    VStack(alignment: .leading) {
                        List {
                            ForEach(taskListVM.highTaskCellViewModels) { taskCellVM in
                                TaskCell(taskCellVM: taskCellVM)
                                    .onTapGesture {
                                        //print("tapping")
                                        taskCellVMToPresent = taskCellVM
                                        showingCard = true
                                    }
                            }
                            ForEach(taskListVM.mediumTaskCellViewModels) { taskCellVM in
                                TaskCell(taskCellVM: taskCellVM)
                                    .onTapGesture {
                                        //print("tapping")
                                        taskCellVMToPresent = taskCellVM
                                        showingCard = true
                                    }
                            }
                            ForEach(taskListVM.lowTaskCellViewModels) { taskCellVM in
                                TaskCell(taskCellVM: taskCellVM)
                                    .onTapGesture {
                                        //print("tapping")
                                        taskCellVMToPresent = taskCellVM
                                        showingCard = true
                                    }
                            }
                            if presentAddNewItem {
                                TaskCell(taskCellVM: TaskCellViewModel(task: Task(title: "", completed: false, priorityLevel: "Low"))) { task in
                                    self.taskListVM.addTask(task: task)
                                    self.presentAddNewItem.toggle()
                                }
                            }
                        }
                        Button(action: {
                            self.presentAddNewItem.toggle()
                        }) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("Add new Task")
                            }
                        }
                        .padding()
                    }
                    .navigationTitle("Tasks")
                }
                .blur(radius: 5)
                
                TaskCard(taskCellVM: taskCellVMToPresent!, showingCard: $showingCard)
                    .frame(maxWidth: 300, maxHeight: 200)
                    .transition(.move(edge: .bottom))
            }
        }
    }
}

#Preview {
    TaskListView()
}

struct TaskCell: View {
    
    @ObservedObject var taskCellVM: TaskCellViewModel
    
    @State private var isShowingDetail = false
    
    var onCommit: (Task) -> (Void) = { _ in }
    
    private var backgroundColor: Color {
        
        let baseColor: Color
        
        switch taskCellVM.task.priorityLevel {
        case "Low":
            baseColor = Color.yellow.opacity(1)
        case "Medium":
            baseColor = Color.orange.opacity(1)
        case "High":
            baseColor = Color.red.opacity(1)
        default:
            baseColor = Color.white.opacity(1)
        }
        
        if taskCellVM.task.completed {
            return Color.green.opacity(1)
        }
        
        return baseColor
    }
    
    var body: some View {
        HStack {
            Image(systemName: taskCellVM.task.completed ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    self.taskCellVM.task.completed.toggle()
                    //print("about to load data after toggle")
                    self.taskCellVM.taskRepository.loadData()
                }
            Text(taskCellVM.task.title == "" ? "Enter the task title" : taskCellVM.task.title)
                .foregroundColor(taskCellVM.task.title == "" ? Color.gray : Color.black)
            //            TextField("Enter the task title", text: $taskCellVM.task.title, onCommit: {
            //                self.onCommit(self.taskCellVM.task)
            //            })
            //                .onTapGesture {
            //                    self.isShowingDetail.toggle()
            //                }
            //                .sheet(isPresented: $isShowingDetail) {
            //                    ZStack {
            //                        // Apply blur effect
            //                        //                                VisualEffectBlur(blurStyle: .systemMaterialDark)
            //                        //
            //                        Color.black.ignoresSafeArea()
            //
            //                        // Modal card
            //                        TaskCard(task: self.taskCellVM.task)
            //                            .frame(maxWidth: 300, maxHeight: 300) // Set a max width for the card
            //                            .padding()
            //                    }
            //                    .frame(maxWidth: 100, maxHeight: 100)
            //                }
            
            Spacer()
            
            Rectangle()
                .fill(backgroundColor)
                .frame(width: 20, height: 20)
        }
        //        .frame(maxWidth: .infinity, alignment: .leading)
        //        .background(backgroundColor)
    }
}

struct TaskCard: View {
    var taskCellVM: TaskCellViewModel
    
    @Binding var showingCard: Bool
    
    @State private var title: String
    @State private var isCompleted: Bool
    
    @State private var priorityOption: String
    
    @State private var initialTitle: String
    @State private var initialCompleted: Bool
    @State private var initialPriority: String
    
    private let options = ["High", "Medium", "Low"]
    
    // Compute the background color based on priorityOption
    private var backgroundColor: Color {
        switch priorityOption {
        case "Low":
            return Color.yellow.opacity(1)
        case "Medium":
            return Color.orange.opacity(1)
        case "High":
            return Color.red.opacity(1)
        default:
            return Color.white.opacity(1)
        }
    }
    
    init(taskCellVM: TaskCellViewModel, showingCard: Binding<Bool>) {
        self.taskCellVM = taskCellVM
        self._showingCard = showingCard
        _title = State(initialValue: taskCellVM.task.title)
        _isCompleted = State(initialValue: taskCellVM.task.completed)
        _priorityOption = State(initialValue: taskCellVM.task.priorityLevel ?? "Select an Option")
        _initialTitle = State(initialValue: taskCellVM.task.title)
        _initialCompleted = State(initialValue: taskCellVM.task.completed)
        _initialPriority = State(initialValue: taskCellVM.task.priorityLevel)
        //print("initial Title \(initialTitle)")
        //print("initial Completed \(initialCompleted)")
        //print("initial Priority \(initialPriority)")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextField("Enter task title", text: $title)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundColor(title.isEmpty ? .gray : .black)
                .padding(.bottom, 8)
                .onChange(of: title) { newValue in
                    taskCellVM.task.title = newValue
                }
            
            Toggle("Completed", isOn: $isCompleted)
                .font(.headline)
                .onChange(of: isCompleted) { newValue in
                    taskCellVM.task.completed = newValue
                }
            
            HStack {
                Text("Priority Level: ")
                
                Picker("Select an option", selection: $priorityOption) {
                    ForEach(options, id: \.self) { option in
                        Text(option).tag(option)
                            .foregroundColor(.black)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .accentColor(.black)
                .padding(0)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .onChange(of: priorityOption) { newValue in
                    taskCellVM.task.priorityLevel = newValue
                }
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    showingCard = false
                    //taskCellVM.taskRepository.loadData()
                }) {
                    Text("Save")
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
                .padding()
                
                Button(action: {
                    taskCellVM.task.title = initialTitle
                    taskCellVM.task.completed = initialCompleted
                    taskCellVM.task.priorityLevel = initialPriority
                    
                    showingCard = false
                }) {
                    Text("Discard")
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
                .padding()
            }
        }
        .padding()
        .background(backgroundColor)  // Apply background color here
        .cornerRadius(12)
        .shadow(radius: 20)
        .edgesIgnoringSafeArea(.all)
    }
}
