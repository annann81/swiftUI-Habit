//
//  AwardUIView.swift
//  Habit
//
//  Created by A2006 on 2021/8/13.
//

import SwiftUI
import CoreData


struct AwardUIView: View {
    
    @EnvironmentObject private var selectSymbolsName: SelectSymbolsName
    @FetchRequest(entity: Award.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Award.awardName, ascending: true)]
    ) var award: FetchedResults<Award>
    @FetchRequest(entity: TotlAward.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \TotlAward.name, ascending: true)]
    ) var totle: FetchedResults<TotlAward>

    
    
    @State var action: Int? = 0
    
    @State var num: String = ""
    
    @State private var isShowAlert: Bool = false
    @State private var activeAlert: ActiveAlert = .error
    enum ActiveAlert {
        case error, ok
    }
    
    
    var body: some View {
        NavigationView {
        ZStack {
            NavigationLink(destination:AddAwardView(),tag: 1, selection: $action){}
        
        VStack{
        HStack {
//
            Image(systemName: "dollarsign.circle")
            Text("\(selectSymbolsName.totlAwardNum)")
  
            Spacer()
            Text("Award")
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .shadow(color: .red, radius: 2, x: 2, y: 2)
            Spacer()
            
            Button(action: {
                self.action = 1
               
                }, label: {
                    Text("+")
//                        Image(systemName: "arrow.up.doc")
                        .font(.system(size: 20))
                })
                .buttonStyle(PlainButtonStyle())
            
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color(red: 251/255, green: 128/255, blue: 128/255), Color(red: 253/255, green: 193/255, blue: 104/255)]), startPoint: .leading, endPoint: .trailing))
        .foregroundColor(.white)
        .edgesIgnoringSafeArea(.all)
            
           
            List{
                
                ForEach((award), id: \.self) { aaward in
                    HStack{
                        
                        Image(systemName: "\(aaward.systemName!)")
                            .font(.system(size: 30))
                                   
                        VStack{
                            Text("\(aaward.awardName!)")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .shadow(color: .red, radius: 2, x: 2, y: 2)
                            HStack{
                                Image(systemName: "dollarsign.circle")
                                
                            Text("\(aaward.exchangeAmount)")
                        }
                        }
                        Spacer()
                        
                        if aaward.isCheck{
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
                    
                    if aaward.isCheck{
                        aaward.isCheck = false
                        selectSymbolsName.totlAwardNum += Int(aaward.exchangeAmount)
                        
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
                    selectSymbolsName.updateAward = aaward
                    selectSymbolsName.isUpdate = true
                }) {
                    HStack {
                        Text("rename")
                        Image(systemName: "tortoise")
                    }
                }
            }//contextMenu
                    
//                            點選
                        .onTapGesture {

                                if Int(aaward.exchangeAmount) > selectSymbolsName.totlAwardNum{
                                    
                                    isShowAlert = true
                                    activeAlert = .error
                                    
                                }else{
                                    
                                    aaward.isCheck = true
                         
                                    selectSymbolsName.totlAwardNum -= Int(aaward.exchangeAmount)
          
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
                
                .background(LinearGradient(gradient: Gradient(colors: [Color(red: 251/255, green: 128/255, blue: 128/255), Color(red: 253/255, green: 193/255, blue: 104/255)]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(10)
                .foregroundColor(.white)
                

                        
                }


            .padding()
            
            
            .alert(isPresented: $isShowAlert) {
                switch activeAlert {
                case .error:
                    return Alert(title: Text("Error"),
                                 message: Text("Please verify and try again"),
                                 dismissButton: .default(Text("OK")))
                case .ok:
                    return Alert(title: Text(""),
                                 message: Text("Export Data"),
                                 dismissButton: .default(Text("OK")))
                }
            }
            
        }
        .navigationBarHidden(true)
        
        }
        
    }//NavigationView
    
    .navigationViewStyle(StackNavigationViewStyle())
      
}//body
    
func deleteItem(at offsets: IndexSet) {

  offsets.forEach { index in

    let selectItem = self.award[index]
    PersistenceController.shared.delete(selectItem)
  }

}
}
struct AwardUIView_Previews: PreviewProvider {
    static var previews: some View {
        AwardUIView()
    }
}
