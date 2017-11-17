//
//  ViewController.m
//  CheckAppVersion
//
//  Created by Jobs on 17/11/2560 BE.
//  Copyright © 2560 Jobs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _lblShowMoreInfo.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCheckAppVersion:(id)sender {
    [self.btnCheckAppVersion setTitle:@"Checking..."
                             forState:UIControlStateNormal];
    [self needsUpdate];
}

-(BOOL) needsUpdate{
    NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    //NSString* appID = infoDictionary[@"CFBundleIdentifier"];
    //Sample app bundle
    
    NSString* appID = @"com.clubprophetsystems.cpsair";
    NSString* appURL = @"http://itunes.apple.com/lookup?bundleId=%@";
    NSString* appMassage = @"Need to update App store \n V:%@ \n But Your device \n V:%@";
    NSString* appMessage1 = @"Same version or \n on local device to higher than app store version.";
    
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:appURL, appID]];
    NSData* data = [NSData dataWithContentsOfURL:url];
    NSDictionary* lookup = [NSJSONSerialization JSONObjectWithData:data
                                                           options:0
                                                             error:nil];
    
    if ([lookup[@"resultCount"] integerValue] == 1){
        NSString* appStoreVersion = lookup[@"results"][0][@"version"];
        NSString* currentVersion = infoDictionary[@"CFBundleShortVersionString"];
        if (![appStoreVersion isEqualToString:currentVersion]){
            NSLog(@"Need to update [%@ != %@]", appStoreVersion, currentVersion);
            
            [self.btnCheckAppVersion setTitle:@"Need to update"
                                     forState:UIControlStateNormal];
    
            NSString* sMessage = [NSString stringWithFormat:
                                  appMassage,
                                  appStoreVersion,
                                  currentVersion];
            _lblShowMoreInfo.textAlignment = NSTextAlignmentCenter;
            _lblShowMoreInfo.hidden = NO;
            _lblShowMoreInfo.text = sMessage;
            _lblShowMoreInfo.numberOfLines = 0;
            
            return YES;
        }else{
        // Same version or on local device to higher than app store version.
        [self.btnCheckAppVersion setTitle:@"Try again..."
                                 forState:UIControlStateNormal];
            _lblShowMoreInfo.text = appMessage1;
            _lblShowMoreInfo.textAlignment = NSTextAlignmentCenter;
            _lblShowMoreInfo.hidden = NO;
            _lblShowMoreInfo.numberOfLines = 0;
        }
    }
    return NO;
}

@end
