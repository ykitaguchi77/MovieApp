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
                        Text("Blink")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .padding(.bottom)
                        
                        Text("①楕円形のガイドに顔の輪郭を合わせる")
                            .font(.title2)
                            .frame(width: bodyView.size.width, alignment: .leading)
                            .padding(.bottom)
                            
                        Text("②画面上部にあるカメラを固視")
                            .font(.title2)
                            .frame(width: bodyView.size.width, alignment: .leading)

                        Image("starePoint")
                            .resizable()
                            .scaledToFit()
                            .frame(width: bodyView.size.width)
                            .padding(.bottom)

                        (Text("③安静状態で")
                        + Text("10秒間")
                            .underline(color: .white)
                        + Text("開瞼"))
                            .font(.title2)
                            .frame(width: bodyView.size.width, alignment: .leading)
                            .padding(.top)
                            .padding(.bottom)
                            
                        Text("④強瞬→開瞼を5回（1秒周期）")
                            .font(.title2)
                            .frame(width: bodyView.size.width, alignment: .leading)
                            .padding(.top)
                            .padding(.bottom)

                        (Text("⑤安静状態で")
                        + Text("10秒間")
                            .underline(color: .white)
                        + Text("開瞼"))
                            .font(.title2)
                            .frame(width: bodyView.size.width, alignment: .leading)
                            .padding(.top)
                            .padding(.bottom)
                            
                        Text("⑥軽い自発瞬目を5回（1秒周期）")
                            .font(.title2)
                            .frame(width: bodyView.size.width, alignment: .leading)
                            .padding(.top)
                            .padding(.bottom)
                        
                        (Text("⑦質問（50秒）\n「あなたは上手く目を開けることができますか？」\n「自分の意思だけでできますか？」\n「目や顔、首を触ると開きやすいですか？"))
                            .font(.title2)
                            .multilineTextAlignment(.leading)
                            .frame(width: bodyView.size.width, alignment: .leading)
                            .padding(.top)
                            .padding(.bottom)
                            
                        (Text("⑧安静状態で")
                        + Text("250秒間")
                            .underline(color: .white)
                        + Text("開瞼"))
                            .font(.title2)
                            .frame(width: bodyView.size.width, alignment: .leading)
                            .padding(.bottom)
                        }
                        
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack{
                                Image(systemName: "arrowshape.turn.up.backward")
                                Text("戻る")
                            }
                                .foregroundColor(Color.white)
                                .font(Font.largeTitle)
                        }
                            .frame(minWidth:0, maxWidth:CGFloat.infinity, minHeight: 75)
                            .background(Color.black)
                            .padding()
                    }
                }
            }
        }
    

    }

}
