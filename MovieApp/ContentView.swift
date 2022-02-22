//
//  ContentView.swift
//  CorneaApp
//
//  Created by Yoshiyuki Kitaguchi on 2021/04/18.
//
//写真Coredata参考サイト：https://tomato-develop.com/swiftui-camera-photo-library-core-data/
//

//hoWToTakeViewでカメラビューに移行する際にシートが消えない問題→ボタンを分ける実装wで

import SwiftUI
import CoreData

//変数を定義
class User : ObservableObject {
    @Published var date: Date = Date()
    @Published var age: Int = -1
    @Published var id: String = ""
    @Published var hashid: String = ""
    @Published var selected_gender: Int = -1
    @Published var selected_hospital: Int = 0
    @Published var selected_disease: Int = 0
    @Published var selected_movieType: Int = 0
    @Published var free_disease: String = ""
    @Published var gender: [String] = ["男", "女"]
    @Published var hospitals: [String] = ["", "大阪大"]
    @Published var diseases: [String] = ["", "正常", "甲状腺眼症", "眼瞼痙攣"]
    @Published var movieTypes: [String] = ["", "Rotating", "Blinking"]
    @Published var imageNum: Int = 0 //写真の枚数（何枚目の撮影か）
    @Published var isNewData: Bool = false
    @Published var isSendData: Bool = false
    }


struct ContentView: View {
    @ObservedObject var user = User()
    @State private var goTakePhoto: Bool = false  //撮影ボタン
    @State private var isPatientInfo: Bool = false  //患者情報入力ボタン
    @State private var goSendData: Bool = false  //送信ボタン
    @State private var goRotate: Bool = false  //送信ボタン
    @State private var goBlink: Bool = false  //送信ボタン
    @State private var savedData: Bool = false  //送信ボタン
    @State private var newPatient: Bool = false  //送信ボタン
    
    
    var body: some View {
        VStack(spacing:0){
            Text("Movie app")
                .font(.largeTitle)
                .padding(.bottom)
            
            Image("MovieIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
            
            Button(action: {
                //病院番号はアプリを落としても保存されるようにしておく
                self.user.selected_hospital = UserDefaults.standard.integer(forKey: "hospitaldefault")
                self.isPatientInfo = true /*またはself.show.toggle() */
                
            }) {
                HStack{
                    Image(systemName: "info.circle")
                    Text("患者情報入力")
                }
                    .foregroundColor(Color.white)
                    .font(Font.largeTitle)
            }
                .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                .background(Color.black)
                .padding()
            .sheet(isPresented: self.$isPatientInfo) {
                Informations(user: user)
                //こう書いておかないとmissing as ancestorエラーが時々でる
            }
            
            
            HStack{
                
                Button(action: {
                    self.goTakePhoto = true /*またはself.show.toggle() */
                    self.user.selected_movieType = 1
                    self.user.isSendData = false //撮影済みを解除
                    ResultHolder.GetInstance().SetMovieUrls(Url: "")  //動画の保存先をクリア
                }) {
                    HStack{
                        Image(systemName: "eye.circle")
                        Text("Rotate")
                    }
                        .foregroundColor(Color.white)
                        .font(Font.largeTitle)
                }
                    .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                    .background(Color.black)
                    .padding()
                .sheet(isPresented: self.$goTakePhoto) {
                        CameraPage(user: user)
                }
                
                Button(action: {
                    self.goTakePhoto = true /*またはself.show.toggle() */
                    self.user.selected_movieType = 2
                    self.user.isSendData = false //撮影済みを解除
                    ResultHolder.GetInstance().SetMovieUrls(Url: "")  //動画の保存先をクリア
                }) {
                    HStack{
                        Image(systemName: "eyebrow")
                        Text("Blink")
                    }
                        .foregroundColor(Color.white)
                        .font(Font.largeTitle)
                }
                    .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                    .background(Color.black)
                    .padding()
                .sheet(isPresented: self.$goTakePhoto) {
                    CameraPage(user: user)
                }
            }
            
            HStack{
                
                Button(action: {
                    self.goRotate = true /*またはself.show.toggle() */
                    self.user.isSendData = false //撮影済みを解除
                    ResultHolder.GetInstance().SetMovieUrls(Url: "")  //動画の保存先をクリア
                }) {
                    HStack{
                        Image(systemName: "questionmark.circle")
                        Text("撮影方法")
                    }
                        .foregroundColor(Color.white)
                        .font(Font.body)
                }
                    .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                    .background(Color.black)
                    .padding()
                .sheet(isPresented: self.$goRotate) {
                    HowToTakeRotate(user: user)
                }
                
                Button(action: {
                    self.goBlink = true /*またはself.show.toggle() */
                    self.user.isSendData = false //撮影済みを解除
                    ResultHolder.GetInstance().SetMovieUrls(Url: "")  //動画の保存先をクリア
                }) {
                    HStack{
                        Image(systemName: "questionmark.circle")
                        Text("撮影方法")
                    }
                        .foregroundColor(Color.white)
                        .font(Font.body)
                }
                    .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                    .background(Color.black)
                    .padding()
                .sheet(isPresented: self.$goBlink) {
                    HowToTakeBlink(user: user)
                }
            }
            
            //送信するとボタンの色が変わる演出
            if self.user.isSendData {
                Button(action: {self.goSendData = true /*またはself.show.toggle() */}) {
                    HStack{
                        Image(systemName: "square.and.arrow.up")
                        Text("送信済み")
                    }
                        .foregroundColor(Color.white)
                        .font(Font.largeTitle)
                }
                    .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                    .background(Color.blue)
                    .padding()
                .sheet(isPresented: self.$goSendData) {
                    SendData(user: user)
                }
            } else {
                Button(action: { self.goSendData = true /*またはself.show.toggle() */ }) {
                    HStack{
                        Image(systemName: "square.and.arrow.up")
                        Text("送信")
                    }
                        .foregroundColor(Color.white)
                        .font(Font.largeTitle)
                }
                    .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                    .background(Color.black)
                    .padding()
                .sheet(isPresented: self.$goSendData) {
                    SendData(user: user)
                }
            }
            
            Button(action: { self.newPatient = true /*またはself.show.toggle() */ }) {
                HStack{
                    Image(systemName: "stop.circle")
                    Text("次患者")
                }
                    .foregroundColor(Color.white)
                    .font(Font.largeTitle)
            }
            .alert(isPresented:$newPatient){
                Alert(title: Text("データをクリアしますか？"), primaryButton:.default(Text("はい"),action:{
                    //データの初期化
                    self.user.date = Date()
                    self.user.id = ""
                    self.user.hashid = ""
                    self.user.imageNum = 0
                    self.user.age = -1
                    self.user.selected_hospital = -1
                    self.user.selected_disease = -1
                    self.user.free_disease = ""
                    self.user.isSendData = false
                    
                }),
                      secondaryButton:.destructive(Text("いいえ"), action:{}))
                }
                .frame(minWidth:0, maxWidth:200, minHeight: 75)
                .background(Color.black)
                .padding()
            }
        
    }
}
