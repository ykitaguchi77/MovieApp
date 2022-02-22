//
//  howToTakeBlink.swift
//  MovieApp
//
//  Created by Yoshiyuki Kitaguchi on 2022/02/22.
//

import SwiftUI
import CryptoKit
import AVKit

struct HowToTakeBlink: View {
    
    @ObservedObject var user: User
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var imageData : Data = .init(capacity:0)
    @State var rawImage : Data = .init(capacity:0)
    @State var source:UIImagePickerController.SourceType = .camera

    @State var isActionSheet = true
    @State var isImagePicker = true
    @State private var goTakePhoto: Bool = false  //撮影ボタン
    
    var body: some View {
        NavigationView{
            GeometryReader{bodyView in
                VStack(spacing:0){
                    ScrollView{
                        Group{
                        Text("撮影方法")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .padding(.bottom)
                        Text("画面上部にあるカメラを固視")
                            .font(.title2)
                            .frame(width: bodyView.size.width, alignment: .leading)

                        Image("starePoint")
                            .resizable()
                            .scaledToFit()
                            .frame(width: bodyView.size.width)
                            .padding(.bottom)

                        (Text("①安静状態")
                        + Text("10秒間")
                            .underline(color: .white)
                        + Text("開瞼"))
                            .font(.title2)
                            .frame(width: bodyView.size.width, alignment: .leading)
                            .padding(.top)
                            .padding(.bottom)
                            
                        Text("③強瞬→開瞼を5回（1秒周期）")
                            .font(.title2)
                            .frame(width: bodyView.size.width, alignment: .leading)
                            .padding(.top)
                            .padding(.bottom)

                        (Text("④安静状態で")
                        + Text("10秒間")
                            .underline(color: .white)
                        + Text("開瞼"))
                            .font(.title2)
                            .frame(width: bodyView.size.width, alignment: .leading)
                            .padding(.top)
                            .padding(.bottom)
                            
                        Text("⑤軽い自発瞬目を5回（1秒周期）")
                            .font(.title2)
                            .frame(width: bodyView.size.width, alignment: .leading)
                            .padding(.top)
                            .padding(.bottom)
                        
                        (Text("⑥質問（50秒）\n「あなたは上手く目を開けることができますか？」\n「自分の意思だけでできますか？」\n「目や顔、首を触ると開きやすいですか？"))
                            .font(.title2)
                            .multilineTextAlignment(.leading)
                            .frame(width: bodyView.size.width, alignment: .leading)
                            .padding(.top)
                            .padding(.bottom)
                            
                        (Text("⑦安静状態で")
                        + Text("250秒間")
                            .underline(color: .white)
                        + Text("開瞼"))
                            .font(.title2)
                            .frame(width: bodyView.size.width, alignment: .leading)
                            .padding(.bottom)
                        }
                        

                        Button(action: {
                            self.user.isSendData = false //撮影済みを解除
                            ResultHolder.GetInstance().SetMovieUrls(Url: "")  //動画の保存先をクリア
                            //self.presentationMode.wrappedValue.dismiss()
                            self.goTakePhoto = true /*またはself.show.toggle() */
                        }) {
                            HStack{
                                Image(systemName: "camera")
                                Text("撮影")
                            }
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
            }
        }
    

    }

}
