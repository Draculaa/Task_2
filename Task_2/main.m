//
//  main.m
//  Task_2
//
//  Created by Евгений on 26.11.15.
//  Copyright © 2015 Eugene Kirtaev. All rights reserved.
//

#import <Foundation/Foundation.h>

const int ASCII_COUNT = 256;

/*!
 * @discussion Метод, считающий количество "0" бит в символе
 * @param ch Символ
 * @return количество "0" бит в символе
 */
int char_as_binary(char ch);
/*!
 * @discussion Метод, считающий количество "0" бит в строке простым перебором
 * @param str строка
 * @param size длина строки
 * @return количество "0" бит
 */
int simpleFunction(char * str, int size);
/*!
 * @discussion Метод, подсчитывающий список количества "0" бит в каждом символе ascii
 * @param str
 * @param size
 */
void calculateASCII(unsigned int * ascii);
/*!
 * @discussion Метод, считающий количество "0" бит в строке быстрым способом
 * @param str строка
 * @param size длина строки
 * @param ascii массив с количеством "0" бит в каждом символе ascii
 * @return количество "0" бит
 */
int fastFunction(char * str, int size, unsigned int * ascii);

int char_as_binary(char ch)
{
    int count = 0;
    int i = 8;
    while (i > 0)
    {
        --i;
        if (!(ch&(1 << i)))
        {
            count++;
        }
    }
    return count;
}

int simpleFunction(char * str, int size){
    
    int count = 0;
    for (int i = 0; i < size; i++)
    {
        count += char_as_binary(str[i]);
    }
    return count;
}

void calculateASCII(unsigned int * ascii){
    
    for (int i = 0; i < ASCII_COUNT; i++) {
        ascii[i] = char_as_binary(i);
    }
}

int fastFunction(char * str, int size ,unsigned int * ascii){ // if size > 256 is faster
    
    int count = 0;
    for (int i = 0; i < size; i++) {
        count+= ascii[str[i]];
    }
    return count;
}

int main(int argc, const char * argv[]){
    @autoreleasepool {
        
        unsigned int ascii[ASCII_COUNT] = {0};
        char chars[1000000];
        int method;
        int result;
        
        calculateASCII(ascii);
        printf("Enter string to calculate: ");
        scanf("%[^\n]s", chars);
        
        printf("\nChoose method simple/fast (0/1): ");
        scanf("%i", &method);
        
        uint len = strlen(chars);
        double beginTime = CFAbsoluteTimeGetCurrent();
        switch (method) {
            case 0:
                result = simpleFunction(chars, len);
                break;
            case 1:
                result = fastFunction(chars, len, &ascii);
                break;
            default:
                break;
        }
        double endTime = CFAbsoluteTimeGetCurrent() - beginTime;
        printf("\nNumber of \"0\" in str: %i \n", result);
        printf("\nTIME: %f \n", endTime);
    }
    return 0;
}









