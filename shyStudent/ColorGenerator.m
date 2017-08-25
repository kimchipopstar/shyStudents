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

     UIColor *oneColor = [UIColor blueColor];
     UIColor *secondColor = [UIColor darkGrayColor];
     UIColor *thirdColor = [UIColor lightGrayColor];
 

    NSMutableArray<UIColor*> *colorsArray = [[NSMutableArray alloc]initWithObjects:oneColor,secondColor,thirdColor, nil];
    
    return colorsArray;
}

-(UIColor*)randomColor{
    int randomNumber = arc4random_uniform(self.colorsArray.count);
    UIColor *randomColor = self.colorsArray[randomNumber];
    return randomColor;
}

@end
