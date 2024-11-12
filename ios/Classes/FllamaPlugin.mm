#import <CommonCrypto/CommonDigest.h>
#import <Metal/Metal.h>
#include <sys/sysctl.h>
#include <sys/types.h>
#import "FllamaPlugin.h"
#import "FLlamaContext.h"

@implementation FllamaPlugin{
    FlutterEventSink _eventSink;
}

NSMutableDictionary *llamaContexts;
int jobId;
dispatch_queue_t llamaDQueue;

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel
                                     methodChannelWithName:@"fllama"
                                           binaryMessenger:[registrar messenger]];
    FlutterEventChannel *eventChannel = [FlutterEventChannel
                                         eventChannelWithName:@"fllama_event_channel"
                                              binaryMessenger:[registrar messenger]];

    FllamaPlugin *instance = [[FllamaPlugin alloc] init];

    [registrar addMethodCallDelegate:instance channel:channel];

    [eventChannel setStreamHandler:instance];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSLog(@"handleMethodCall = %@ ", call.method);

    if ([@"initContext" isEqualToString:call.method]) {
        [self handleInitContext:call result:result];
    } else if ([@"getFormattedChat" isEqualToString:call.method]) {
        [self handleGetFormattedChat:call result:result];
    } else if ([@"loadSession" isEqualToString:call.method]) {
        [self handleLoadSession:call result:result];
    } else if ([@"saveSession" isEqualToString:call.method]) {
        [self handleSaveSession:call result:result];
    } else if ([@"completion" isEqualToString:call.method]) {
        [self handleCompletion:call result:result];
    } else if ([@"stopCompletion" isEqualToString:call.method]) {
        [self handleStopCompletion:call result:result];
    } else if ([@"tokenize" isEqualToString:call.method]) {
        [self handleTokenize:call result:result];
    } else if ([@"detokenize" isEqualToString:call.method]) {
        [self handleDetokenize:call result:result];
    } else if ([@"bench" isEqualToString:call.method]) {
        [self handleBench:call result:result];
    } else if ([@"releaseContext" isEqualToString:call.method]) {
        [self handleReleaseContext:call result:result];
    } else if ([@"releaseAllContexts" isEqualToString:call.method]) {
        [self handleReleaseAllContexts:call result:result];
    } else if ([@"getCpuInfo" isEqualToString:call.method]) {
        [self handleGetCpuInfo:call result:result];
    } else if ([@"getFileSHA256" isEqualToString:call.method]) {
        [self handleGetFileSHA256:call result:result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events {
    _eventSink = events;
    return nil;
}

- (FlutterError *)onCancelWithArguments:(id)arguments {
    _eventSink = nil;
    return nil;
}

// === LLama ===

- (void)handleInitContext:(FlutterMethodCall *)call result:(FlutterResult)result {
    @try {
        NSDictionary *params = call.arguments;

        if (llamaDQueue == nil) {
            llamaDQueue = dispatch_queue_create("ink.fllama", DISPATCH_QUEUE_SERIAL);
        }

        if (llamaContexts == nil) {
            llamaContexts = [[NSMutableDictionary alloc] init];
        }

        // Llama
        FLlamaContext *context = [FLlamaContext initWithParams:params
                                                    onProgress:^(unsigned int progress) {
            if (![params[@"emit_load_progress"] boolValue]) {
                return;
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                               if (_eventSink) {
                                   _eventSink(@{
                        @"function": @"loadProgress",
                        @"contextId": @"",
                        @"result": @(progress)
                        });
                               }
                           });
        }];

        if (![context isModelLoaded]) {
            result([FlutterError errorWithCode:@"505" message:@"Failed to load the model" details:nil]);
            return;
        }

        double contextId = (double)arc4random_uniform(1000000);
        NSNumber *contextIdNumber = [NSNumber numberWithDouble:contextId];
        [llamaContexts setObject:context forKey:contextIdNumber];
        result(@{
            @"contextId": contextIdNumber,
            @"gpu": @([context isMetalEnabled]),
            @"reasonNoGPU": [context reasonNoMetal],
            @"model": [context modelInfo],
            });
    } @catch (NSException *exception) {
        result([FlutterError errorWithCode:@"505" message:exception.reason details:exception]);
    }
}

- (void)handleGetFormattedChat:(FlutterMethodCall *)call result:(FlutterResult)result {
    @try {
        NSDictionary *arguments = call.arguments;
        double contextId = [arguments[@"contextId"] doubleValue];
        NSArray *messages = arguments[@"messages"];
        NSString *chatTemplate = arguments[@"chatTemplate"];

        id context = llamaContexts[[NSNumber numberWithDouble:contextId]];

        if (context == nil) {
            result([FlutterError errorWithCode:@"505" message:@"Context not found" details:nil]);
            return;
        }

        if (![context isKindOfClass:[FLlamaContext class]]) {
            result([FlutterError errorWithCode:@"505" message:@"Whisper context not support this method" details:nil]);
            return;
        }

        result([context getFormattedChat:messages withTemplate:chatTemplate]);
    } @catch (NSException *exception) {
        result([FlutterError errorWithCode:@"505" message:exception.reason details:exception]);
    }
}

- (void)handleLoadSession:(FlutterMethodCall *)call result:(FlutterResult)result {
    @try {
        NSDictionary *arguments = call.arguments;
        double contextId = [arguments[@"contextId"] doubleValue];
        NSString *filePath = arguments[@"path"];

        id context = llamaContexts[[NSNumber numberWithDouble:contextId]];

        if (context == nil) {
            result([FlutterError errorWithCode:@"505" message:@"Context not found" details:nil]);
            return;
        }

        if (![context isKindOfClass:[FLlamaContext class]]) {
            result([FlutterError errorWithCode:@"505" message:@"Whisper context not support this method" details:nil]);
            return;
        }

        if ([context isPredicting]) {
            result([FlutterError errorWithCode:@"505" message:@"Context is busy" details:nil]);
            return;
        }

        dispatch_async(llamaDQueue, ^{
            @try {
                @autoreleasepool {
                    result([context loadSession:filePath]);
                }
            } @catch (NSException *exception) {
                result([FlutterError errorWithCode:@"500" message:exception.reason details:exception]);
            }
        });
    } @catch (NSException *exception) {
        result([FlutterError errorWithCode:@"505" message:exception.reason details:exception]);
    }
}

- (void)handleSaveSession:(FlutterMethodCall *)call result:(FlutterResult)result {
    @try {
        NSDictionary *arguments = call.arguments;
        double contextId = [arguments[@"contextId"] doubleValue];
        NSString *filePath = arguments[@"path"];
        double size = [arguments[@"size"] doubleValue];

        id context = llamaContexts[[NSNumber numberWithDouble:contextId]];

        if (context == nil) {
            result([FlutterError errorWithCode:@"505" message:@"Context not found" details:nil]);
            return;
        }

        if (![context isKindOfClass:[FLlamaContext class]]) {
            result([FlutterError errorWithCode:@"505" message:@"Whisper context not support this method" details:nil]);
            return;
        }

        if ([context isPredicting]) {
            result([FlutterError errorWithCode:@"505" message:@"Context is busy" details:nil]);
            return;
        }

        dispatch_async(llamaDQueue, ^{
            @try {
                @autoreleasepool {
                    int count = [context saveSession:filePath size:(int)size];
                    result(@(count));
                }
            } @catch (NSException *exception) {
                result([FlutterError errorWithCode:@"500" message:exception.reason details:exception]);
            }
        });
    } @catch (NSException *exception) {
        result([FlutterError errorWithCode:@"505" message:exception.reason details:exception]);
    }
}

- (void)handleCompletion:(FlutterMethodCall *)call result:(FlutterResult)result {
    @try {
        NSDictionary *arguments = call.arguments;
        double contextId = [arguments[@"contextId"] doubleValue];
        NSDictionary *completionParams = arguments[@"params"];

        id context = llamaContexts[[NSNumber numberWithDouble:contextId]];

        if (context == nil) {
            result([FlutterError errorWithCode:@"505" message:@"Context not found" details:nil]);
            return;
        }

        if (![context isKindOfClass:[FLlamaContext class]]) {
            result([FlutterError errorWithCode:@"505" message:@"Whisper context not support this method" details:nil]);
            return;
        }

        if ([context isPredicting]) {
            result([FlutterError errorWithCode:@"505" message:@"Context is busy" details:nil]);
            return;
        }

        dispatch_async(llamaDQueue, ^{
            @try {
                @autoreleasepool {
                    NSDictionary *completionResult = [context completion:completionParams
                                                                 onToken:^(NSMutableDictionary *tokenResult) {
                        if (![completionParams[@"emit_realtime_completion"] boolValue]) {
                            return;
                        }

                        dispatch_async(dispatch_get_main_queue(), ^{
                                           if (_eventSink) {
                                               _eventSink(@{
                                    @"function": @"completion",
                                    @"contextId": @(contextId),
                                    @"result": tokenResult
                                    });
                                           }

                                           [tokenResult release];
                                       });
                    }
                        ];
                    result(completionResult);
                }
            } @catch (NSException *exception) {
                result([FlutterError errorWithCode:@"500" message:exception.reason details:exception]);
                [context stopCompletion];
            }
        });
    } @catch (NSException *exception) {
        result([FlutterError errorWithCode:@"505" message:exception.reason details:exception]);
    }
}

- (void)handleStopCompletion:(FlutterMethodCall *)call result:(FlutterResult)result {
    @try {
        NSDictionary *arguments = call.arguments;
        double contextId = [arguments[@"contextId"] doubleValue];

        id context = llamaContexts[[NSNumber numberWithDouble:contextId]];

        if (context == nil) {
            result([FlutterError errorWithCode:@"505" message:@"Context not found" details:nil]);
            return;
        }

        if (![context isKindOfClass:[FLlamaContext class]]) {
            result([FlutterError errorWithCode:@"505" message:@"Whisper context not support this method" details:nil]);
            return;
        }

        [context stopCompletion];
        result(nil);
    } @catch (NSException *exception) {
        result([FlutterError errorWithCode:@"505" message:exception.reason details:exception]);
    }
}

- (void)handleTokenize:(FlutterMethodCall *)call result:(FlutterResult)result {
    @try {
        NSDictionary *arguments = call.arguments;
        double contextId = [arguments[@"contextId"] doubleValue];
        NSString *text = arguments[@"text"];
        id context = llamaContexts[[NSNumber numberWithDouble:contextId]];

        if (context == nil) {
            result([FlutterError errorWithCode:@"505" message:@"Context not found" details:nil]);
            return;
        }

        if (![context isKindOfClass:[FLlamaContext class]]) {
            result([FlutterError errorWithCode:@"505" message:@"Whisper context not support this method" details:nil]);
            return;
        }

        NSArray *tokens = [context tokenize:text];
        result(@{ @"tokens": tokens });
        [tokens release];
    } @catch (NSException *exception) {
        result([FlutterError errorWithCode:@"505" message:exception.reason details:exception]);
    }
}

- (void)handleDetokenize:(FlutterMethodCall *)call result:(FlutterResult)result {
    @try {
        NSDictionary *arguments = call.arguments;
        double contextId = [arguments[@"contextId"] doubleValue];
        NSArray *tokens = arguments[@"tokens"];
        id context = llamaContexts[[NSNumber numberWithDouble:contextId]];

        if (context == nil) {
            result([FlutterError errorWithCode:@"505" message:@"Context not found" details:nil]);
            return;
        }

        if (![context isKindOfClass:[FLlamaContext class]]) {
            result([FlutterError errorWithCode:@"505" message:@"Whisper context not support this method" details:nil]);
            return;
        }

        result([context detokenize:tokens]);
    } @catch (NSException *exception) {
        result([FlutterError errorWithCode:@"505" message:exception.reason details:exception]);
    }
}

- (void)handleBench:(FlutterMethodCall *)call result:(FlutterResult)result {
    @try {
        NSDictionary *arguments = call.arguments;
        double contextId = [arguments[@"contextId"] doubleValue];
        double pp = [arguments[@"pp"] doubleValue];
        double tg = [arguments[@"tg"] doubleValue];
        double pl = [arguments[@"pl"] doubleValue];
        double nr = [arguments[@"nr"] doubleValue];
        id context = llamaContexts[[NSNumber numberWithDouble:contextId]];

        if (context == nil) {
            result([FlutterError errorWithCode:@"505" message:@"Context not found" details:nil]);
            return;
        }

        if (![context isKindOfClass:[FLlamaContext class]]) {
            result([FlutterError errorWithCode:@"505" message:@"Whisper context not support this method" details:nil]);
            return;
        }

        @try {
            NSString *benchResults = [context bench:pp tg:tg pl:pl nr:nr];
            result(benchResults);
        } @catch (NSException *exception) {
            result([FlutterError errorWithCode:@"505" message:exception.reason details:exception]);
        }
    } @catch (NSException *exception) {
        result([FlutterError errorWithCode:@"505" message:exception.reason details:exception]);
    }
}

- (void)handleReleaseContext:(FlutterMethodCall *)call result:(FlutterResult)result {
    @try {
        NSDictionary *arguments = call.arguments;
        double contextId = [arguments[@"contextId"] doubleValue];
        id context = llamaContexts[[NSNumber numberWithDouble:contextId]];

        if (context == nil) {
            result([FlutterError errorWithCode:@"505" message:@"Context not found" details:nil]);
            return;
        }

        [context stopCompletion];
        dispatch_barrier_sync(llamaDQueue, ^{});

        [context invalidate];
        [llamaContexts removeObjectForKey:[NSNumber numberWithDouble:contextId]];
        result(nil);
    } @catch (NSException *exception) {
        result([FlutterError errorWithCode:@"505" message:exception.reason details:exception]);
    }
}

- (void)handleReleaseAllContexts:(FlutterMethodCall *)call result:(FlutterResult)result {
    @try {
        if (llamaContexts == nil) {
            return;
        }

        for (NSNumber *contextId in llamaContexts) {
            id context = llamaContexts[contextId];

            if (context != nil) {
                if ([context isKindOfClass:[FLlamaContext class]]) {
                    [context stopCompletion];
                    dispatch_barrier_sync(llamaDQueue, ^{});
                    [context invalidate];
                } else {
                    [context invalidate];
                }
            }
        }

        [llamaContexts removeAllObjects];
        [llamaContexts release];
        llamaContexts = nil;

        if (llamaDQueue != nil) {
            dispatch_release(llamaDQueue);
            llamaDQueue = nil;
        }

        result(nil);
    } @catch (NSException *exception) {
        result([FlutterError errorWithCode:@"505" message:exception.reason details:exception]);
    }
}

// === Utils ===

- (uint64_t)totalMemory {
    uint64_t memory = 0;
    size_t size = sizeof(memory);

    sysctlbyname("hw.memsize", &memory, &size, NULL, 0);
    return memory;
}

- (NSInteger)cpuCoreCount {
    int coreCount;
    size_t size = sizeof(coreCount);

    sysctlbyname("hw.ncpu", &coreCount, &size, NULL, 0);
    return coreCount;
}

- (NSString *)deviceModel {
    size_t size;

    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *deviceModelString = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return deviceModelString ? deviceModelString : @"Unknown";
}

- (void)handleGetCpuInfo:(FlutterMethodCall *)call result:(FlutterResult)result {
    @try {
        id<MTLDevice> device = MTLCreateSystemDefaultDevice();
        uint64_t totalMemory = [self totalMemory];
        NSInteger coreCount = [self cpuCoreCount];
        NSString *deviceModel = [self deviceModel];
        result(@{
            @"isMetalSupport": @(device != nil),
            @"cpuFeatures": @"iOS is Not Support !",
            @"gpuName": device.name ? device.name : @"iOS is Not Support !",
            @"totalMemory": @(totalMemory / (1024 * 1024)),
            @"cpuCount": @(coreCount),
            @"deviceModel": deviceModel
            });
    } @catch (NSException *exception) {
        result([FlutterError errorWithCode:@"505" message:exception.reason details:exception]);
    }
}

- (NSString *)calculateFileSHA256:(NSString *)filePath {
    CC_SHA256_CTX sha256;

    CC_SHA256_Init(&sha256);
    NSInputStream *inputStream = [NSInputStream inputStreamWithFileAtPath:filePath];
    [inputStream open];
    uint8_t buffer[8192]; // 8KB buffer
    NSInteger bytesRead;

    while ([inputStream hasBytesAvailable]) {
        bytesRead = [inputStream read:buffer maxLength:sizeof(buffer)];

        if (bytesRead < 0) {
            NSLog(@"Failed to read file: %@", [inputStream streamError].localizedDescription);
            [inputStream close];
            return nil;
        }

        CC_SHA256_Update(&sha256, buffer, (CC_LONG)bytesRead);
    }
    [inputStream close];
    unsigned char hash[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256_Final(hash, &sha256);
    NSMutableString *hashString = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];

    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [hashString appendFormat:@"%02x", hash[i]];
    }

    return hashString;
}

- (void)handleGetFileSHA256:(FlutterMethodCall *)call result:(FlutterResult)result {
    @try {
        NSDictionary *arguments = call.arguments;
        NSString *filePath = [arguments[@"filePath"] stringValue];
        NSString *fileHash = [self calculateFileSHA256:filePath];
        result(fileHash);
    } @catch (NSException *exception) {
        result([FlutterError errorWithCode:@"505" message:exception.reason details:exception]);
    }
}

@end
