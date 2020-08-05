//
//  ViewController.h
//  Matchismo
//
//  Created by Barak Bukra on 20/07/2020.
//  Copyright © 2020 Barak Bukra. All rights reserved.
//
#import "CardMatchingGame.h"
#import "Deck.h"
#import "Grid.h"
#import <Foundation/Foundation.h>
#import "CardView.h"
#import <UIKit/UIKit.h>
/// Abstract class
@interface ViewController : UIViewController 
@property (strong, nonatomic) Deck *cardDeck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) Grid *grid;
@property (strong, nonatomic) NSMutableArray<CardView *> *cardViews;
@property (weak, nonatomic) IBOutlet UIView *cardsView;
- (void)chooseCard:(CardView *)sender;
- (void)setup;
- (void)rearrangeBoard;
- (void)swipeCardRight:(UISwipeGestureRecognizer *)sender;
@end

