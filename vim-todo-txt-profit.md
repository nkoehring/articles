title: "Vim + todo.txt + ? = Profit!"
date: 2015-10-26 23:40:00
tags:
  - fun
  - pain
  - todolists
  - tech
  - programming
  - vim
categories:
  - Life
---

One major misunderstanding I had and probably still have is, that todo lists should help me getting things done. In a perfect world this could be the case but reality is different. Todo lists don't help you in any way with your tasks, they just help you to not forget them. So probably they create even more work for people like me, who tend to forget a lot. And they do it even at a cost. The overhead of writing and updating the list is not to be underestimated.

Thanks to my fluffy, pink coloured dream world I live in, I still think a todo list helps me. And to really help me, I have to find the right one. The perfect one!

Not an easy task. There are a bazillion different todo list applications and concepts. And after all that years, it feels like I TRIED THEM ALL! Yes, that is the moment I would drag my lower eye lids down to my chin.

It is just mind boggling. How is it possible to try an uncounted number of different applications for such a simple task and not find the right one?


The problem is complexity.
==========================

What most of them are doing wrong is – in my humble opinion - that they are trying to solve a seemingly simple task with complexity. Two things are wrong here: First of all, todo lists are not simple. They are *complex*, because you want to write them in *your* way. Sometimes a simple `remember the milk` just doesn't cut it. And the second problem is, that a complex application finally leads to restrictions. The more options an applications gives you, the more it tries to solve for you and the more you have to fight if you want or need something, the creators didn't think of.

