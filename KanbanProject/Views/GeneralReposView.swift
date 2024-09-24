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
                    Spacer()
                    Image(systemName: "plus")
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
