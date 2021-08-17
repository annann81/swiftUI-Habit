//
//  ContentView.swift
//  Habit
//
//  Created by A2006 on 2021/8/13.
//

import SwiftUI
import CoreData

struct PlanUIView: View {

    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var selectSymbolsName: SelectSymbolsName

    
    @FetchRequest(entity: Plan.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Plan.planName, ascending: true)]
    ) var plan: FetchedResults<Plan>
    @FetchRequest(entity: TotlAward.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \TotlAward.name, ascending: true)]
    ) var totle: FetchedResults<TotlAward>

    @State var action: Int? = 0
    
    @State private var text = ""
    
    @State var selectPlan :Plan!
    
var body: some View {
    NavigationView {
        ZStack {
            NavigationLink(destination:AddPlanView(select: $selectPlan),tag: 1, selection: $action){}
            VStack{
                HStack {
                    Image(systemName: "dollarsign.circle")
                    Text("\(selectSymbolsName.totlAwardNum)")

                    Spacer()
                    
                    Text("Plan")
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .shadow(color: .red, radius: 2, x: 2, y: 2)
                    Spacer()

                    Button(action: {
                        self.action = 1

                    }, label: {
                        Text("+")
                            .font(.system(size: 20))
                    })
                    .buttonStyle(PlainButtonStyle())

                }
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color(red: 251/255, green: 128/255, blue: 128/255), Color(red: 253/255, green: 193/255, blue: 104/255)]), startPoint: .leading, endPoint: .trailing))
                .foregroundColor(.white)
                .edgesIgnoringSafeArea(.all)
                
            List{

                ForEach((plan), id: \.self) { aplan in
                    
                    HStack{

                        Image(systemName: "\(aplan.systemName!)")
                            .font(.system(size: 30))

                        VStack{
                            Text("\(aplan.planName!)")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .shadow(color: .red, radius: 2, x: 2, y: 2)
                            HStack{
                                Image(systemName: "dollarsign.circle")
                                Text("\(aplan.award)")
                            }
                        }
                        Spacer()

                        if aplan.isCheck{
                            VStack{
                                Spacer()
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(.white)
                            }
                        }
                    }

//                            長按清單
                .contextMenu {
                //清單按鈕
                    Button(action: {
                  
                        if aplan.isCheck{
                        aplan.isCheck = false
                        selectSymbolsName.totlAwardNum -= Int(aplan.award)

                            for i in totle{
                                if i.name == "only"{
                                    i.num = Int16(selectSymbolsName.totlAwardNum)
                                }
                                PersistenceController.shared.save()
                            }
                        }
                    }) {
                        HStack {
                            Text("Check-off")
                            Image(systemName: "arrow.counterclockwise.circle.fill")
                        }
                    }

                    Button(action: {
                    
                        action = 1
                        selectPlan = aplan

                    }) {
                        HStack {
                            Text("Update")
                            Image(systemName: "tortoise")
                            
                        }
                    }
                }//contextMenu
//                            點選
                .onTapGesture {

                     
                    if !aplan.isCheck{
                        aplan.isCheck = true
                        selectSymbolsName.totlAwardNum += Int(aplan.award)

                        for i in totle{
                            if i.name == "only"{
                                i.num = Int16(selectSymbolsName.totlAwardNum)
                            }
                        PersistenceController.shared.save()
                        }

                    }
                
                }
                .padding(.vertical,4)
                .listRowBackground(LinearGradient(gradient: Gradient(colors: [Color(red: 251/255, green: 128/255, blue: 128/255), Color(red: 253/255, green: 193/255, blue: 104/255)]), startPoint: .leading, endPoint: .trailing))
                
                }//ForEach
                .onDelete(perform: deleteItem)
                
                .foregroundColor(.white)
                .cornerRadius(10)

//                .background(LinearGradient(gradient: Gradient(colors: [Color(red: 255/255, green: 193/255, blue: 193/255), Color(red: 245/255, green: 245/255, blue: 220/255)]), startPoint: .leading, endPoint: .trailing))
//                .shadow(color: .gray, radius: 2, x: 2, y: 2)
            }
            .padding()
            }
        .navigationBarHidden(true)
        }
    }//NavigationView
    .navigationViewStyle(StackNavigationViewStyle())

    .onAppear {
    UITableView.appearance().separatorColor = .clear
    }
}//body
    
    

    func deleteItem(at offsets: IndexSet) {

      offsets.forEach { index in

        let selectItem = self.plan[index]
        PersistenceController.shared.delete(selectItem)
      }
    }
    
    
    
    
}


struct PlanUIView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




