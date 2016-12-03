# the price to crack your password

Nearly six years ago, I wrote about password complexity and showed how long it takes to crack passwords per length. You can find that [article on github](https://github.com/nkoehring/hexo-blog/blob/master/source/_posts/spas-mit-passwortern.md) (in German).

So, times changed and I thought about a reiteration of that topic, but instead focussing on the amount of money you need to crack the password using Amazons biggest GPU computing instances [p2.16xlarge](https://aws.amazon.com/ec2/instance-types/), which – at the time of writing this - costs 14.4 USD per hour. I will also compare this with the much faster [Sagitta Brutalis](https://sagitta.pw/hardware/gpu-compute-nodes/brutalis/) (nice name, eh?), a 18500 USD computer optimised for GPU calculation.

## Disclaimer

The numbers on this article always assume brute-force attacks, that means the attacker uses a program that tries all possible combinations until it finds the password. The numbers indicate average time to compute *all* possible entries. If the program simply adds up, for example, from 000000 to 999999 and your password is 000001, it will be found much faster of course.

How long a single calculation needs also depends on the used hashing algorithm. I will compare some of the typically used algorithms. In case you have to implement a password security system, please use BCrypt which is in most cases the best choice but *NEVER* try to implement something on your own! It is never ever a good idea to create an own password hashing scheme, even if it is just assembled out of existing building blocks. Use the battle-tested standard solutions. They are peer-reviewed and the safest and most robust you can get.

## Password complexity basics

Password complexity is calculated out of the possible number of combinations. So a 10-character password that only contains numbers is far less complex than a mix of letters and numbers of the same length. Usually an attacker has no idea if a specific password only contains numbers or letters, but a brute-force attack will try simpler combinations first.

To calculate the complexity of a password, find the amount of possible combinations first:

* Numbers: 10
* ASCII Lowercase letters: 26
* ASCII Uppercase letters: 26
* ASCII Punctuation: 33
* Other ASCII Characters: 128
* Unicode: millions

To get the complexity of your password, simply add up the numbers. A typical password contains numbers, lowercase and uppercase letters which results in 62 possible combinations per character. Add some punctuation to raise that number to 95.

Other ASCII Characters are the less typical ones like ÿ and Ø which add to the complexity but might be hard to type on foreign keyboards. Unicode is super hard (if not impossible) to type on some computers but would theoretically add millions of possible characters. Fancy some ਪੰਜਾਬੀ ਦੇ in your password?

A very important factor in the password complexity is of course also the length. And because random passwords with crazy combinations of numbers, letters and punctuation are hard to remember, [some people suggest to use long combination of normal words instead](https://xkcd.com/936/).

The password `ke1r$u@U` is considered a very secure password as the time of writing this article. Its complexity calculates like this:

8 characters with 95 possibilites: `95^8 = 6634204312890625 = ~6.6×10^15`

`log2(x)` calculates the complexity in bits. `log2(6634204312890625) = ~52.56 bits`

## Data sources

I didn't try the password cracking myself, and neither did I ask a friend (insert trollface here). Instead I used publicly available benchmark results:

* [hashcat benchmark for p2.16xlarge](https://medium.com/@iraklis/running-hashcat-in-amazons-aws-new-16-gpu-p2-16xlarge-instance-9963f607164c#.bzyi0ystz)
* [hashcat benchmark for sagitta brutalis](https://gist.github.com/epixoip/a83d38f412b4737e99bbef804a270c40)

## The results

Now to the numbers. I created the numeric password examples by raving over the keyboard. Most other examples are generated with [pwgen](http://pwgen.sourceforge.net).

For comparison I will show all examples for the typically used hashing function SHA256 and the way more secure BCrypt with default settings on the BSD operating system. Look into the benchmark tables for comparison with other hashing solutions (hashcat support 160 of them).

### Numeric passwords

Only 10<sup>n</sup> combinations, super weak!

*SHA256*

Example      | t p2.16xlarge | t brutalis | minimal cost | comment
-------------|---------------|------------|--------------|-------------------
12091972     | x             | x          | x            | Someones birthday?
8847324478   | x             | x          | x            | 10 digits
894839243243 | x             | x          | x            | 12 digits

*BCrypt*

Example      | t p2.16xlarge | t brutalis | minimal cost | comment
-------------|---------------|------------|--------------|-------------------
12091972     | x             | x          | x            | Someones birthday?
8847324478   | x             | x          | x            | 10 digits
894839243243 | x             | x          | x            | 12 digits

### Letters and Numbers

Up to 62 combinations. Potentially strong but hard to memorise:

*SHA256*

Example      | t p2.16xlarge | t brutalis | minimal cost | comment
-------------|---------------|------------|--------------|-------------------
Yae4och8     | x             | x          | x            | 8 characters
yae4och8     | x             | x          | x            | no mixed case for comparison
uoGEi7ipho   | x             | x          | x            | 10 characters
eEY9feeg8G5y | x             | x          | x            | 12 characters

*BCrypt*

Example      | t p2.16xlarge | t brutalis | minimal cost | comment
-------------|---------------|------------|--------------|-------------------
Yae4och8     | x             | x          | x            | 8 characters
yae4och8     | x             | x          | x            | no mixed case for comparison
uoGEi7ipho   | x             | x          | x            | 10 characters
eEY9feeg8G5y | x             | x          | x            | 12 characters

### Special characters

Up to 95 combinations. Stronger and even harder to memorise:

*SHA256*

Example      | t p2.16xlarge | t brutalis | minimal cost | comment
-------------|---------------|------------|--------------|-------------------
ke1r$u@U     | x             | x          | x            | 8 characters
Zoo(qu4ieN   | x             | x          | x            | 10 characters
Que/z;ee1UPh | x             | x          | x            | 12 characters

*BCrypt*

Example      | t p2.16xlarge | t brutalis | minimal cost | comment
-------------|---------------|------------|--------------|-------------------
ke1r$u@U     | x             | x          | x            | 8 characters
Zoo(qu4ieN   | x             | x          | x            | 10 characters
Que/z;ee1UPh | x             | x          | x            | 12 characters

### Extended ASCII character set

Up to 224 combinations. If you can remember numerous long passwords of this type, you might consider participating in memory challenges.

*SHA256*

Example      | t p2.16xlarge | t brutalis | minimal cost | comment
-------------|---------------|------------|--------------|-------------------
eeh#e6Eá     | x             | x          | x            | 8 characters
Kahy?eÿ,3G   | x             | x          | x            | 10 characters
Eijahj8Siøôp | x             | x          | x            | 12 characters

*BCrypt*

Example      | t p2.16xlarge | t brutalis | minimal cost | comment
-------------|---------------|------------|--------------|-------------------
eeh#e6Eá     | x             | x          | x            | 8 characters
Kahy?eÿ,3G   | x             | x          | x            | 10 characters
Eijahj8Siøôp | x             | x          | x            | 12 characters

### Long but memorisable passwords

Up to 32 combinations, no capital letters, no numbers, only words and spaces. The first one is a cartoon character, the others are generated using https://www.randomlists.com/random-words .

*SHA256*

Example                               | t p2.16xlarge | t brutalis | minimal cost
--------------------------------------|---------------|------------|-------------
horace horsecollar                    | x             | x          | x
scent injure rail breakable           | x             | x          | x
political nonstop kittens notice seal | x             | x          | x

*BCrypt*

Example                               | t p2.16xlarge | t brutalis | minimal cost
--------------------------------------|---------------|------------|-------------
horace horsecollar                    | x             | x          | x
scent injure rail breakable           | x             | x          | x
political nonstop kittens notice seal | x             | x          | x


## Some highlights from other algorithms:

The used password complexity is 52.56 bits (eg `ke1r$u@U`):

         hash |  Amazon | Brutalis | price to crack in less than a month
--------------|---------|----------|----------------------------------
          MD5 |      2d |    9.2h  | ~$700 (1 EC2 instance)
        Skype |      2d |   17.7h  | ~$700 (1 EC2 instance)
   AndroidPIN |     10y |      5y  | ~$1.13M (61 Brutalis)
    MyWallet³ |    265d |    191d  | ~$110000 (6 Brutalis)
BitcoinWallet |  14996y |   5835y  | 
         WPA2 |    160y |     67y  | 
     LastPass |     24y |     12y  | 
   TrueCrypt² |   1144y |    718y  | 
   VeraCrypt¹ | 588867y | 353320y  | 
       SHA256 |      7d |      4d  | 
       BCrypt |   6194y |   1989y  | 

  1. VeraCrypt PBKDF2-HMAC-Whirlpool + XTS 512bit (super duper paranoid settings)
  2. TrueCrypt PBKDF2-HMAC-Whirlpool + XTS 512bit
  3. Blockchain MyWallet: https://blockchain.info/wallet/

http://hashcat.net/hashcat/
https://www.praetorian.com/blog/statistics-will-crack-your-password-mask-structure
https://password-hashing.net/
