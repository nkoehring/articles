title: fantastic cryptographic possibilities
date: 2015-01-29 02:06:11
tags:
  - cryptography
  - mail
  - security
  - surveillance
categories:
  - Security
---

Today, I found two very exciting and (kind of) new possibilities for the security and cryptography.

Subconscious keys
-----------------

[Bruce Schneier](https://en.wikipedia.org/wiki/Bruce_Schneier) posted today about [subconscious keys](https://www.schneier.com/blog/archives/2015/01/subconscious_ke.html). The idea is that you train a sequence via so called _implicit learning_. The actual key is hidden in something like a game and neither the attacker nor you are able to reveal it, although authentication is still possible. Some super brains from the Stanford University, North Western University and SRI have written [a paper](https://www.usenix.org/conference/usenixsecurity12/technical-sessions/presentation/bojinov) about the possibilities and their user studies.

Their authentication system works well but needs five to ten minutes for authentication, besides thirty to fourty minutes of training every couple of weeks. So it is probably not super applicable yet but it still reveals some exciting possibilites.


Identity-based encryption
-------------------------

Another project from the [Applied Crypto Group](http://crypto.stanford.edu/) at Stanford University is called [IBE Secure E-Mail](http://crypto.stanford.edu/ibe/).

The idea is to create an email security solution which uses identity based encryption. The benefits of this encryption scheme are huge. It is based on the possibility to use any string as public key – for example the e-mail address itself.

How easy it would be?! PGP never reached many people outside of the hacker or security scene even after it became quite easy to use with software like [Enigmail](https://addons.mozilla.org/de/thunderbird/addon/enigmail/). It is simply to much additional effort to organize key pairs, especially if you as a Joe Public have no clue what they actually are.

I didn't finish the paper yet, but I will finish it tomorrow. I hope they already got something nice to start with.
