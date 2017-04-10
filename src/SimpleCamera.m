#import "SimpleCamera.h"
#import <Cordova/CDV.h>
#import <AVFoundation/AVFoundation.h>

@implementation SimpleCamera
//@synthesize captureManager;
- (void)pluginInitialize {
    AVCaptureSession *session = [[AVCaptureSession alloc]init];
    session.sessionPreset = AVCaptureSessionPresetPhoto;
    
    //Add device
    AVCaptureDevice *device =
    [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //Input
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    if (!input)
    {
        NSLog(@"No Input");
    }
    
    [session addInput:input];
    
    //Output
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
    [session addOutput:output];
    output.videoSettings =
    @{ (NSString *)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA) };
    
    //Preview Layer
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    UIView *myView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    previewLayer.frame = myView.bounds;
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [myView.layer addSublayer:previewLayer];
    [self.webView.superview addSubview:myView];
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setOpaque: NO];
    [self.webView.superview bringSubviewToFront: self.webView];
    [self.webView.superview sendSubviewToBack: myView];
    
    //Start capture session
    [session startRunning];
}
@end