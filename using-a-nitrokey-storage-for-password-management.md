I recently got a Nitrokey Storage with some
[gibibytes](https://en.wikipedia.org/wiki/Gibibyte) of encrypted space, a
SmartCard interface and [more](https://www.nitrokey.com/).

My plan is to use it together with [pass](https://www.passwordstore.org/) to
encrypt all the important things (and passwords of course) via PGP keys,
besides the typical things like email encryption and signing. But there is one
important problem: I want all that to work on my android phone, too!

But, first things first:

## Get Nitrokey-App to work on VoidLinux

The Nitrokey-App is shipped in the [Snapd](http://snapcraft.io/) package format
which works for many different Linux distributions but not for
[the one I use](http://www.voidlinux.eu/). Luckily the source code was easy to
compile, as soon as I found out, that
[libappindicator](https://launchpad.net/libappindicator) is actually an
optional dependency.

Here are the steps to compile the newest version:

### clone the repository from Github:

```sh
git clone https://github.com/Nitrokey/nitrokey-app.git
cd nitrokey-app
```

### global install

```sh
cmake . -DCMAKE_INSTALL_PREFIX=/ -DHAVE_LIBAPPINDICATOR=NO
make && sudo make install
```

### local install

In case, you want to install the package locally, for example in `~/.local`,
like I prefer for distribution foreign packages, open the file CMakeLists.txt
and find the lines, that list `bash-autocomplete`. Probably Line 273 and 274.
Remove the leading slash from `DESTINATION /etc/bash_completion.d`. There is
already an [issue](https://github.com/Nitrokey/nitrokey-app/issues/189) about
this, so this might not be needed in newer versions anymore. The version at the
time of writing this is `0.6.1`.

```sh
cmake . -DCMAKE_INSTALL_PREFIX=$HOME/.local -DHAVE_LIBAPPINDICATOR=NO
make && make install
```

After installation, the nitrokey-app needs to be started with super user rights
because it needs direct device access:

```sh
sudo nitrokey-app
```

Now you should find a nice new icon next to your clock (or whereever your
systray is).

## Initialising the encrypted vault

The next steps should work as normal, so just follow the menu in the app, but…

*Attention* this step takes a while, especially if you have a big 32 or even
64GB storage! I just ran it over night. It takes hours!


---

* …come back in the next days and I will have written more… *



