// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "MDCShapedView.h"

#import "MDCShapedShadowLayer.h"

@interface MDCShapedView ()
@property(nonatomic, readonly, strong) MDCShapedShadowLayer *layer;
@property(nonatomic, readonly) CGSize pathSize;
@end

@implementation MDCShapedView

@dynamic layer;

+ (Class)layerClass {
  return [MDCShapedShadowLayer class];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
// https://stackoverflow.com/questions/24458608/convenience-initializer-missing-a-self-call-to-another-initializer
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  return [super initWithCoder:aDecoder];
}
#pragma clang diagnostic pop

- (nonnull instancetype)initWithFrame:(CGRect)frame {
  return [self initWithFrame:frame shapeGenerator:nil];
}

- (nonnull instancetype)initWithFrame:(CGRect)frame
                       shapeGenerator:(nullable id<MDCShapeGenerating>)shapeGenerator {
  if (self = [super initWithFrame:frame]) {
    self.layer.shapeGenerator = shapeGenerator;
  }
  return self;
}

- (void)setElevation:(CGFloat)elevation {
  self.layer.elevation = elevation;
}

- (CGFloat)elevation {
  return self.layer.elevation;
}

- (void)setShapeGenerator:(id<MDCShapeGenerating>)shapeGenerator {
  self.layer.shapeGenerator = shapeGenerator;
}

- (id<MDCShapeGenerating>)shapeGenerator {
  return self.layer.shapeGenerator;
}

- (UIColor *)shapedBorderColor {
  return self.layer.shapedBorderColor;
}

- (void)setShapedBorderColor:(UIColor *)shapedBorderColor {
  self.layer.shapedBorderColor = shapedBorderColor;
}

- (CGFloat)shapedBorderWidth {
  return self.layer.shapedBorderWidth;
}

- (void)setShapedBorderWidth:(CGFloat)shapedBorderWidth {
  self.layer.shapedBorderWidth = shapedBorderWidth;
}

// MDCShapedView captures backgroundColor assigments so that they can be set to the
// MDCShapedShadowLayer fillColor. If we don't do this the background of the layer will obscure any
// shapes drawn by the shape layer.
- (void)setBackgroundColor:(UIColor *)backgroundColor {
  // We intentionally capture this and don't send it to super so that the UIView backgroundColor is
  // fixed to [UIColor clearColor].
  self.layer.shapedBackgroundColor = backgroundColor;
}

- (UIColor *)backgroundColor {
  return self.layer.shapedBackgroundColor;
}

@end
