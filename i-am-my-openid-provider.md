title: I am my OpenID provider
tags:
  - authentication
  - web
  - security
  - openid
  - tutorials
categories:
  - Tutorials
date: 2014-02-20 19:16:54
---

Starting today I am my own OpenID provider. Why that is a cool thing and how I managed to do it will be explained in this article.

### OpenID?

OpenID is a standard that allows authentication via third-party services. So the authentication is not done on the side of the used service, just like OAuth.

The big difference: Rather than services beeing tied to one OAuth authenticator (like &#8220;Login with your Google/Amazon/Twitter account&#8221;), OAuth is independet.

Instead having a couple of login buttons you just need one. An OpenID is an <span class="caps">URL</span> and can resolved the same way. That is because OpenID doesn&#8217;t offer any profile of some specific service but an independent one. If a service especially asks for your Facebook account, it probably wants way more than just offer you a simple way of authentication.

### You probably already have one.

Just like <span class="caps">XMPP</span> (a.k.a. Jabber), which sneakes in everywhere, you probably also have an OAuth provider already. Google, Yahoo, LiveJournal, Blogger, Flickr, MySpace, WordPress, <span class="caps">AOL</span>, .. they all offer you OpenID authentication. See &#8220;Get an OpenID&#8221;:http://openid.net/get-an-openid/ for details on that topic.

### Cool, so why rolling out your own provider?

Simple! I don&#8217;t want Google or any other company to be my authenticator. They already know way to much and I want to be in control of my data! Also it is nice to have anything unified with one single <span class="caps">URL</span>. With everything I mean Website, Email, Jabber and now finally also Authentication.

There are two ways. The most simple way – delegation – is again dependent on an external provider.

``` HTML
  <link rel="openid.server" href="http://openidprovider.tld/server" />
  <link rel="openid.delegate" href="http://homepage.tld" />
  <link rel="openid2.provider" href="http://openidprovider.tld/server" />
  <link rel="openid2.local_id" href="http://homepage.tld" />
  <meta http-equiv="X-XRDS-Location" content="http://openidprovider.tld/xrds?username=homepage.tld" />
```

Put this into your homepages markup at http://homepage.tld and it will delegate your domain as an id to your provider at http://openidprover.tld/server.

Simple!

But I still want to be my own provider, because I&#8217;m a total privacy zealot!

### Become your own OpenID provider.

Thanks to some nice people, it is super easy to become your own provider. Of course you need some webspace and knowledge about its handling.

Rather than <span class="caps">RTFM</span> or using some fancy library to program the whole thing myself I just decided to pick some ready made OpenID provider. The first results contained [SimpleID](http://simpleid.sourceforge.net/). What made it my choice was, that there is a Ubuntu package for it, so installing it on my webserver was a piece of cake.

As I am used to, the SimpleID package comes nicely preconfigured and just works with my Apache2 setup. Without configuration, the service will be located at http://homepage.tld/simpleid. If you want to change that, just look into the well documented configuration file in /etc/simpleid/. A symlink to the Apache configuration file is located here, too.

All you need now is an identity file. A well documented example is included:

``` sh
%> sudo -s
#> cp /usr/share/simpleid/sample/example.identity.dist /var/lib/simpleid/identities/homepage.tld.identity
#> $EDITOR /var/lib/simpleid/identities/homepage.tld.identity

```

It needs two lines. Your identity (your domain name for example) and your <span class="caps">MD5</span> hashed password:

```
identity="http://homepage.tld/"
pass="47635cbe1a0ee7f472ff202955bf9b34"
```

If you – just like in my examples – don&#8217;t want to put that /simpleid everywhere, you also need to delegate just like I described above. Here is, what I have on my domain:

``` HTML
<meta http-equiv="X-XRDS-Location" content="https://koehr.in/openid/xrds/koehr" />
<link rel="openid.server" href="https://koehr.in/openid/" />
<link rel="openid2.provider" href="https://koehr.in/openid/" />
```

As you can see, you don&#8217;t need to set your ID again.

Thats it! You can login at http://homepage.tld/simpleid to check your settings and manage your connections.
