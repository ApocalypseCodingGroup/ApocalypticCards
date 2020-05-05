# ApocalypticCards
A game to alleviate boredom while under "stay-at-home" orders.

Developed during a series of live coding sessions which began on March 28th 2020 and are currently on-going as of 5th May 2020, this Delphi-powered game aims to help while away the hours for those who are currently 'self isolating' or forced to stay at home during the 2020 COVID-19 pandemic.

We also wanted to demonstrate that there are many approaches to solving the problems inherent in what looks like a simple task as well as show case some Delphi live-coding by a loose collection of Embarcadero MVPs.  In particular the client-side apps employ a multitude of technologies and operating system platform targets such as VCL, FMX, Web, Windows, Linux and macOS.  We might even stretch out and produce Android and iOS versions - Delphi can do it, so why not?

NOTE: You do not have to wear a mask while coding but if you are sharing your keyboard
or screen you do need to stay six feet away from your computer peripherals.  We don't
have to ask you to practice social distancing - you're a coder, being socially distant
from `The Normals` is the default setting.  ;)

https://www.youtube.com/watch?v=dbgaHNrDdBs&list=PL-oEujJyp0deGinpcUgiZwoa_rPnmgCwN

## How to set up a local apache virtual host server on Linux for this game

### Your local hosts file

**NOTE**

> If you don't want to create a virtual host on your Apache setup, skip this step

First you'll need to add an entry to your `/etc/hosts` file so you can have local `DNS` resolve:

```shell
$ sudo nano /etc/hosts
```

Amend your file with something along these lines:

```shell
# ...

## Apocalypse Cards local
127.0.0.1   apocalypse-cards

#...
```
I've chosen to have an `URL` of `http://apocalypse-cards`. You can choose what ever you want.

### The Apache module

Navigate to the folder where you've `git clone` the Apocalypse Cards game repository and under

`<cardgame folder>/server/out/bin/Linux64/Release`

you'll find various files. The one we are now looking for is `libmod_cardgame.so`.

Copy that file to the Apache module folder ( the command `a2query -d` will return such folder ):

```shell
$ sudo cp libmod_cardgame.so "$(a2query -d)mod_cardgame.so"
```

The module is now available to be loaded by Apache.

We now need to create a file under `/etc/apache2/mods-available` so that we can load it.

Using your preferred plain text editor create/edit a file called `cardgame.load`:

```shell
$ sudo nano /etc/apache2/mods-available/cardgame.load
```

Add the following single line to it:


```apache
LoadModule cardgame_module /usr/lib/apache2/modules/mod_cardgame.so
```

### A local database for the game

This example assumes you have a MySQL server with version `8.x`.

At this moment you can go and create a database on your local MySQL server:

```sql
CREATE DATABASE `apocalypticcards`;
```

You should also create a user that has access to that database:

```sql
CREATE USER 'apocalypticcards'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'apocalypticcards';
GRANT ALL PRIVILEGES ON `apocalypticcards`.* TO 'apocalypticcards'@'localhost';
```

You'll note that I'm using the new login plugin `caching_sha2_password`. If you have issues with the Apocalypse Card server not connecting try:

```sql
CREATE USER 'apocalypticcards'@'localhost' IDENTIFIED WITH mysql_native_password BY 'apocalypticcards';
GRANT ALL PRIVILEGES ON `apocalypticcards`.* TO 'apocalypticcards'@'localhost';
```

If you still have issues, try to omit the login plugin ( For versions other than 8.x ):

```sql
CREATE USER 'apocalypticcards'@'localhost' IDENTIFIED BY 'apocalypticcards';
GRANT ALL PRIVILEGES ON `apocalypticcards`.* TO 'apocalypticcards'@'localhost';
```

We have provided some SQL scripts that you can find under `<cardgame folder>/install`.

There you'll find 2 files: `data.sql` and `database.sql`.

On the command line you can issue:

```shell
$ mysql -u apocalypticcards -papocalypticcards apocalypticcards < database.sql
```

Then, to populate some initial values:

