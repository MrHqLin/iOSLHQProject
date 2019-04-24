//
//  LHQFFmpegPlayerViewController.m
//  iOSLHQProject
//
//  Created by WaterWorld on 2019/3/13.
//  Copyright © 2019年 water. All rights reserved.
//

#import "LHQFFmpegHelloWorldViewController.h"
//#include <libavcodec/avcodec.h>
//#include <libavformat/avformat.h>
//#include <libavfilter/avfilter.h>

@interface LHQFFmpegHelloWorldViewController ()
@property (weak, nonatomic) IBOutlet UILabel *content;

@end

@implementation LHQFFmpegHelloWorldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    DLog(@"%s",avcodec_configuration());
}

/*
- (IBAction)getProtocol:(id)sender {
    char info[40000] = {0};
    struct URLProtocol *pup = NULL;
    // Input
    struct URLProtocol **p_temp = &pup;
    avio_enum_protocols((void **)p_temp, 0);
    while ((*p_temp) != NULL){
        sprintf(info, "%s[In ][%10s]\n", info, avio_enum_protocols((void **)p_temp, 0));
    }
    pup = NULL;
    //Output
    avio_enum_protocols((void **)p_temp, 1);
    while ((*p_temp) != NULL){
        sprintf(info, "%s[Out][%10s]\n", info, avio_enum_protocols((void **)p_temp, 1));
    }
    //printf("%s", info);
    NSString * info_ns = [NSString stringWithFormat:@"%s", info];
    self.content.text=info_ns;
}

- (IBAction)getFormat:(id)sender {
    char info[40000] = {0};
//    AVInputFormat *if_temp = av_iformat_next(NULL);
//    AVOutputFormat *of_temp = av_oformat_next(NULL);
    void *i = 0;
    void *j = 0;
    const AVInputFormat *if_temp = NULL;
    const AVOutputFormat *of_temp = NULL;
    while ((if_temp = av_demuxer_iterate(&i))) {
        sprintf(info, "%s[In][%10s]\n",info,if_temp->name);
//        if_temp = if_temp->next;
    }
    //Output
    while ((of_temp = av_muxer_iterate(&j))){
        sprintf(info, "%s[Out]%10s\n", info, of_temp->name);
//        of_temp = of_temp->next;
    }

    NSString * info_ns = [NSString stringWithFormat:@"%s", info];
    self.content.text = info_ns;
}

- (IBAction)getCodec:(id)sender {
    char info[40000] = {0};
    void *i = 0;
    const AVCodec *c_temp = NULL;
    while ((c_temp = av_codec_iterate(&i))) {
        if (c_temp->decode != NULL) {
            sprintf(info, "%s[Dec]\n",info);
        }else{
            sprintf(info, "%s[Enc]\n",info);
        }
        switch (c_temp->type) {
            case AVMEDIA_TYPE_VIDEO:
                sprintf(info, "%s[Video]\n",info);
                break;
            case AVMEDIA_TYPE_AUDIO:
                sprintf(info, "%s[Audio]\n",info);
                break;
                
            default:
                sprintf(info, "%s[Other]\n",info);
                break;
        }
        sprintf(info, "%s%10s",info,c_temp->name);
    }
    NSString * info_ns = [NSString stringWithFormat:@"%s", info];
    self.content.text = info_ns;
}

- (IBAction)getFilter:(id)sender {
    char info[40000] = {0};
    void *i = 0;
    const AVFilter *filter = NULL;
    while ((filter = av_filter_iterate(&i))) {
        sprintf(info, "%s[%10s]\n",info,filter->name);
    }
    NSString * info_ns = [NSString stringWithFormat:@"%s", info];
    self.content.text = info_ns;
}

- (IBAction)getConfigure:(id)sender {
    char info[40000] = {0};
    sprintf(info, "%s\n", avcodec_configuration());
    NSString * info_ns = [NSString stringWithFormat:@"%s", info];
    self.content.text = info_ns;
}

#pragma mark -- dataSource
- (NSMutableAttributedString *)lhqNavigationBarTitle:(LHQNavigationBar *)navigationBar{
    return [self changeTitle:@"FFmpeg Hello World"];
}
*/

@end
