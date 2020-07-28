//
//  ViewController.h
//  Matchismo
//
//  Created by Barak Bukra on 20/07/2020.
//  Copyright © 2020 Barak Bukra. All rights reserved.
//
#import "CardMatchingGame.h"
#import "Deck.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/// Abstract class
@interface ViewController : UIViewController 
@property (strong, nonatomic) Deck *cardDeck;
@property (readonly, nonatomic) NSMutableAttributedString *history;
@end

