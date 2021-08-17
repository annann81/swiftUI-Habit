//
//  AddPlanView.swift
//  Habit
//
//  Created by A2006 on 2021/8/13.
//

import SwiftUI
import CoreData

struct AddPlanView: View {
    
    @State private var planName = ""
    @State private var awardAmount = ""
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var selectSymbolsName: SelectSymbolsName
    
    @State var action: Int? = 0
    
    @Binding var selectPlan: Plan!
    
    var body: some View {
        
        NavigationView {
            ZStack {
                NavigationLink(destination:IconStyleUIView(),tag: 1, selection: $action){}
        
        
                VStack{
                    HStack {
                        Button(action: {
                            selectPlan = nil
                            self.presentationMode.animation().wrappedValue.dismiss()
                            }, label: {
                                Image(systemName: "arrowshape.turn.up.backward")
                                    .font(.system(size: 20))
                            })
                            .buttonStyle(PlainButtonStyle())
                        
                        Spacer()
                        Text(" Add Plan")
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .shadow(color: .red, radius: 2, x: 2, y: 2)
                            
                        Spacer()
                        Button(action: {
                            
                            
                            if (selectPlan != nil) {

                                selectPlan.planName = planName
                                selectPlan.award = Int16(awardAmount)!
                                selectPlan.systemName = selectSymbolsName.symbolsName == "" ? "questionmark.square":selectSymbolsName.symbolsName
                                selectPlan = nil
                            }else{
                            
                            
                            
                                let plan = Plan(context: managedObjectContext)
                                plan.planName = planName ?? ""
                                plan.award = Int16(awardAmount) ?? 0
                                plan.isCheck = false
                                plan.systemName = selectSymbolsName.symbolsName == "" ? "questionmark.square":selectSymbolsName.symbolsName
                            }
                            PersistenceController.shared.save()
                           
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
                        })
        //                .buttonStyle(PlainButtonStyle())
                    
                    
                   
                    FormField(fieldName: "Plan Name", fieldValue: $planName)
        

                    FormField(fieldName: "$$$", fieldValue: $awardAmount)
        
                    Spacer()
                    }//VStack
                
            }//ZStack
            .navigationBarHidden(true)
        }//NavigationView
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        
        
        .onAppear {
            selectSymbolsName.symbolsName = ""
            
            if (selectPlan != nil) {
                planName = selectPlan.planName!
                awardAmount = "\(selectPlan.award)"
                selectSymbolsName.symbolsName = selectPlan.systemName!
        }

        }//onAppear
    }//body
}//View

struct AddPlanView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlanView(selectPlan:.constant(nil))
    }
}






struct FormField: View {
    var fieldName = ""
    @Binding var fieldValue: String
    
    var isSecure = false
    
    var body: some View {
        
        VStack {
            if isSecure {
                SecureField(fieldName, text: $fieldValue)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(red: 251/255, green: 128/255, blue: 128/255))
                    .cornerRadius(5)
                    .padding(10)
                    .border(Color(red: 251/255, green: 128/255, blue: 128/255), width: 1)
                    .cornerRadius(5)
                    .padding()

                
            } else {
                TextField(fieldName, text: $fieldValue)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color(red: 251/255, green: 128/255, blue: 128/255), Color(red: 253/255, green: 193/255, blue: 104/255)]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(5)
                    .padding(5)
                    .border(Color(red: 251/255, green: 128/255, blue: 128/255), width: 1)
                    .cornerRadius(5)
                    .padding()
            }

 
        }
    }
}

struct RequirementText: View {
    
    var iconName = "xmark.square"
    var iconColor = Color(red: 251/255, green: 128/255, blue: 128/255)
    
    var text = ""
    var isStrikeThrough = false
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(iconColor)
            Text(text)
                .font(.system(.body, design: .rounded))
                .foregroundColor(.secondary)
                .strikethrough(isStrikeThrough)
            Spacer()
        }
        .padding(.horizontal)
    }
}
