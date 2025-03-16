//
//  TestView.swift
//  GreenScan
//
//  Created by Francesco Sallia on 16.03.25.
//

import SwiftUI

struct TestView: View {
    
    @State var dummyData: [Dummy] = [
        Dummy(name: "Max", lastname: "Mustermann"),
        Dummy(name: "Erika", lastname: "Musterfrau"),
        Dummy(name: "John", lastname: "Doe"),
        Dummy(name: "Jane", lastname: "Doe"),
        Dummy(name: "Alex", lastname: "Smith"),
        Dummy(name: "Maria", lastname: "Gonzalez")
    ]
    
    
    var body: some View {
            NavigationStack {
                ZStack {
                    Color.costumBackground
                        .ignoresSafeArea()
//                    ScrollView {
                    List {
                        ForEach(dummyData, id: \.id) { item in
                            ZStack {
                                Color.costumBackground
                                NavigationLink {
                                    Text("Details")
                                } label: {
                                    HStack {
                                        Image("blatt")
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(.rect(cornerRadius: 15))
                                        VStack {
                                            Text("\(item.name)")
                                            Text("\(item.lastname)")
                                            Image(systemName: "heart")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundStyle(.black)
                                                .frame(maxWidth: 30)
                                                .padding(.top)
                                        }
                                        .foregroundStyle(.black)
                                    }
                                }
                            }
                            .listRowBackground(Color.costumBackground) // Hintergrund für jede Zelle
                        }
                        .onDelete { dummyData.remove(atOffsets: $0) }
                        .onMove { dummyData.move(fromOffsets: $0, toOffset: $1) }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
//                    }
//                    .frame(maxHeight: .infinity)
                }
                .toolbar {
                    EditButton()
                }
        }
    }
}

#Preview {
    TestView()
}
