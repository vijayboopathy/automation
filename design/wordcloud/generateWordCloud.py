#!/usr/bin/env python
"""
Minimal Example
===============
Generating a square wordcloud from the US constitution using default arguments.
"""

from os import path
from wordcloud import WordCloud
import sys
import random

def grey_color_func(word, font_size, position, orientation, random_state=None, **kwargs):
    return "hsl(0, 0%%, %d%%)" % 0 #random.randint(60, 100)

def black_color_func(word=None, font_size=None, position=None, orientation=None, font_path=None, random_state=None):
    return "hsl(0%,0%,0%)"

if __name__ == '__main__':

    if len(sys.argv) != 3:
        print "USAGE: pythong generateWordCloud.py <wordFreqFile> <outImageFile>"
        sys.exit(-1)

    # Read the whole text.
    words = []
    for line in open(sys.argv[1]):
        line = line.strip()
        parts = line.split('\t')
        words.append((parts[0], int(parts[1])))
        

    # Generate a word cloud image
    wordcloud = WordCloud(color_func=grey_color_func,background_color='white').generate_from_frequencies(words)

    
    image = wordcloud.to_image()
    image.show()
    image.save(sys.argv[2])
