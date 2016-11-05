//
// GMDCircleLoader.h
//
// Copyright (c) 2014 Gabe Morales
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#pragma mark - Definitions
//----------------------------------
// To change the color and frame size of the spinner, simply change the color and frame definition here.
//----------------------------------

//#define SCREEN_HEIGHT_VIEW = [[UIScreen mainScreen] bounds].size.height;
//#define SCREEN_WIDTH_VIEW  = [[UIScreen mainScreen] bounds].size.width;


#define GMD_SPINNER_COLOR       [UIColor colorWithRed:255.0/255 green:206.0/255 blue:24.0/255 alpha:1.0]
//[UIColor colorWithRed:0.129 green:0.455 blue:0.627 alpha:1.0]
#define GMD_SPINNER_FRAME       CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT)
#define GMD_SPINNER_IMAGE       CGRectMake(15, 15,30,30)
#define GMD_IMAGE               [UIImage imageNamed:@"image"]
#define GMD_SPINNER_RADIUS 40.0F
#define GMD_SPINNER_LINE_WIDTH  5.0f //fmaxf(self.frame.size.width * 0.025, 1.f)

#pragma mark - Interface

@interface GMDCircleLoader : UIView

@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) UIColor *lineTintColor;

- (void)start;

- (void)stop;

+ (GMDCircleLoader *)setOnView:(UIView *)view withTitle:(NSString *)title animated:(BOOL)animated;

+ (BOOL)hideFromView:(UIView *)view animated:(BOOL)animated;

@end