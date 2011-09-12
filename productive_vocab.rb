#!/usr/bin/ruby

if ARGV.length < 1
    puts 'Usage: productive_vocab.rb text-file'
    exit
end

textFilePath = ARGV[0]

wordsSeen = {}

# open the text file
textFile = File.open(textFilePath, 'rb')
rawContents = textFile.read

=begin
for i in 0..rawContents.length - 1
    char = rawContents[i]
    rawContents[i]
end
=end

startIndex = 0
endIndex = 0
contents = ''
quoteSymbol = '"'
while true
    endIndex = rawContents.index(quoteSymbol, startIndex)
    endIndex = rawContents.length if endIndex == nil
    contents += rawContents[startIndex..(endIndex - 1)] + ' '
    startIndex = rawContents.index(quoteSymbol, endIndex + 1)
    break if startIndex == nil
    puts rawContents[endIndex..startIndex]
end

contents.downcase!


#print 'Loading text...'
#print 'done' + "\n"

#print 'Splitting words...'
# ? : ' " \ /
words = contents.split(/[^A-Za-z']+/)
#words = contents.split(/[^?.!;-]+/)
#print 'done' + "\n"

words.each do |word|
    next if word.length == 1 and word != 'a'
    wordsSeen[word] = 0 if !wordsSeen[word]
    wordsSeen[word] += 1
end

wordsSeen = wordsSeen.sort { |a, b| b[1] <=> a[1] }

print 'Total different words used: ' + wordsSeen.length.to_s + "\n"

print 'Word counts:' + "\n"
wordsSeen.each do |word, count|
    print word + ': ' + count.to_s + "\n"
end


