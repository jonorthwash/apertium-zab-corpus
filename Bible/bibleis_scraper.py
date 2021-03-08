#!/usr/bin/env python3
from urllib.request import urlopen
from html.parser import HTMLParser
from sys import argv
class MyHTMLParser(HTMLParser):
    book_data = ''
    verse = 0
    def handle_starttag(self, tag, attrs):
        if tag == 'span' and len(attrs) == 1 and attrs[0][0] == 'data-verseid':
            self.verse = attrs[0][1]
        else:
            self.verse = 0
    def handle_data(self, data):
        if self.verse == 0:
            return
        self.book_data += str(self.verse) + '\t' + data.encode().decode('unicode-escape').encode('latin1').decode('utf-8') + '\n'
parser = MyHTMLParser()
LANG = argv[1]
chapters = ['Matt/1', 'Matt/2', 'Matt/3', 'Matt/4', 'Matt/5', 'Matt/6', 'Matt/7', 'Matt/8', 'Matt/9', 'Matt/10', 'Matt/11', 'Matt/12', 'Matt/13', 'Matt/14', 'Matt/15', 'Matt/16', 'Matt/17', 'Matt/18', 'Matt/19', 'Matt/20', 'Matt/21', 'Matt/22', 'Matt/23', 'Matt/24', 'Matt/25', 'Matt/26', 'Matt/27', 'Matt/28', 'Mark/1', 'Mark/2', 'Mark/3', 'Mark/4', 'Mark/5', 'Mark/6', 'Mark/7', 'Mark/8', 'Mark/9', 'Mark/10', 'Mark/11', 'Mark/12', 'Mark/13', 'Mark/14', 'Mark/15', 'Mark/16', 'Luke/1', 'Luke/2', 'Luke/3', 'Luke/4', 'Luke/5', 'Luke/6', 'Luke/7', 'Luke/8', 'Luke/9', 'Luke/10', 'Luke/11', 'Luke/12', 'Luke/13', 'Luke/14', 'Luke/15', 'Luke/16', 'Luke/17', 'Luke/18', 'Luke/19', 'Luke/20', 'Luke/21', 'Luke/22', 'Luke/23', 'Luke/24', 'John/1', 'John/2', 'John/3', 'John/4', 'John/5', 'John/6', 'John/7', 'John/8', 'John/9', 'John/10', 'John/11', 'John/12', 'John/13', 'John/14', 'John/15', 'John/16', 'John/17', 'John/18', 'John/19', 'John/20', 'John/21', 'Acts/1', 'Acts/2', 'Acts/3', 'Acts/4', 'Acts/5', 'Acts/6', 'Acts/7', 'Acts/8', 'Acts/9', 'Acts/10', 'Acts/11', 'Acts/12', 'Acts/13', 'Acts/14', 'Acts/15', 'Acts/16', 'Acts/17', 'Acts/18', 'Acts/19', 'Acts/20', 'Acts/21', 'Acts/22', 'Acts/23', 'Acts/24', 'Acts/25', 'Acts/26', 'Acts/27', 'Acts/28', 'Rom/1', 'Rom/2', 'Rom/3', 'Rom/4', 'Rom/5', 'Rom/6', 'Rom/7', 'Rom/8', 'Rom/9', 'Rom/10', 'Rom/11', 'Rom/12', 'Rom/13', 'Rom/14', 'Rom/15', 'Rom/16', '1Cor/1', '1Cor/2', '1Cor/3', '1Cor/4', '1Cor/5', '1Cor/6', '1Cor/7', '1Cor/8', '1Cor/9', '1Cor/10', '1Cor/11', '1Cor/12', '1Cor/13', '1Cor/14', '1Cor/15', '1Cor/16', '2Cor/1', '2Cor/2', '2Cor/3', '2Cor/4', '2Cor/5', '2Cor/6', '2Cor/7', '2Cor/8', '2Cor/9', '2Cor/10', '2Cor/11', '2Cor/12', '2Cor/13', 'Gal/1', 'Gal/2', 'Gal/3', 'Gal/4', 'Gal/5', 'Gal/6', 'Eph/1', 'Eph/2', 'Eph/3', 'Eph/4', 'Eph/5', 'Eph/6', 'Phil/1', 'Phil/2', 'Phil/3', 'Phil/4', 'Col/1', 'Col/2', 'Col/3', 'Col/4', '1Thess/1', '1Thess/2', '1Thess/3', '1Thess/4', '1Thess/5', '2Thess/1', '2Thess/2', '2Thess/3', '1Tim/1', '1Tim/2', '1Tim/3', '1Tim/4', '1Tim/5', '1Tim/6', '2Tim/1', '2Tim/2', '2Tim/3', '2Tim/4', 'Titus/1', 'Titus/2', 'Titus/3', 'Phlm/1', 'Heb/1', 'Heb/2', 'Heb/3', 'Heb/4', 'Heb/5', 'Heb/6', 'Heb/7', 'Heb/8', 'Heb/9', 'Heb/10', 'Heb/11', 'Heb/12', 'Heb/13', 'Jas/1', 'Jas/2', 'Jas/3', 'Jas/4', 'Jas/5', '1Pet/1', '1Pet/2', '1Pet/3', '1Pet/4', '1Pet/5', '2Pet/1', '2Pet/2', '2Pet/3', '1John/1', '1John/2', '1John/3', '1John/4', '1John/5', '2John/1', '3John/1', 'Jude/1', 'Rev/1', 'Rev/2', 'Rev/3', 'Rev/4', 'Rev/5', 'Rev/6', 'Rev/7', 'Rev/8', 'Rev/9', 'Rev/10', 'Rev/11', 'Rev/12', 'Rev/13', 'Rev/14', 'Rev/15', 'Rev/16', 'Rev/17', 'Rev/18', 'Rev/19', 'Rev/20', 'Rev/21', 'Rev/22']
with open(argv[2], 'w') as f:
    for url in chapters:
        html = urlopen('http://listen.bible.is/' + LANG + '/' + url)
        parser.feed(str(html.read()))
        f.write(url + '\n')
        f.write(parser.book_data + '\n\n')
        parser.book_data = ''
