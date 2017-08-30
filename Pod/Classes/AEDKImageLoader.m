//
//  AEDKImageLoader.m
//  Pods
//
//  Created by Altair on 29/08/2017.
//
//

#import "AEDKImageLoader.h"
#import "AEDKServer.h"

@implementation AEDKImageLoader

@end


@implementation AEDKImageLoader (UIImage)

+ (void)imageWithUrl:(NSURL *)url progress:(void (^)(int64_t, int64_t))progress completed:(void (^)(NSURL * _Nullable, UIImage * _Nullable, NSError * _Nullable))completedBlock {
    NSArray<id<AEDKPlugProtocol>> *delegates = [[AEDKServer server] allDelegates];
    BOOL hasDelegate = NO;
    //有指定的服务代理
    for (id delegate in delegates) {
        if ([delegate conformsToProtocol:@protocol(AEDKImageLoaderPlugProtocol)]) {
            if ([delegate respondsToSelector:@selector(imageWithUrl:progress:completed:)]) {
                [delegate imageWithUrl:url progress:progress completed:completedBlock];
                hasDelegate = YES;
            }
            break;
        }
    }
    if (!hasDelegate && completedBlock) {
        NSError *error = [NSError errorWithDomain:@"AEDKImageLoader" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Loader delegate not found."}];
        completedBlock(url, nil, error);
    }
}

@end


@implementation AEDKImageLoader (UIImageView)

- (void)setDefaultPlaceholderImage:(UIImage *)defaultPlaceholderImage {
    
}

- (UIImage *)defaultPlaceholderImage {
    return nil;
}

- (void)setDefaultContentMode:(UIViewContentMode)defaultContentMode {
    
}

- (UIViewContentMode)defaultContentMode {
    return UIViewContentModeTop;
}

- (void)setDefaultPlaceholderContentMode:(UIViewContentMode)defaultPlaceholderContentMode {

}

- (UIViewContentMode)defaultPlaceholderContentMode {
    return UIViewContentModeTop;
}

- (void)setImageForImageView:(UIImageView *)imageView withUrl:(NSURL *)url {
    [self setImageForImageView:imageView withURL:url placeholderImage:self.defaultPlaceholderImage progress:nil completed:nil];
}

- (void)setImageForImageView:(UIImageView *)imageView withUrl:(NSURL *)url placeholderImage:(UIImage *)image {
    [self setImageForImageView:imageView withURL:url placeholderImage:image progress:nil completed:nil];
}

- (void)setImageForImageView:(UIImageView *)imageView withURL:(NSURL *)url completed:(void (^)(NSURL * _Nullable, UIImage * _Nullable, NSError * _Nullable))completedBlock {
    [self setImageForImageView:imageView withURL:url placeholderImage:self.defaultPlaceholderImage progress:nil completed:completedBlock];
}

- (void)setImageForImageView:(UIImageView *)imageView withURL:(NSURL *)url placeholderImage:(UIImage *)image completed:(void (^)(NSURL * _Nullable, UIImage * _Nullable, NSError * _Nullable))completedBlock {
    [self setImageForImageView:imageView withURL:url placeholderImage:image progress:nil completed:completedBlock];
}

- (void)setImageForImageView:(UIImageView *)imageView withURL:(NSURL *)url progress:(void (^)(int64_t, int64_t))progress completed:(void (^)(NSURL * _Nullable, UIImage * _Nullable, NSError * _Nullable))completedBlock {
    [self setImageForImageView:imageView withURL:url placeholderImage:self.defaultPlaceholderImage progress:progress completed:completedBlock];
}

- (void)setImageForImageView:(UIImageView *)imageView withURL:(NSURL *)url placeholderImage:(UIImage *)placeholder progress:(void (^)(int64_t, int64_t))progress completed:(void (^)(NSURL * _Nullable, UIImage * _Nullable, NSError * _Nullable))completedBlock {
    NSArray<id<AEDKPlugProtocol>> *delegates = [[AEDKServer server] allDelegates];
    BOOL hasDelegate = NO;
    //有指定的服务代理
    for (id delegate in delegates) {
        if ([delegate conformsToProtocol:@protocol(AEDKImageLoaderPlugProtocol)]) {
            if ([delegate respondsToSelector:@selector(setImageForImageView:withURL:placeholderImage:progress:completed:)]) {
                [delegate setImageForImageView:imageView withURL:url placeholderImage:placeholder progress:progress completed:completedBlock];
                hasDelegate = YES;
            }
            break;
        }
    }
    if (!hasDelegate && completedBlock) {
        NSError *error = [NSError errorWithDomain:@"AEDKImageLoader" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Loader delegate not found."}];
        completedBlock(url, nil, error);
    }
}

@end
