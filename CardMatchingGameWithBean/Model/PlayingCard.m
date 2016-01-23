//
//  PlayingCard.m
//  CardMatchingGameWithBean
//
//  Created by Nadine Hachouche on 12/28/15.
//  Copyright © 2015 nadine farah. All rights reserved.
//

#import "PlayingCard.h"

@interface PlayingCard ()

@property (nonatomic, strong) NSMutableArray* matchedCards;


@end

@implementation PlayingCard

-(NSString* )contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}


@synthesize suit = _suit; // because we provide setter AND getter


+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4", @"5", @"6", @"7", @"8", @"9", @"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}


- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}


- (int)match:(NSArray *)otherCards;
{
    int score = 0;
    NSLog(@"OTHER CARDS %ld",[otherCards count]);
    
    PlayingCard *card1 = otherCards[0];
    PlayingCard *card2 = otherCards[1];
    
    if([otherCards count] == 2){
        if(card1.rank == card2.rank){
            score = 4;
        } else if(card1.suit == card2.suit) {
            score = 1;
        }
    }
    
    if ([otherCards count] == 3 ) {
        NSLog(@"3-CARD GAME MATCH");
        
         if(!(self.matchedCards)) self.matchedCards = [NSMutableArray new];
        
        for (int i = 0; i <= ([otherCards count]-1); i++) {
            for (int j= 1; j<= ([otherCards count]-1); j++) {
                if (i != j) {
                    
                    PlayingCard* firstCard = otherCards[i];
                    PlayingCard* secondCard = otherCards[j];
                
                
                        if (firstCard.rank == secondCard.rank) {
                        
                            if ([self.matchedCards count] == 0) {
                                [self.matchedCards addObject:firstCard];
                                [self.matchedCards addObject:secondCard];
                                score = 4;
                            } else if (![self.matchedCards containsObject:firstCard]) {
                                [self.matchedCards addObject:firstCard];
                                score = 4;
                            } else if (![self.matchedCards containsObject:secondCard]) {
                                [self.matchedCards addObject:secondCard];
                                score = 4;
                            }
                            
                        } else if(firstCard.suit == secondCard.suit) {
                            if ([self.matchedCards count] == 0) {
                                [self.matchedCards addObject:firstCard];
                                [self.matchedCards addObject:secondCard];
                                score = 2;
                            } else if (![self.matchedCards containsObject:firstCard]) {
                                [self.matchedCards addObject:firstCard];
                                score = 2;
                            } else if (![self.matchedCards containsObject:secondCard]) {
                                [self.matchedCards addObject:secondCard];
                                score = 2;
                            }
                        }
                }
            }
        }
    }
    
    NSLog(@"SCORE IS: %d", score);
    return score;
                
}






@end

