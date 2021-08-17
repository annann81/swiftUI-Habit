//
//  IconStyleUIView.swift
//  Habit
//
//  Created by A2006 on 2021/8/13.
//

import SwiftUI

struct IconStyleUIView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var selectSymbolsName: SelectSymbolsName
    
    private var symbols = ["heart","bicycle","keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]
    private var colors: [Color] = [.yellow, .purple, .green]
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        HStack {
            Button(action: {
                
                self.presentationMode.animation().wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrowshape.turn.up.backward")
                        .font(.system(size: 20))
                })
                .buttonStyle(PlainButtonStyle())
            
            
            Spacer()
            Text("Plan")
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .shadow(color: .red, radius: 2, x: 2, y: 2)
                
            Spacer()
           
            
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color(red: 251/255, green: 128/255, blue: 128/255), Color(red: 253/255, green: 193/255, blue: 104/255)]), startPoint: .leading, endPoint: .trailing))
        .foregroundColor(.white)
        .edgesIgnoringSafeArea(.all)
        
        
        ScrollView {
            LazyVGrid(columns: gridItemLayout, spacing: 20) {
                ForEach((0..<symbols.count), id: \.self) { index in
                    Image(systemName: symbols[index % symbols.count])
                        .font(.system(size: 30))
                        .frame(width: 50, height: 50)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(red: 251/255, green: 128/255, blue: 128/255), Color(red: 253/255, green: 193/255, blue: 104/255)]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(.white)
                        .cornerRadius(10)

                
                        .onTapGesture {
                            selectSymbolsName.symbolsName = symbols[index]
                            self.presentationMode.animation().wrappedValue.dismiss()
                        }
                }
                
            }
        }
        .navigationBarHidden(true)
    }
}

struct IconStyleUIView_Previews: PreviewProvider {
    static var previews: some View {
        IconStyleUIView()
    }
}
