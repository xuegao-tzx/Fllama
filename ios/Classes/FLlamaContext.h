#ifdef __cplusplus
#import "llama.h"
#import "fllama.hpp"
#endif

// === Llama ===

@interface FLlamaContext : NSObject {
    bool is_metal_enabled;
    NSString * reason_no_metal;
    bool is_model_loaded;
    void (^onProgress)(unsigned int progress);
    fllama::fllama_context * llama;
}

+ (instancetype)initWithParams:(NSDictionary *)params onProgress:(void (^)(unsigned int progress))onProgress;
- (bool)isMetalEnabled;
- (NSString *)reasonNoMetal;
- (NSDictionary *)modelInfo;
- (bool)isModelLoaded;
- (bool)isPredicting;
- (NSDictionary *)completion:(NSDictionary *)params onToken:(void (^)(NSMutableDictionary *tokenResult))onToken;
- (void)stopCompletion;
- (NSArray *)tokenize:(NSString *)text;
- (NSString *)detokenize:(NSArray *)tokens;
- (NSString *)getFormattedChat:(NSArray *)messages withTemplate:(NSString *)chatTemplate;
- (NSDictionary *)loadSession:(NSString *)path;
- (int)saveSession:(NSString *)path size:(int)size;
- (NSString *)bench:(int)pp tg:(int)tg pl:(int)pl nr:(int)nr;

- (void)invalidate;

@end
