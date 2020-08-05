// Copyright (c) 2020 Lightricks. All rights reserved.
// Created by Barak Bukra.

#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation CardView


- (void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

//abstract
- (void)setPropertiesWithCard:(Card *)card {
  return;
}

- (IBAction)swipeCardRight:(UISwipeGestureRecognizer *)sender {
  [UIView transitionWithView:self duration: 0.3 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
    self.faceUp = !self.faceUp;
  } completion:nil];
//  chooseCard
}

#pragma mark - Initialization

- (void)setup
{
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
//  [self addGestureRecognizer:[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeCardRight:)]];
  
}

- (void)awakeFromNib
{
  [super awakeFromNib];
  [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }

// abstract method
- (void)drawFaceUp {
  return;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    if (self.faceUp) {
      [self drawFaceUp];
    } else {
        [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
    }
}

@end

NS_ASSUME_NONNULL_END
