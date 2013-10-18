//
//  CSFileReader.m
//  SeqReader
//
//  Created by Christos Sotiriou on 18/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "CSFileReader.h"

@interface CSFileReader ()

@end

@implementation CSFileReader

- (void)startReadingLineByLineFileAtPath:(NSString *)filePath encoding:(NSStringEncoding)encoding
{
	FILE *fp;
	char *line = NULL;
	size_t len = 0;
	ssize_t read;
	
	fp = fopen([filePath cStringUsingEncoding:NSUTF8StringEncoding], "r");
	if (fp) {
		while ( (read =  getline(&line, &len, fp)) != -1) {
			NSString *currentLine = [[NSString alloc] initWithBytes:line length:read encoding:encoding];
			if (currentLine) {
				if ([self.delegate respondsToSelector:@selector(fileReader:didEncounterLine:)]) {
					[self.delegate fileReader:self didEncounterLine:currentLine];
				}
			}
		}
	}else{
		@throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"File could not be opened for reading" userInfo:nil];
	}
	
	if ([self.delegate respondsToSelector:@selector(fileReaderDidEndProcessingFile:)]) {
		[self.delegate fileReaderDidEndProcessingFile:self];
	}
	
	fclose(fp);
	if (line != NULL) {
		free(line);
	}
}

- (void)dealloc
{
    
}
@end
