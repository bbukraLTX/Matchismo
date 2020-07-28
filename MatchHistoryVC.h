// Copyright (c) 2020 Lightricks. All rights reserved.
// Created by Barak Bukra.

#import "ViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface MatchHistoryVC : ViewController
@property (weak, nonatomic) IBOutlet UITextView *playingCardHistory;
@property (weak, nonatomic) IBOutlet UITextView *setCardHistory;
@property (strong, nonatomic) NSAttributedString *playingCardHistoryString;
@property (strong, nonatomic) NSAttributedString *setCardHistoryString;
@end

NS_ASSUME_NONNULL_END
