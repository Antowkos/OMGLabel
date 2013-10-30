//
//  ViewController.m
//  OMGLabel
//
//  Created by Anton on 25.10.13.
//  

#import "ViewController.h"
#import "OMGLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
	// Do any additional setup after loading the view, typically from a nib.
    OMGLabel *l = [[OMGLabel alloc] init];
    [l setFrame:CGRectMake(10, 20, 300, [UIScreen mainScreen].bounds.size.height - 60)];
    [l setFont:[UIFont systemFontOfSize:40]];
    [l setBackgroundColor:[UIColor lightGrayColor]];
    [l setText:@"Any\n language 例如簡單的文本行 русский ℗©∰☃℆¿⸘➩ @!#($^&\n Lìrú jiǎndān wénběn háng.\n Great?"];
    [l setTAlignment:OMGLabelTextAlignmentMiddle];
    [l setVAlignment:OMGLabelTextVerticalAlignmentBottom];
    [l setKern:3.0f];
    [l setLineSpacing:-4.0f];
    OMGLabelSettings *settings = [[OMGLabelSettings alloc] init];
    [settings addSettings:@{
                            @(0):@{@(OMGLabelSettingsTextAlignment) : @(OMGLabelTextAlignmentRight),
                                   @(OMGLabelSettingsShadow) : @(NO)},
                            @(1):@{@(OMGLabelSettingsFillColor): [UIColor whiteColor]},
                            @(2):@{@(OMGLabelSettingsFillColor): [UIColor yellowColor]},
                            @(4):@{@(OMGLabelSettingsGradientColors): @[[UIColor redColor],[UIColor orangeColor],[UIColor yellowColor]],
                                   @(OMGLabelSettingsTextAlignment) : @(OMGLabelTextAlignmentLeft)},
                            @(7):@{@(OMGLabelSettingsLineSpacing) : @(0.5f)}
                            }];
    [l setSettings:settings];
    [l setGradientColors:@[
                           [UIColor redColor],
                           [UIColor orangeColor],
                           [UIColor yellowColor],
                           [UIColor greenColor],
                           [UIColor blueColor],
                           [UIColor purpleColor]
                           ]];
    [self.view addSubview:l];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
