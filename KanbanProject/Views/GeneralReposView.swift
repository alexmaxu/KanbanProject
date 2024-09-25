//
//  GeneralReposView.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//

import SwiftUI

struct GeneralReposView: View {
    @EnvironmentObject var reposVM: ReposVM
    
    var body: some View {
        List {
            ForEach(reposVM.reposList) { repo in
                HStack {
                    VStack(alignment: .leading) {
                        Text(repo.name)
                            .bold()
                        Text(repo.owner.login)
                    }
                    .frame(height: 130)
                    Spacer()
                    Image(systemName: "plus")
                }
                .onAppear {
                    reposVM.getNextPageRepos(repo: repo)
                }
                .onTapGesture {
                    reposVM.addToLocalRepository(repoID: repo.id)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        GeneralReposView()
            .environmentObject(ReposVM())
    }
}
