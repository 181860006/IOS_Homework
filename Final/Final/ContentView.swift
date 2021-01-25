//
//  ContentView.swift
//  Final
//
//  Created by 陈劭彬 on 2021/1/4.
//

import SwiftUI

let maxWidth = UIScreen.main.bounds.width
let maxHeight = UIScreen.main.bounds.height

struct ContentView: View {
    
    @ObservedObject var UserData: Main = Main()
    @State var gameover = false
    
    //捕捉用户移动手势
    var Gesture: some Gesture
    {
        DragGesture()
            .onEnded({position in
                let translation = position.translation
                withAnimation(.spring())
                {
                    if abs(translation.width) < abs(translation.height)
                    {
                        if translation.height < 0 {self.UserData.moveAndcombine(direction: .up)}
                        else {self.UserData.moveAndcombine(direction: .down)}
                    }
                    else
                    {
                        if translation.width < 0 {self.UserData.moveAndcombine(direction: .left)}
                        else {self.UserData.moveAndcombine(direction: .right)}
                    }
                    if !self.UserData.addNewCard()
                    {
                        gameover = true
                    }
                }
            })
    }
    
    var body: some View
    {
        VStack {
            VStack
            {
                ZStack
                {
                    //背景灰色
                    BackgroundCard()
                        .gesture(self.Gesture)
                    //颜色卡片
                    ForEach(self.UserData.Cards) {item in
                        if !item.deleted
                        {
                            MovingCard(card: item)
                                .environmentObject(self.UserData)
                                .animation(.spring())
                                .transition(.opacity)
                                .gesture(self.Gesture)
                        }
                    }
                }
            }
            .frame(width: min(maxWidth, maxHeight)*0.8, height: min(maxWidth, maxHeight))
            //游戏结束重新开始
            .alert(isPresented: self.$gameover, content: {
                Alert(title: Text("GameOver!"), message: Text("Restart!"), dismissButton: Alert.Button.cancel({self.UserData.restart()}))
            })
            VStack
            {
                Button(action: {
                    self.UserData.restart()
                })
                {
                    Image(systemName: "arrow.counterclockwise")
                        .imageScale(.large)
                        .padding()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
