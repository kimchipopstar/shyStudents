//
//  ColorGenerator.m
//  shyStudent
//
//  Created by Jaewon Kim on 2017-08-24.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

#import "ColorGenerator.h"



@implementation ColorGenerator

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.colorsArray = [self colors];
    }
    return self;
}

- (NSMutableArray<UIColor *>*) colors {
    UIColor *redColor = [UIColor redColor];
    UIColor *blueColor = [UIColor blueColor];
    UIColor *yellowColor = [UIColor brownColor];
    
    NSMutableArray<UIColor*> *colorsArray = [[NSMutableArray alloc]initWithObjects:redColor,blueColor,yellowColor, nil];
    
    return colorsArray;
}

-(UIColor*)randomColor{
    int randomNumber = arc4random_uniform(self.colorsArray.count);
    UIColor *randomColor = self.colorsArray[randomNumber];
    return randomColor;
}

@end
