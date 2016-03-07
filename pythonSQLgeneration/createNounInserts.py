nouns = open('wordFiles/nouns/91K nouns.txt', 'r')
nounSql = open('nounSQL.sql', 'w')
nounSql.write('SET NOCOUNT ON;\n')

verbs = open('wordFiles/verbs/31K verbs.txt', 'r')
verbSql = open('verbSQL.sql', 'w')
verbSql.write('SET NOCOUNT ON;\n')

adjectives = open('wordFiles/adjectives/28K adjectives.txt', 'r')
adjectiveSql = open('adjectiveSQL.sql', 'w')
adjectiveSql.write('SET NOCOUNT ON;\n')

adverbs = open('wordFiles/adverbs/6K adverbs.txt', 'r')
adverbSql = open('adverbSQL.sql', 'w')
adverbSql.write('SET NOCOUNT ON;\n')

fNames = open('nameFiles/firstNames.txt', 'r')
fNameSql = open('fNameSQL.sql', 'w')
fNameSql.write('SET NOCOUNT ON;\n')

lNames = open('nameFiles/lastNames.txt', 'r')
lNameSql = open('lNameSQL.sql', 'w')
lNameSql.write('SET NOCOUNT ON;\n')

for noun in nouns:
    nounSql.write('INSERT INTO NOUN (noun) VALUES (\'%s\');\n' % noun.rstrip().replace("'", ""))

for verb in verbs:
    verbSql.write('INSERT INTO VERB (verb) VALUES (\'%s\');\n' % verb.rstrip().replace("'", ""))

for adjective in adjectives:
    adjectiveSql.write('INSERT INTO ADJECTIVE (adjective) VALUES (\'%s\');\n' % adjective.rstrip().replace("'", ""))

for adverb in adverbs:
    adverbSql.write('INSERT INTO ADVERB (adverb) VALUES (\'%s\');\n' % adverb.rstrip().replace("'", ""))

for fName in fNames:
    fNameSql.write('INSERT INTO FIRST_NAME (fName) VALUES (\'%s\');\n' % fName.rstrip().replace("'", ""))

for lName in lNames:
    lNameSql.write('INSERT INTO LAST_NAME (lName) VALUES (\'%s\');\n' % lName.rstrip().replace("'", ""))
