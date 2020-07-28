//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Barak Bukra on 21/07/2020.
//  Copyright © 2020 Barak Bukra. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifndef CardMatchingGame_h
#define CardMatchingGame_h

#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck NS_DESIGNATED_INITIALIZER;

- (void)chooseCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

typedef enum
{
  _2match = 2 , _3match = 3
} matchingType;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) BOOL hasGameStarted;
@property (nonatomic) matchingType gameMode;

@end
//@property (nonatomic, readonly) NSMutableArray<Card *> *chosenCards;

#endif /* CardMatchingGame_h */