A better way to approach the problem is to remove restrictions and complexity as much as possible. The simpler a system is, the more you can do with it, as long as it is the todo list equivalent of [Turing complete](https://en.wikipedia.org/wiki/Turing_completeness).


Simple plain todo files.
========================

What is the most simple thing for a (digital) todo list? Exactly: A plain text file. My first approach (and *of course* I even implemented my own little helper applications for it) was to create files named TODO that where optionally suffixed with a context. I had them in the home directly, in `~/.todo/`, in `~/todo/`, you name it. Contentwise I started with a simple format that only supported todo and done state and used checkboxes for it. For example

```
[ ] do something
[x] did something
```

Sooner or later I wanted a due date:

```
[ ] do something until 2005-01-05
[x] did something until 2005-01-04
```

which very soon changed for easy sortability:

```
[ ] 2005-01-05 do something
[x] 2005-01-04 did something
```

Now I had a very simple system, that allowed projects, due dates and archiving of finished entries. This worked quite a long time for me. At some point in time tough I began playing around again, tried other approaches, wanted more functionality, more ways to add context. I ended up with a desktop wiki application called [Zim](http://zim-wiki.org/), which allowed me to link from one entry to another. Now I mixed my todo format with Zims wiki capabilites.

It didn't take long until I got annoyed to much by using a graphical application and at some point I wanted another feature: Synchronisation between my home, my work and preferably my mobile phone.


Taskwarrior
===========

Finally I found something quite well positioned in the middle of too much complexity and enough features. [Taskwarrior](http://taskwarrior.org) uses a quite simple text format so store and organize tasks (added line breaks for readability):

```
[description:"be the change you want to see in the world"
 entry:"1408626379"
 modified:"1424214810"
 project:"personal"
 start:"1408626589"
 status:"pending"
 tags:"personal,improvement,quotes"
 uuid:"f51c578f-b209-41e5-a909-f3154b5c999b"]
```

Still human readable, not quite human writable though, espacially when you not only want to modify an existing task. The tasks are also spread over multiple files in `~/.task`. Usually this folder looks like:

```
%> file ~/.task/*
.task/backlog.data:    ASCII text
.task/ca.cert.pem:     PEM certificate
.task/client.cert.pem: PEM certificate
.task/client.key.pem:  ASCII text
.task/completed.data:  UTF-8 Unicode text, with very long lines
.task/pending.data:    ASCII text
.task/undo.data:       UTF-8 Unicode text, with very long lines
```

As an exchange Taskwarrior offers a lot more features. It offers task change history, task archives, unique task IDs and with `taskd` even a sychronisation server. This featureset makes it a replacement for your teams ticket system. As a very nice addition exists with [inthe.am](https://inthe.am) a webservice that offers you all these features with a nice webbased GUI and allows synchronisation to your mobile phone, where you could use inthe's webinterface or [Mirakel](https://mirakel.azapps.de) to manage your tasks. Inthe.am also offers an own `taskd` but you can also configure it to use your own. The taskd server supports authentication for multiple teams and users per team. Who needs Jira, eh?

This is quite nice and so one – but – you might guess it already: It is to far away from simple text based, hand written task lists. It is awesome for managing a project with your team and I would love to get rid of Jira and others for it. For a single person, though, it is simply too much.

I used it anyway for quite some time. Especially because the default CLI client for `taskwarrior` is really good. Despite the flaw that has to be called from command line for every command which makes it painful to add or edit multiple tasks. But it comes with nicely coloured output, extensive filter possibilities, an urgency value that is calculated by attributes like age, priority and due time, (filtered) list export and even graphical monthly and yearly task state reports. So again: Who needs Jira?


todo.txt
========

Some day I went back to something I knew already but never tried extensively.  It is called `todo.txt` and although there is a default client for it, it is rather a protocol than an application. And I think it is a good one.

A good protocol or format definition should be created with simplicity and extendability in mind. Simplicity makes it easy to handle and therefor easy to write tools for it. And how often you find something that is very close to what you need but just missing a few little things? Here comes the need for extendability.

`todo.txt` has all this. See a little excerpt of my todo list in this format:

```
CoeLux @readinglist
(A) bring back Elixir Book +learning +programming @office due:2015-07-13
x 2015-07-10 decide about +github vs +gogs @server +productivity
gyroscope. @readinglist
http://doc.cat-v.org/plan_9/4th_edition/papers/plumb @readinglist
http://doc.rust-lang.org/guide.html#futures @readinglist
```

You can see a most of the rules here and probably understood them already without any further explanation:

* one entry per line
* context is prefixed by an @-sign
* tags (they call them *projects*) are prefixed by a +-sign
* priorities are optional and can be set by starting an entry with (A), (B) and so on
* done tasks are beginning with x followed by space and an (optional) done date
* additional meta data usually is written key:value style, like the due date in my example `due:2015-07-13`

Readable and writable very easily with any text editor. Simple to extend by adding key:value pairs. Synchronisation can be realised with any Dropbox-style file system. If you need a changelog, just put `git` around it with a simple `auto-commit` hook. An `auto-push` would even render that Dropbox solution obsolete. Most mobile or web based clients only support Dropbox, though, which is a shame. I don't want to let that untrustworthy service handle my todo list.


ViMTODO
=======

Thanks to my ViM addiction (which made the usage of any "normal" editor unbearable already) I barely used any addition programs for my TODO file. For easy reading and filtering, I sometimes use `todotxt-machine`. But it would be way way nicer to have all that in ViM directly. So I looked around and found `ViMTODO`.

`ViMTODO` joins a simple format (similar but not the same as todo.txt) with the possibility for meta information. A single task can get addition information by adding indented lines after it. Thanks to the extensive use of ViM features like folding and syntax highlighting the TODO file stays readable.

My little TODO extract in ViMTODO format:

```
TODO 2015-07-01 CoeLux @readinglist
TODO 2015-07-05 bring back Elixir Book +learning +programming @office {2015-07-13}
DONE 2015-07-01 decide about +github vs +gogs @server +productivity
TODO 2015-07-01 gyroscope. @readinglist
TODO 2015-07-01 http://doc.cat-v.org/plan_9/4th_edition/papers/plumb @readinglist
TODO 2015-07-01 http://doc.rust-lang.org/guide.html#futures @readinglist
```

The plugin helps you with your task list by providing commands like `<localleader>cn` to create a new entry starting with status and date in the next line. It has shortcuts for inserting the current date, too. So to set a due date to today you simply type `{ds}`. Unfortunately this replacement functionality is very basic. To add `TODO <current date>` into an existing line, for example, you just type `cn ` and it gets replaced. But it doesn't take existing parts into account so that you cannot write anything containing cn in your list. I filed an [issue](https://github.com/mivok/vimtodo/issues/9) for that, maybe it gets fixed.

Since it is just a filetype plugin, you can make any file a TODO file. If you archive your finished tasks, they will be moved to a file called `done.txt`. Unfortunately independend from the name of your todo file. What I also don't like so much is the missing extendability and of course the direct dependency to a single application (or rather plugin in this case). It is also close to impossible to handle a todo list with `ViM-Touch`, the in my opinion only at least somehow useful ViM implementation for mobile devices.

Synchronisation would have to be handled by an external service like Dropbox or Git. It should be quite easy to lower the pain of add/commit/push/pull with git hooks and buffer commands that do a git pull on open and a git push on close. I never tried these things with ViM-Touch, though.


Back to todo.txt
================

As you can see, nothing except `todo.txt` really ever worked for me. `ViMTODO` sure is close to be good and I liked the idea of having meta information in indented lines but I never really used that possibility. The default taskwarrior client is also fantastic for viewing tasks but a p.i.t.a. if you want to add or edit multiple tasks at once.

Luckily I found a seemingly good `todo.txt` plugin for ViM. [todo.txt-vim by github user freitass](https://github.com/freitass/todo.txt-vim). It supports the standard todo.txt format, adds some quick sorting functionality to sort by date, project or context. It can handle prefixed todo files like `fancyproject.todo.txt` and `fancyproject.done.txt` for people who want to split their files this way (I do for short term todo files).

There are also some mobile clients that are good enough to view, filter and change the todo list on the road. The one I currently use is called [SimpleTask Cloudless](https://play.google.com/store/apps/details?id=nl.mpcjanssen.simpletask). It is completely free and offers a donation "app" to buy for 5€ if you want to support the author. I never tried the non-free [todo.txt touch](http://todotxt.com/) but the broader opinion seems to be that SimpleTask is the better option anyway. The *cloudless* version only supports local files on the device and doesn't need Dropbox. That gives me the possibility to use my own synchronisation solution. There are some good articles about how to achieve synchronisation with opensource tools. Please find them in the reading list at the end of this article.

None of the typical synchronisation solutions for mobile phones suits me well, though. They either don't work as expected ([Syncthing](http://syncthing.net/), [BTSync](https://www.getsync.com/)), need a special server setup regarding security ([FolderSync](http://www.tacit.dk/foldersync)), want money to be usable conviently ([Unison Sync](https://play.google.com/store/apps/details?id=net.danielroggen.unisonsync)) or only support synchronisation in time intervals (Unison, FolderSync). And I didn't yet mention my strong preference for OpenSource software. My preferred setup would update on file open and trigger something on file save that waits for a few minutes for successive changes and then simply pushes the changes back to the server. Conflicts should be rare and could be handled later on, it is still just a simple text file.

Aww, it is still a mess!


Reading list
============

[To-Do App Alternatives](https://zapier.com/blog/to-do-app-alternatives/)
[Why Your To-Do List is Broken and How You Can Fix It](https://zapier.com/blog/to-do-list-broken/)
[My Todo.txt Workflow](https://raymii.org/s/articles/My_Todo.txt_Workflow.html)
[How To Manage Todo.txt With Owncloud](https://blog.portknox.net/2014/11/how-to-manage-todo-txt-with-owncloud/)

---

As always I'm open to your opinions. What is your way of managing todo files?
