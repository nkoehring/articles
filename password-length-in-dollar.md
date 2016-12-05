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

I will compare some widely used password hashing methods, programs and
protocols for four different password complexity categories:

 * eight numeric digits (might be your birthday)
 * eight alphanumeric characters (eg 'pa55W0Rd')
 * eigth alphanumeric characters mixed with special character (eg 'pa$$W0Rd')
 * a long memorisable pass sentence ('correct horse battery staple')

### eight numeric digits (might be your birthday)

         hash |  Amazon | Brutalis | price to crack in less than a month
--------------|---------|----------|------------------------------------
          MD5 |    0.0s |     0.0s | $0.01 (1 EC2 instance)
        Skype |    0.0s |     0.0s | $0.01 (1 EC2 instance)
         WPA2 |   1.27m |   31.47s | $0.30 (1 EC2 instance)
       SHA256 |   0.01s |     0.0s | $0.01 (1 EC2 instance)
       BCrypt |   49.1m |   15.77m | $11.78 (1 EC2 instance)
   AndroidPIN |   4.65s |     2.3s | $0.02 (1 EC2 instance)
     MyWallet |   0.34s |    0.25s | $0.01 (1 EC2 instance)
BitcoinWallet |   1.98h |   46.26m | $28.53 (1 EC2 instance)
     LastPass |  11.07s |     5.4s | $0.04 (1 EC2 instance)
    TrueCrypt |   9.06m |    5.69m | $2.18 (1 EC2 instance)
    VeraCrypt |      4d |       2d | $1120.45 (1 EC2 instance)

Conclusion: Don't do this. Never ever do this.

### eight alphanumeric characters (eg 'pa55W0Rd')

         hash |  Amazon | Brutalis | price to crack in less than a month
--------------|---------|----------|------------------------------------
          MD5 |  49.65m |   18.17m | $11.92 (1 EC2 instance)
        Skype |    1.3h |   34.92m | $18.67 (1 EC2 instance)
         WPA2 |      6y |       3y | $499500 (27 Brutalis)
       SHA256 |   4.94h |    2.64h | $71.15 (1 EC2 instance)
       BCrypt |    204y |      66y | $14.7M (797 Brutalis)
   AndroidPIN |    118d |      59d | $37000 (2 Brutalis)
     MyWallet |      9d |       7d | $3003.3 (1 EC2 instance)
BitcoinWallet |    494y |     193y | $43.25M (2338 Brutalis)
     LastPass |    280d |     137d | $92,500 (5 Brutalis)
    TrueCrypt |     38y |      24y | $5.3M (288 Brutalis)
    VeraCrypt |  19381y |   11629y | $2.62B (141574 Brutalis)

### eigth alphanumeric characters mixed with special character (eg 'pa$$W0Rd')

         hash |  Amazon | Brutalis | price to crack in less than a month
--------------|---------|----------|------------------------------------
          MD5 |      2d |    9.2h  | ~$362 (1 EC2 instance)
        Skype |      2d |   17.7h  | ~$567 (1 EC2 instance)
         WPA2 |    160y |     67y  | ~$14.9M (806 Brutalis)
       SHA256 |      7d |      4d  | ~$2162 (1 EC2 instance)
       BCrypt |   6194y |   1989y  | ~$448M (24,215 Brutalis)
   AndroidPIN |     10y |      5y  | ~$1.09M (59 Brutalis)
    MyWallet³ |    265d |    191d  | ~$129500 (7 Brutalis)
BitcoinWallet |  14996y |   5835y  | ~$1.3B (71,038 Brutalis)
     LastPass |     24y |     12y  | ~$2.6M (139 Brutalis)
   TrueCrypt² |   1144y |    718y  | ~$162M (8,742 Brutalis)
   VeraCrypt¹ | 588867y | 353320y  | ~$79.6B (4,301,668 Brutalis)

  1. VeraCrypt PBKDF2-HMAC-Whirlpool + XTS 512bit (super duper paranoid settings)
  2. TrueCrypt PBKDF2-HMAC-Whirlpool + XTS 512bit
  3. Blockchain MyWallet: https://blockchain.info/wallet/

### a long memorisable pass sentence ('correct horse battery staple')

Okay, this doesn't need a table. It takes millions of billions of years to even
crack this in MD5.

As illustration: The solar system needs around 225 Million years to rotate
around the core of the Milkyway. This is the so called [galactic year](https://en.wikipedia.org/wiki/Galactic_year).
The sun exists since around 20 galactic years. To crack such a password, even
when hashed in MD5 takes 3 trillion (million million) galactic years.

Of course nobody would ever attempt to do this. There are many possibilities to
crack a password faster. Explaining some of them would easily fill another
article, so I leave you here. Sorry.

## Links

To find your way into the topic, you might visit some of the following links:

* [The fastest bruteforce password cracker](http://hashcat.net/hashcat/)
* [More about password cracking methods](https://www.praetorian.com/blog/statistics-will-crack-your-password-mask-structure)
* [Password hashing competition](https://password-hashing.net/)
* [Random word generator for long but memorisable passwords](https://www.randomlists.com/random-words)

