//
//  Informations.swift
//  CorneaApp
//
//  Created by Yoshiyuki Kitaguchi on 2021/04/18.
//
import SwiftUI

//変数を定義
struct Informations: View {
    @ObservedObject var user: User
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @State var isSaved = false
    @State private var goTakePhoto: Bool = false  //撮影ボタン
    @State var temp = "" //スキャン結果格納用の変数
    
    var body: some View {
        NavigationView{
                Form{
                        Section(header: Text("基本情報"), footer: Text("")){
                            HStack{
                                Text("入力日時")
                                Text(self.user.date, style: .date)
                            }
                            //DatePicker("入力日時", selection: $user.date)
                            
                            Picker(selection: $user.selected_hospital,
                                       label: Text("施設")) {
                                ForEach(0..<user.hospitals.count) {
                                    Text(self.user.hospitals[$0])
                                         }
                                }
                               .onChange(of: user.selected_hospital) {_ in
                                   self.user.isSendData = false
                                   UserDefaults.standard.set(user.selected_hospital, forKey:"hospitaldefault")
                               }
                            
                            
                            HStack {
                                Text("I D ")
                                TextField("idを入力してください", text: $user.id)
                                .keyboardType(.numbersAndPunctuation)
                                .onChange(of: user.id) { _ in
                                    self.user.isSendData = false
                                    }
                                ScanButton(text: $user.id)
                                .frame(width: 100, height: 30, alignment: .leading)
                            }
                            
                            Picker(selection: $user.age,
                                   label: Text("年齢")) {
                                ForEach(0..<100){ age in
                                    Text("\(age)")
                                }
                            }
                           .onChange(of: user.age) { _ in
                               self.user.isSendData = false
                               }

                            
                            HStack{
                                Text("性別")
                                Picker(selection: $user.selected_gender,
                                           label: Text("性別")) {
                                    ForEach(0..<user.gender.count) {
                                        Text(self.user.gender[$0])
                                            }
                                    }
                                    .onChange(of: user.selected_gender) {_ in
                                        self.user.isSendData = false
                                        }
                                    .pickerStyle(SegmentedPickerStyle())
                            }
                        }
                    
                        
                    
                        Section(header: Text("自由記載欄"), footer: Text("")){
                            HStack{
                                Text("自由記載欄")
                                TextField("", text: $user.free_disease)
                                    .keyboardType(.default)
                            }.layoutPriority(1)
                            .onChange(of: user.free_disease) { _ in
                            self.user.isSendData = false
                            }
                        }
                    
                }.navigationTitle("患者情報入力")
                .onAppear(){
                 }
            }
                
            
            Spacer()
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
               }
                
            ) {
                Text("保存")
                    .foregroundColor(Color.white)
                    .font(Font.largeTitle)
            }
                .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                .background(Color.black)
                .padding()
                .sheet(isPresented: self.$goTakePhoto) {
                     //CameraPage(user: user)
                }
    }
}
