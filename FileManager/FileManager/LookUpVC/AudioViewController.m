//  音频播放
//  AudioViewController.m
//  FileManager
//
//  Created by Alan on 2018/2/5.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "AudioViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AudioViewController ()<AVAudioPlayerDelegate>
@property(nonatomic,strong)AVAudioPlayer * audioPlayer;
@end

@implementation AudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:self.audioUrl error:nil];
    NSString * msg = [NSString stringWithFormat:@"音频文件声道数:%ld\n 音频文件持续时间:%g",self.audioPlayer.numberOfChannels,self.audioPlayer.duration];
    NSLog(@"%@",msg);
    self.audioPlayer.numberOfLoops = -1;
    self.audioPlayer.delegate = self;
    [self.audioPlayer play];
}


@end
