//
//  BackgroundCard.swift
//  Final
//
//  Created by 陈劭彬 on 2021/1/4.
//

//背景矩形UI设计
import SwiftUI

struct BackgroundCard: View
{
    var number: CGFloat = 4
    var spacing: CGFloat = 15
    
    var body: some View
    {
        GeometryReader { geometry in
            //列
            VStack(spacing: self.spacing)
            {
                ForEach(0..<4) { item in
                    //行
                    HStack(spacing: self.spacing)
                    {
                        ForEach(0..<4) { _ in
                            Rectangle()
                                .frame(width: (geometry.size.width+self.spacing) / self.number-self.spacing , height: (geometry.size.height+self.spacing) / self.number-self.spacing, alignment: .center)
                                //Stack包含n个card和n-1个spacing
                                .foregroundColor(.gray)
                                .cornerRadius(10)
                        }
                    }
                }
            }
        }
    }
}

struct BackgroundCard_Previews: PreviewProvider
{
    static var previews: some View
    {
        BackgroundCard()
    }
}
