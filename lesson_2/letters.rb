alphabet = [*"a".."z"]
vowels   = %w[a e i o u y]

hash = {}

=begin

# вариант с вложенным циклом:

i = 0 # счётчик гласных

# проверяем все заданные гласные:
while i < vowels.size do
  j = 0 # счётчик алфавита
  # проверяем вхождения гласной в алфавит:
  while j < alphabet.size do
    # порядковый номер гласной == индекс совпавшей буквы + 1:
    # букву и номер -- в хеш
    hash[vowels[i]] = j + 1 if vowels[i] == alphabet[j]
    j += 1 # следующая буква
  end
  i += 1 # увеличиваем индекс -- следующая гласная
end

puts hash

=end

# vowels.each {|vowel| alphabet.include?(vowel) && hash[vowel] = alphabet.index(vowel) + 1 }

vowels.each {|vowel| hash[vowel] = alphabet.index(vowel) + 1 if alphabet.include?(vowel) }

puts hash
