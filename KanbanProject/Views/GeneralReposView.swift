//
//  GeneralReposView.swift
//  KanbanProject
//
//  Created by Alex  on 24/9/24.
//

import SwiftUI

struct GeneralReposView: View {
    @EnvironmentObject var reposVM: ReposVM
    
    @Binding var selectedTab: Int
    
    var body: some View {
        List {
            ForEach(reposVM.generalReposirotyList) { repo in
                HStack {
                    VStack(alignment: .leading) {
                        Text(repo.name)
                            .bold()
                        Text(repo.owner.login)
                    }
                    .frame(height: 130)
                    Spacer()
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.black)
                        .bold()
                        .frame(width: 40)
                        .padding(12)
                        .background {
                            Color.black.opacity(0.2)
                        }
                        .clipShape(.rect(cornerRadius: 12))
                }
                .onAppear {
                    reposVM.getNextPageRepos(repo: repo)
                }
                .onTapGesture {
                    reposVM.addToLocalRepository(repoID: repo.id)
                    selectedTab = 1
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        GeneralReposView(selectedTab: .constant(Int()))
            .environmentObject(ReposVM(repoInteractor: ReposInteractor()))
    }
}
