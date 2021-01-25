//
//  MovingCard.swift
//  Final
//
//  Created by 陈劭彬 on 2021/1/7.
//

//颜色卡片UI设计
import SwiftUI

struct MovingCard: View
{
    var number: CGFloat = 4
    var spacing: CGFloat = 15
    
    //从CardData中取得实时数据
    @EnvironmentObject var UserData: Main
    var card: Card
    var index: Int {return self.UserData.Cards.firstIndex(where: {$0.id == self.card.id})!}
    
    var body: some View
    {
        GeometryReader { geometry in
            ZStack
            {
                Rectangle()
                //设置文字
                Text(String(self.UserData.Cards[self.index].number))
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
                //设置大小，每个Stack包含n个card和n-1个spacing
                .frame(width: (geometry.size.width+self.spacing) / self.number-self.spacing , height: (geometry.size.height+self.spacing) / self.number-self.spacing, alignment: .center)
                //设置圆角
                .cornerRadius(10)
                //根据坐标移动
                .offset(x: self.UserData.Cards[self.index].coordinates.x*((geometry.size.width+self.spacing) / self.number), y: self.UserData.Cards[self.index].coordinates.y*((geometry.size.height+self.spacing) / self.number))
                //设置颜色
                .foregroundColor(Color(String(self.UserData.Cards[self.index].number)))
        }
    }
}

struct MovingCard_Previews: PreviewProvider
{
    static var previews: some View
    {
        MovingCard(card: Card(number: 2, coordinates: (0,0)))
    }
}
