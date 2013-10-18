//
//  CSFileReader.h
//  SeqReader
//
//  Created by Christos Sotiriou on 18/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSFileReader;

@protocol CSFileReaderDelegate <NSObject>
@optional
- (void)fileReader:(CSFileReader *)reader didEncounterLine:(NSString *)line;
- (void)fileReaderDidEndProcessingFile:(CSFileReader *)reader;
@end


@interface CSFileReader : NSObject
@property (nonatomic, weak) id<CSFileReaderDelegate> delegate;


/**
 Start reading the file line bby line. Each time a new line is found, the delegate is
 notified
 @param filePath the path of the file to read
 @param encoding the encoding of the file to open for read
 */
- (void)startReadingLineByLineFileAtPath:(NSString *)filePath encoding:(NSStringEncoding)encoding;

@end
