//
//  ViewController.m
//  Matchismo
//
//  Created by Barak Bukra on 20/07/2020.
//  Copyright © 2020 Barak Bukra. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardView.h"
#import "SetCardView.h"

@interface ViewController ()
//@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end




@implementation ViewController
static const int kInitialCardCount = 12;


- (Grid *)grid {
  if(!_grid) {
    _grid = [[Grid alloc] init];
    [_grid setSize:self.cardsView.frame.size];
    [_grid setMinimumNumberOfCells:21];
    [_grid setCellAspectRatio:0.667];
  }
  return _grid;
}

- (NSMutableArray<CardView *> *)cardViews {
  if(!_cardViews) {
    _cardViews = [[NSMutableArray alloc] init];
  }
  return _cardViews;
}

- (void)swipeCardRight:(UISwipeGestureRecognizer *)sender {
//    sender.view.faceUp = !self.faceUp;
//  [UIView transitionWithView:sender.view duration: 0.3 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
      [self chooseCard: (CardView *)sender.view];
//  } completion:nil];
}

- (void)rearrangeBoard {
  int i = 0;
  NSUInteger columnCount = [self.grid columnCount];
  for(CardView *cardView in self.cardViews)
  {
    NSUInteger cardButtonIndex = [self.cardViews indexOfObject:cardView];
    Card *card = [self.game cardAtIndex:cardButtonIndex];
    if(!card.matched) {
      [cardView setFrame:[self.grid frameOfCellAtRow: i / columnCount inColumn: i % columnCount]];
      i++;
    }
  }
}

- (void)setup {
  NSMutableArray *cards = [self.game cards];
  NSUInteger columnCount = [self.grid columnCount];
  [self.cardViews removeAllObjects];
  
  int i = 0;
  for(Card *card in cards) {
    if(card.matched) {
      continue;
    }
    CardView *newcard;
    if([self getGameMode] == _2match)
    {
      newcard = [[PlayingCardView alloc]
                           initWithFrame:[self.grid
                                          frameOfCellAtRow: i / columnCount
                                          inColumn: i % columnCount]];
    }
    else
    {
      newcard = [[SetCardView alloc]
                            initWithFrame:[self.grid
                                           frameOfCellAtRow: i / columnCount
                                          inColumn: i % columnCount]];
    }
    
    [newcard setPropertiesWithCard:card];
    [newcard addGestureRecognizer:[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeCardRight:)]];
    [self.cardsView addSubview:newcard];
    [self.cardViews addObject:newcard];
    i++;
  }
}
- (void)tapCardsView: (UITapGestureRecognizer *)sender {
  [UIView transitionWithView:self.cardsView duration:1 options: (UIViewAnimationTransitionFlipFromRight | UIViewAnimationCurveEaseIn) animations:^{
    [self rearrangeBoard];
  } completion:nil];
  
  [self.cardsView removeGestureRecognizer:sender];
}

- (void)panCardsView: (UIPanGestureRecognizer *)sender {
  CGPoint gesturePoint = [sender locationInView:self.cardsView];
//  UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.cardsView];
//  UIAttachmentBehavior *attachmentBehavior;
  if(sender.state == UIGestureRecognizerStateBegan) {
//    attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.cardsView attachedToAnchor:gesturePoint];
//    [animator addBehavior:attachmentBehavior];
    for(CardView *cardView in self.cardViews) {
      [cardView setFrame:CGRectMake(gesturePoint.x,
                                  gesturePoint.y,
                                  cardView.bounds.size.width,
                                  cardView.bounds.size.height)];
    }
  } else if(sender.state == UIGestureRecognizerStateChanged) {
//    attachmentBehavior.anchorPoint = gesturePoint;
    for(CardView *cardView in self.cardViews) {
      [cardView setFrame:CGRectMake(gesturePoint.x,
                                  gesturePoint.y,
                                  cardView.bounds.size.width,
                                  cardView.bounds.size.height)];
    }
  } else if(sender.state == UIGestureRecognizerStateEnded) {
//    [animator removeBehavior:attachmentBehavior];
    [self.cardsView removeGestureRecognizer:sender];
  }
}

