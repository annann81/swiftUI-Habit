//
//  ContentView.swift
//  Habit
//
//  Created by A2006 on 2021/8/13.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest(entity: TotlAward.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \TotlAward.name, ascending: true)]
    ) var totlAward: FetchedResults<TotlAward>
//    @EnvironmentObject private var totlAwardNum: TotlAwardNum
    @EnvironmentObject private var selectSymbolsName: SelectSymbolsName
    @State var action: Int? = 0
  
    @State private var text = ""
    
    
    var body: some View {
        TabView {
            PlanUIView()
                .tabItem {
                    VStack {
                        Text("Plan")
                        Image(systemName: "highlighter")
                    }
                }
            .tag(0)
                
            AwardUIView()
                .tabItem {
                    VStack {
                        Text("Award")
                        Image(systemName: "gift")
                    }
                }
            .tag(1)
        }//TabView
        .accentColor(Color(red: 251/255, green: 128/255, blue: 128/255))
        .font(.headline)
        
        .onAppear {
            
        
            
            if totlAward.count != 1{
                let totle = TotlAward(context: managedObjectContext)
                totle.name = "only"
                totle.num = 0
                PersistenceController.shared.save()
            }
            for i in totlAward{
                if i.name == "only"{
                    selectSymbolsName.totlAwardNum = Int(i.num)
                }
            }
        }//onAppear
    }//body
}//View


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
