//
//  ContentView.swift
//  Ai chat bot with open ai-day2
//
//  Created by Apple  on 16/12/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = APICaller()
    @State var text = ""
    @State var models = [String]()
    var body: some View {
        Text("I am chat GPT made by Alen")
        ScrollView{
            VStack(alignment:.leading){
                ForEach(models,id:\.self){string in
                    Text("\(string)")
                        .padding(.top,10)
                }
                
                Spacer()

            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .onAppear(perform: {
                viewModel.setup()
            })
            .padding()
        }
        
        HStack{
            TextField("type something.....", text: $text)
            Button {
                send()
            } label: {
                Image(systemName:"paperplane.fill")
                    .foregroundColor(Color.white)
            }

        }
        .padding()
    }
    
    func send(){
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else{
            return
        }
        models.append("Me: \(text)")
        viewModel.send(textInput: text) { response in
            DispatchQueue.main.async {
                self.models.append("ChatGPT: \(response )")
                self.text = ""
            }
        }
    }
}