- (void)pinchCardsView:(UIPinchGestureRecognizer *)sender {
  [UIView transitionWithView:self.cardsView duration:1 options: (UIViewAnimationTransitionFlipFromRight | UIViewAnimationCurveEaseOut) animations:^{
      for(CardView *cardView in self.cardViews) {
        [cardView setFrame:CGRectMake(self.cardsView.center.x,
                                    self.cardsView.center.y,
                                    cardView.bounds.size.width,
                                    cardView.bounds.size.height)];
      }

  } completion:^(BOOL finished) {
    [self.cardsView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCardsView:)]];
    [self.cardsView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panCardsView:)]];
  }];
  
  
  
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.cardsView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchCardsView:)]];
  [self setup];
}

- (CardMatchingGame *)newGame {
  return [[CardMatchingGame alloc] initWithCardCount:kInitialCardCount usingDeck:[self cardDeck]];
}

- (CardMatchingGame *)game
{
  if(!_game)
  {
    _game = [self newGame];
  }
  return _game;
}

- (Deck *)createNewDeck // abstract
{
  return nil;
}
- (Deck *)cardDeck // abstract
{
  return nil;
}

- (void)chooseCard:(CardView *)sender
{
  NSUInteger chooseButtonIndex = [self.cardViews indexOfObject:sender];
  self.game.gameMode = [self getGameMode];
  [self.game chooseCardAtIndex:chooseButtonIndex];
  [UIView transitionWithView:sender duration: 0.75 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
    [self updateUI];
  } completion:nil];

}



- (void)updateUI
{
//  for(UIButton *cardButton in self.cardButtons)
//  {
//    NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
//    Card *card = [self.game cardAtIndex:cardButtonIndex];
//    [cardButton setAttributedTitle:(card.chosen ? card.contents : [[NSAttributedString alloc] init]) forState:UIControlStateNormal];
//    [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
//    cardButton.enabled = !card.matched;
//  }
//  NSMutableArray<CardView *> *cardsToRemove = [[NSMutableArray alloc] init];
  for(CardView *cardView in self.cardViews) {
    NSUInteger cardButtonIndex = [self.cardViews indexOfObject:cardView];
    Card *card = [self.game cardAtIndex:cardButtonIndex];
    cardView.faceUp = (card.chosen) ? YES : NO;
    if(card.matched) {
      [cardView setFrame:CGRectMake(cardView.frame.origin.x + 1007,
                              cardView.frame.origin.y + 1070,
                              cardView.frame.size.width,
                              cardView.frame.size.height)];
//      [cardsToRemove addObject:cardView];
    }
  }
  [self rearrangeBoard];
//  for(CardView *cardView in cardsToRemove) {
//    [self.cardViews removeObject:cardView];
//  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
  NSString *imageName = card.chosen ? @"cardfront": @"cardback";
  return [UIImage imageNamed: imageName];
}

//- (NSInteger)countChosenCards
//{
//  int count = 0;
//  for(UIButton *cardButton in self.cardButtons)
//  {
//    NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
//    Card *card = [self.game cardAtIndex:cardButtonIndex];
//    if(card.chosen && !card.matched)
//    {
//      count++;
//    }
//  }
//  return count;
//}

- (matchingType)getGameMode { // abstract
  return _2match;
}

- (IBAction)onPressResetButton:(UIButton *)sender
{
  [self.cardViews removeAllObjects];
  [UIView transitionWithView:self.cardsView duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
    for(UIView *view in self.cardsView.subviews) {
      [view removeFromSuperview];
    }
  } completion:nil];
  _cardDeck = [self createNewDeck];
  _game = [self newGame];
  self.game.gameMode = [self getGameMode];
//  [self setup];
  [UIView transitionWithView:self.cardsView duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
    [self setup];
  } completion:nil];
  [self updateUI];
}

@end
