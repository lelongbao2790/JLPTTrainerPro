//
//  Sound.m
//  JapaneseTrainer
//
//  Created by Bao (Brian) L. LE on 5/26/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import "Sound.h"
#import <AVFoundation/AVFoundation.h>
@interface Sound ()

@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;
@property (strong, nonatomic) AVSpeechUtterance *utterance;

@end

@implementation Sound

//*****************************************************************************
#pragma mark -
#pragma mark ** Singleton object **
+ (Sound *)shared {
    static dispatch_once_t once;
    static Sound *share;
    dispatch_once(&once, ^{
        share = [[self alloc] init];
    });
    return share;
}

- (instancetype) init{
    self = [super init];
    if (self) {
        self.synthesizer = [[AVSpeechSynthesizer alloc] init];
        if(iOSVersion < 9.0)
        {
            self.speedValue = 0;
            self.utterance.rate = self.speedValue;
        }
        else {
            self.speedValue = 0.42;
            self.utterance.rate = self.speedValue;
        }
    }
    
    return self;
}

- (void)playSoundWithText:(NSString *)text {
    if (text.length > 0) {
        self.utterance = [AVSpeechUtterance
                          speechUtteranceWithString:text];
        self.utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"ja-JP"];
        
        self.utterance.rate = self.speedValue;
        
        if ([self.synthesizer isSpeaking]) {
            [self.synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
            [self.synthesizer speakUtterance:self.utterance];
        }
        else {
            [self.synthesizer speakUtterance:self.utterance];
        }

    }
}

@end
