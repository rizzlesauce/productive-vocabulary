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
convertedContents = ''
convertedContents = rawContents

#print 'number of chars: ' + rawContents.length.to_s + "\n"
# Convert special characters

=begin
for i in 0..rawContents.length - 1
    char = rawContents[i]
    converted = ''

    if char == 147 or char == 148
        converted = '"'
    elsif char == 146 
        converted = "'"
    elsif char == 151
        converted = '--'
    elsif char == 133 
        # not sure what this one is
        converted = '...'
    else
        converted = char.chr
    end
    convertedContents += converted
    #print converted
end
=end

convertedContents.gsub!(/\x93/, '"')
convertedContents.gsub!(/\x94/, '"')
convertedContents.gsub!(/\x91/, "'")
convertedContents.gsub!(/\x92/, "'")
convertedContents.gsub!(/\x96/, '---')
convertedContents.gsub!(/\x97/, '--')
convertedContents.gsub!(/\x85/, '...')

# remove quotations
convertedContents.gsub!(/"[^"]*"/, '')

=begin
puts convertedContents
exit
=end

contents = convertedContents

=begin
# deal with quotations
numQuotations = 0
startIndex = -1
endIndex = 0
contents = ''
quoteSymbol = '"'
while true
    endIndex = rawContents.index(quoteSymbol, startIndex + 1)
    if endIndex == nil
        endIndex = rawContents.length
    end
    contents += rawContents[(startIndex + 1)..(endIndex - 1)] + ' '
    startIndex = rawContents.index(quoteSymbol, endIndex + 1)
    if startIndex == nil
        break
    end
    #puts rawContents[endIndex..startIndex]
end
=end

contents.downcase!
#puts contents

#print 'Loading text...'
#print 'done' + "\n"

#print 'Splitting words...'
# ? : ' " \ /
words = contents.split(/[^A-Za-z']+/)
#print 'done' + "\n"

wordCount = 0
words.each do |word|
    next if word.length == 1 and word != 'a' and word != 'i'
    wordsSeen[word] = 0 if !wordsSeen[word]
    wordsSeen[word] += 1
    wordCount += 1
end

# Get punctuation
#words = contents.split(/[^?.!;-]+/)

wordsSeen = wordsSeen.sort { |a, b| b[1] <=> a[1] }

print 'Total words (not including quotations): ' + wordCount.to_s + "\n"
print 'Productive vocabulary size: ' + wordsSeen.length.to_s + "\n"

print 'Individual word count:' + "\n"
wordsSeen.each do |word, count|
    print word + ': ' + count.to_s + "\n"
end
