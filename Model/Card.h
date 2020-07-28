//
//  Card.h
//  Matchismo
//
//  Created by Barak Bukra on 20/07/2020.
//  Copyright © 2020 Barak Bukra. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#ifndef Card_h
#define Card_h

@interface Card : NSObject

@property (strong, nonatomic) NSAttributedString *contents;

@property (nonatomic) BOOL chosen;
@property (nonatomic) BOOL matched;

- (int) match: (NSArray *)otherCards;
@end

#endif /* Card_h */
