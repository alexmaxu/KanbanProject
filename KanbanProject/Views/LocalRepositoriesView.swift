//
//  LocalRepositoriesView.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//

import SwiftUI

struct LocalRepositoriesView: View {
    @EnvironmentObject var reposVM: ReposVM
    var body: some View {
        List {
            if reposVM.localReposList.isEmpty {
                Text("There is no Local Repositories. You should add it from Public Repositories")
            }
            ForEach(reposVM.localReposList, id: \.self) { localRepo in
                NavigationLink(value: localRepo) {
                    VStack(alignment: .leading) {
                        Text(localRepo.name)
                            .bold()
                        Text(localRepo.owner.login)
                    }
                }
                .swipeActions {
                    Button(role: .destructive) {
                        reposVM.deleteReposFromLocalRepository(repoID: localRepo.id)
                    } label: {
                        Label {
                            Text("Delete")
                        } icon: {
                            Image(systemName: "trash")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        LocalRepositoriesView()
            .environmentObject(ReposVM(repoInteractor: ReposInteractor()))
    }
}
