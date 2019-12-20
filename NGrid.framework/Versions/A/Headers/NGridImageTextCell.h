/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridImageTextCell.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NGridTextCell.h"

/**
 * The NGridImageTextCell class provides cell with the text and/or images.
 * See <NGridTextCell> for text setup.
 * Text is laid out in parts of the cell not taken by the images.
 */
@interface NGridImageTextCell : NGridTextCell 

/**
 * Adds the image, scaled to specified size, aligned in the cell and spaced from the border and the text.
 * Image is identified internally by the key. Putting two images with the same key leaves only the last one.
 * @param image Image to put into the cell.
 * @param size Size of the image in the cell.
 * @param alignment Alignment of the image in the cell.
 * @param zPosition Z position of the image in the cell.
 * @param margin Margin width of the image in pixels.
 * @param key Key of the image.
 */
- (void)addImage:(UIImage *)image
      outputSize:(CGSize)size
       alignment:(NGridImageAlignment)alignment
       zPosition:(NGridImageZOrder)zPosition
          margin:(CGFloat)margin
             key:(NSObject<NSCopying> *)key;

/**
 * Adds the image, scaled to the specified size, aligned in the cell and spaced from the border and the text.
 * Image is identified internally by the key. Putting two images with the same key leaves only last one.
 * @param image Image to put into the cell.
 * @param size Size of the image in the cell.
 * @param alignment Alignment of the image in the cell.
 * @param zPosition Z position of the image in the cell.
 * @param leftMargin Width of the left image margin in pixels.
 * @param rightMargin Width of the right image margin in pixels.
 * @param topMargin Width of the top image margin in pixels.
 * @param bottomMargin Width of the bottom image margin in pixels.
 * @param key Key of the image.
 */
- (void)addImage:(UIImage *)image 
      outputSize:(CGSize)size 
       alignment:(NGridImageAlignment)alignment 
       zPosition:(NGridImageZOrder)zPosition 
      leftMargin:(CGFloat)leftMargin 
     rightMargin:(CGFloat)rightMargin 
       topMargin:(CGFloat)topMargin 
    bottomMargin:(CGFloat)bottomMargin 
             key:(NSObject<NSCopying> *)key;

/**
 * Removes the image by the key.
 * @param key Key identifying the image to remove.
 */
- (void)removeImage:(id<NSCopying>)key;

/**
 * Removes all images (must be called if you are reusing cells).
 */
- (void)clearImages;

/**
 * All images contained in a cell.
 */
@property (readonly) NSDictionary *images;

@end
