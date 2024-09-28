//
//  KanbanProject.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//

import SwiftUI

@main
struct KanbanProject: App {
    @StateObject var reposVM = ReposVM(repoInteractor: ReposInteractor())

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(reposVM)
        }
    }
}
