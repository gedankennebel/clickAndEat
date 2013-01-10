clickAndEat
===========

This is a University project for "Web Engineering". 
Goal is to realize a web application implemented in ruby using the ruby on rails framework.

Subject of the application is an order system for gastronomy. 

This rails project uses the Paperclip gem to upload and manage files (images).

Paperclip it self, requires 'ImageMagick' which needs to be installed
on the the running machine you use this project.

Settings for Mac:

- check if ImageMagick is already installed with command: which convert 

- if not, download with command (if Homebrew installed): brew install imagemagick 
-or download from here (for all OS): http://www.imagemagick.org/script/binary-releases.php

- add this line: Paperclip.options[:command_path] = "/usr/local/bin/"
 to into this file: config/environments/development.rb

- "/usr/local/bin/" is the path where ImageMagick is installed 
  (for Mac or maybe linux it should be like: "/usr/local/bin/")
- check your own correct path


also read the official installation guide: https://github.com/thoughtbot/paperclip#requirements.