```shell
$ mysql -u apocalypticcards -papocalypticcards apocalypticcards < data.sql
```

### The Apocalypse Cards server database connection setup

Before we can load the module, it needs to find the database connection configuration file under `/etc/apocalypsecards`.

Create that folder:

```shell
$ sudo mkdir -p /etc/apocalypsecards
```

Under `<cardgame folder>/server/out/bin/Linux64/Release` you'll find the `*.ini` file with the database configuration.

Copy such file to the `/etc/apocalypsecards` folder:

```shell
$ sudo cp cardgame.ini /etc/apocalypsecards/
```

The file should look something like this:

```ini
username=apocalypticcards
password=apocalypticcards
database=apocalypticcards
```

If you followed all the above instructions, the file is ready to go. If not, then edit accordingly to your specific database setup.

### Loading the module

At this moment we can add the module to the list of loaded ones by doing like so:

```shell
$ sudo a2enmod cardgame
$ sudo systemctl restart apache2.service
```

If that last command does not return any error, all went well.

You can verify that the module is loaded by doing the following:

```shell
$ a2query -m | grep cardgame
```

The result should be:

```
cardgame (enabled by site administrator)
```

### Using the module in a site

At this point you have 2 options:

- [Use the module across all virtual sites](#use-the-module-across-all-virtual-sites)
- [Use the module on a specific virtual site](#use-the-module-on-a-specific-virtual-site)

Click on one of the links for information on how to setup your choice.

### Use the module across all virtual sites

**NOTE**

> This has so far only been tested using the Virtual Site option.

If you have no other virtual site setup on your local Apache server and don't mind the module running on what ever is the first site Apache serves then let's start by creating a `cardgame.conf` under `/etc/apache2/conf-available`:

```shell
$ sudo nano /etc/apache2/conf-available/cardgame.conf
```

This file should look like this:

```apache
 <Location /api>
    SetHandler mod_cardgame-handler
 </Location>

```

Now let's enable that configuration and restart Apache:

```shell
$ sudo a2enconf cardgame
$ sudo systemctl restart apache2.service
```

If all went well, no errors where reported.

You can now browse to [http://localhost/api/games](http://localhost/api/games) and see that it should return you a JSON empty array.

### Use the module on a specific virtual site

In order to have a virtual server with the module, we'll need to create one.

Since there's talk about the server serving animated gifs, I've chosen to create a folder in order to accommodate a site folder structure:

```shell
$ sudo mkdir -p /var/www/apocalypse-cards
$ sudo chown www-data.www-data /etc/www/apocalypse-cards
```

Remember that if you want local DNS resolution of this virtual site, please follow instruction for [editing](#your-local-hosts-file) your `/etc/hosts` file.

Use your preferred text editor to create/edit a file under `/etc/apache2/sites-available/`:

```shell
$ sudo nano /etc/apache2/sites-available/001-apocalypse-cards.conf
```

This file should look like this:

```apache
<VirtualHost *:80>
    ServerName apocalypse-cards
    ServerAdmin yourname@example.com

    DirectoryIndex index.html.
    DocumentRoot /var/www/apocalypse-cards

    ErrorLog ${APACHE_LOG_DIR}/error-apocalypse-cards.log
    CustomLog ${APACHE_LOG_DIR}/access-apocalypse-cards.log combined

    <Location /api>
        SetHandler mod_cardgame-handler
    </Location>

    <Directory /var/www/apocalypse-cards>
        Options FollowSymLinks
        AllowOverride All
    </Directory>

</VirtualHost>
```

In order for Apache to begin to serve the virtual host do the following:

```shell
$ sudo a2ensite 001-apocalypse-cards
$ sudo systemctl reload apache2.service
```

If all went well, no errors where reported.

You can now browse to [http://apocalypse-cards/api/games](http://apocalypse-cards/api/games) and see that it should return you a JSON empty array.

### NOTE

Many thanks to [Gustavo Carreno](https://github.com/gcarreno) who made many excellent and significant contributions to this Read Me document.
