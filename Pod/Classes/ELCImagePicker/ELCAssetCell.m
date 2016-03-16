//
//  AssetCell.m
//
//  Created by ELC on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import "ELCAssetCell.h"
#import "ELCAsset.h"
#import "ELCConsole.h"
#import "ELCOverlayImageView.h"
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kWIDTH (kSCREEN_WIDTH - 20 )/4.0
@interface ELCAssetCell ()

@property (nonatomic, strong) NSArray *rowAssets;
@property (nonatomic, strong) NSMutableArray *imageViewArray;
@property (nonatomic, strong) NSMutableArray *overlayViewArray;

@end

@implementation ELCAssetCell

//Using auto synthesizers

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	if (self) {
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
        [self addGestureRecognizer:tapRecognizer];
        
        NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:4];
        self.imageViewArray = mutableArray;
        
        NSMutableArray *overlayArray = [[NSMutableArray alloc] initWithCapacity:4];
        self.overlayViewArray = overlayArray;
        
        self.alignmentLeft = YES;
	}
	return self;
}

- (void)setAssets:(NSArray *)assets
{
    self.rowAssets = assets;
	for (UIImageView *view in _imageViewArray) {
        [view removeFromSuperview];
	}
    for (ELCOverlayImageView *view in _overlayViewArray) {
        [view removeFromSuperview];
	}
    //set up a pointer here so we don't keep calling [UIImage imageNamed:] if creating overlays
    UIImage *overlayImage = nil;
    for (int i = 0; i < [_rowAssets count]; ++i) {

        ELCAsset *asset = [_rowAssets objectAtIndex:i];

        if (i < [_imageViewArray count]) {
            UIImageView *imageView = [_imageViewArray objectAtIndex:i];
            imageView.image = [UIImage imageWithCGImage:asset.asset.thumbnail];
        } else {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:asset.asset.thumbnail]];
            [_imageViewArray addObject:imageView];
        }
        
        if (i < [_overlayViewArray count]) {
            ELCOverlayImageView *overlayView = [_overlayViewArray objectAtIndex:i];
            overlayView.hidden = asset.selected ? NO : YES;
            overlayView.labIndex.text = [NSString stringWithFormat:@"%ld", (long)(asset.index + 1)];
        } else {
            if (overlayImage == nil) {
                NSBundle *mainBundle = [NSBundle bundleForClass:[ELCAssetCell class]];

                NSBundle *resourcesBundle = [NSBundle bundleWithPath:[mainBundle pathForResource:@"ZJPhotoPod" ofType:@"bundle"]];
                
                if (resourcesBundle == nil) {
                    resourcesBundle = mainBundle;
                }
   
                overlayImage = [UIImage imageNamed:@"Overlay" inBundle:resourcesBundle compatibleWithTraitCollection:nil];
                //图片缩放处理
                overlayImage = [self reSizeImage:overlayImage toSize:CGSizeMake(kWIDTH, kWIDTH)];
                
            }
            ELCOverlayImageView *overlayView = [[ELCOverlayImageView alloc] initWithImage:overlayImage];
            [_overlayViewArray addObject:overlayView];
            overlayView.hidden = asset.selected ? NO : YES;
            overlayView.labIndex.text = [NSString stringWithFormat:@"%ld", (long)(asset.index + 1)];
        }
    }
}
/**
 *  @author Jason He, 16-03-16
 *
 *  @brief 图片缩放处理

 *
 *  @param origImage 原图
 *  @param reSize    处理后的image
 *
 *  @return 返回处理后的Image
 */
- (UIImage *)reSizeImage:(UIImage *)origImage toSize:(CGSize)reSize
{
    if (origImage.size.width == reSize.width) {
        return origImage;
    }
    
    UIGraphicsBeginImageContext(reSize);
    [origImage drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resImage;
    
}
- (void)cellTapped:(UITapGestureRecognizer *)tapRecognizer
{
    CGPoint point = [tapRecognizer locationInView:self];
    int c = (int32_t)self.rowAssets.count;
    CGFloat totalWidth = c * kWIDTH + (c - 1) * 4;
    CGFloat startX;
    
    if (self.alignmentLeft) {
        startX = 4;
    }else {
        startX = (self.bounds.size.width - totalWidth) / 2;
    }
    
	CGRect frame = CGRectMake(startX, 2, kWIDTH, kWIDTH);
	
	for (int i = 0; i < [_rowAssets count]; ++i) {
        if (CGRectContainsPoint(frame, point)) {
            ELCAsset *asset = [_rowAssets objectAtIndex:i];
            asset.selected = !asset.selected;
            ELCOverlayImageView *overlayView = [_overlayViewArray objectAtIndex:i];
            overlayView.hidden = !asset.selected;
            if (asset.selected) {
                asset.index = [[ELCConsole mainConsole] numOfSelectedElements];
                [overlayView setIndex:asset.index+1];
                [[ELCConsole mainConsole] addIndex:asset.index];
            }
            else
            {
                NSInteger lastElement = [[ELCConsole mainConsole] numOfSelectedElements] - 1;
                [[ELCConsole mainConsole] removeIndex:lastElement];
            }
            break;
        }
        frame.origin.x = frame.origin.x + frame.size.width + 4;
    }
}

- (void)layoutSubviews
{
    int c = (int32_t)self.rowAssets.count;
    CGFloat totalWidth = c * kWIDTH + (c - 1) * 4;
    CGFloat startX;
    
    if (self.alignmentLeft) {
        startX = 4;
    }else {
        startX = (self.bounds.size.width - totalWidth) / 2;
    }
    
	CGRect frame = CGRectMake(startX, 2, kWIDTH, kWIDTH);
	
	for (int i = 0; i < [_rowAssets count]; ++i) {
		UIImageView *imageView = [_imageViewArray objectAtIndex:i];
		[imageView setFrame:frame];
		[self addSubview:imageView];
        
        ELCOverlayImageView *overlayView = [_overlayViewArray objectAtIndex:i];
        [overlayView setFrame:frame];
        [self addSubview:overlayView];
		
		frame.origin.x = frame.origin.x + frame.size.width + 4;
	}
}


@end
