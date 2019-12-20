/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridCellImage.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NGridImageTextCell.h"

/**
 * The NGridCellImage class is a container for UIImage that simplifies the work with the images in the grid cells.
 */
@interface NGridCellImage : NSObject

/**
 * Base image.
 */
@property (nonatomic, retain) UIImage *image;

/**
 * Size that image should fill.
 */
@property (assign) CGSize size;

/**
 * Width of the margin.
 * Setting up this property changes width of left, right, top and bottom margins.
 */
@property (nonatomic, assign) CGFloat margin;

/**
 * Width of the left margin.
 */
@property (nonatomic, assign) CGFloat leftMargin;

/**
 * Width of the right margin.
 */
@property (nonatomic, assign) CGFloat rightMargin;

/**
 * Width of the top margin.
 */
@property (nonatomic, assign) CGFloat topMargin;

/**
 * Width of the bottom margin.
 */
@property (nonatomic, assign) CGFloat bottomMargin;

/**
 * Image alignment in the cell.
 */
@property (assign) NGridImageAlignment alignment;

/**
 * Z position of image in the cell.
 */
@property (assign) NGridImageZOrder zPosition;

@end
