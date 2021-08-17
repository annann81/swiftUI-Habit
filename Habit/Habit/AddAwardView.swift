//
//  AddPlanView.swift
//  Habit
//
//  Created by A2006 on 2021/8/13.
//

import SwiftUI
import CoreData

struct AddAwardView: View {
    
    @State private var awardName = ""
    @State private var exchangeAmount = ""
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var selectSymbolsName: SelectSymbolsName
    
    @State var action: Int? = 0
    
    var body: some View {
        
        NavigationView {
            ZStack {
                NavigationLink(destination:IconStyleUIView(),tag: 1, selection: $action){}
        
        
                VStack{
                    HStack {
                        Button(action: {
                            
                            self.presentationMode.animation().wrappedValue.dismiss()
                            }, label: {
                                Image(systemName: "arrowshape.turn.up.backward")
                                    .font(.system(size: 20))
                            })
                            .buttonStyle(PlainButtonStyle())
                        
                        Spacer()
                        Text(" Add Award")
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .shadow(color: .red, radius: 2, x: 2, y: 2)
                        Spacer()
                        Button(action: {
                            
                            
                            
                            if selectSymbolsName.isUpdate{

                                selectSymbolsName.updateAward.awardName = awardName
                                selectSymbolsName.updateAward.exchangeAmount = Int16(exchangeAmount)!
                                selectSymbolsName.updateAward.systemName = selectSymbolsName.symbolsName == "" ? "questionmark.square":selectSymbolsName.symbolsName
                                
                                selectSymbolsName.isUpdate = false
                            }
                            
                            
                            
                            let award = Award(context: managedObjectContext)
                            award.awardName = awardName ?? ""
                            award.exchangeAmount = Int16(exchangeAmount)  ?? 0
                            award.isCheck = false
                            award.systemName = selectSymbolsName.symbolsName == "" ? "questionmark.square":selectSymbolsName.symbolsName
                            PersistenceController.shared.save()
                            
                            
                           print("save")
                            
                            self.presentationMode.animation().wrappedValue.dismiss()
                            }, label: {
                                Text(" save ")
        //                        Image(systemName: "save")
                                    .font(.system(size: 20))
                            })
                            .buttonStyle(PlainButtonStyle())
                    }
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color(red: 251/255, green: 128/255, blue: 128/255), Color(red: 253/255, green: 193/255, blue: 104/255)]), startPoint: .leading, endPoint: .trailing))
                    .foregroundColor(.white)
                    .edgesIgnoringSafeArea(.all)
                    
                    Button(action: {
                        
                        
                        self.action = 1
                      
                        }, label: {
                            Image(systemName: selectSymbolsName.symbolsName == "" ? "questionmark.square":selectSymbolsName.symbolsName)
                                .font(.system(size: 80))
                            
//                            Text("Icon")
                        })
        //                .buttonStyle(PlainButtonStyle())
                    
                    
                   
                    FormField(fieldName: "Award Name", fieldValue: $awardName)
       
                    FormField(fieldName: "$$$", fieldValue: $exchangeAmount)
       
                    Spacer()
                    }//VStack
                
            }//ZStack
            .navigationBarHidden(true)
        }//NavigationView
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        
        
        .onAppear {
            selectSymbolsName.symbolsName = ""
            
            
            if selectSymbolsName.isUpdate{
                awardName = selectSymbolsName.updateAward.awardName!
                exchangeAmount = "\(selectSymbolsName.updateAward.exchangeAmount)"
                selectSymbolsName.symbolsName = selectSymbolsName.updateAward.systemName!
            }
            
        }//onAppear
    }//body
}//View

struct AddAwardView_Previews: PreviewProvider {
    static var previews: some View {
        AddAwardView()
    }
}






//struct FormField: View {
//    var fieldName = ""
//    @Binding var fieldValue: String
//    
//    var isSecure = false
//    
//    var body: some View {
//        
//        VStack {
//            if isSecure {
//                SecureField(fieldName, text: $fieldValue)
//                    .font(.system(size: 20, weight: .semibold, design: .rounded))
//                    .padding(.horizontal)
//                
//            } else {
//                TextField(fieldName, text: $fieldValue)
//                    .font(.system(size: 20, weight: .semibold, design: .rounded))
//                    .padding(.horizontal)
//            }
//
//            Divider()
//                .frame(height: 1)
//                .background(Color(red: 240/255, green: 240/255, blue: 240/255))
//                .padding(.horizontal)
//            
//        }
//    }
//}
//
//struct RequirementText: View {
//    
//    var iconName = "xmark.square"
//    var iconColor = Color(red: 251/255, green: 128/255, blue: 128/255)
//    
//    var text = ""
//    var isStrikeThrough = false
//    
//    var body: some View {
//        HStack {
//            Image(systemName: iconName)
//                .foregroundColor(iconColor)
//            Text(text)
//                .font(.system(.body, design: .rounded))
//                .foregroundColor(.secondary)
//                .strikethrough(isStrikeThrough)
//            Spacer()
//        }
//        .padding(.horizontal)
//    }
//}
