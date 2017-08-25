//
//  ColorGenerator.h
//  shyStudent
//
//  Created by Jaewon Kim on 2017-08-24.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ColorGenerator : NSObject

@property (nonatomic, strong) NSMutableArray<UIColor*> *colorsArray;

-(UIColor*)randomColor;

@end
