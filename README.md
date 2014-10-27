Base64 Encode
=================

Base64 Encode is an OSX Service used to encode files to [Data URIs](http://en.wikipedia.org/wiki/Data_URI_scheme). With this tool encoding an image, SVG or any other file to a Data URI is a right click away. The resulting output will automatically be copied to your clipboard for use in your web page or stylesheet.

![Base64 Encode](screenshot.png)

Installing
------------------
1. Run the PKG file included in this repository.
2. Right click on any file from Finder. Click "Base64 Encode" to encode that file.

If the service doesn't appear right away, try typing this in your command line:

    /System/Library/CoreServices/pbs -flush

Building from Source
------------------
Base64 Encode has no external dependancies. Simply open the Base64 Encode.xcodeproject and Build. Let us know if there are any issues.

Uninstalling
------------------
To uninstall, simply delete **/Library/Services/Base64 Encode.service**. You may have to type in your admin password to confirm.

Base64 Encode isn't storing any data or tie itself to your system in any meaningful way. No harm will come to you deleting it directly.

Version History
------------------
#### 1.1
- Added an app icon. Only shows up during errors as far as I'm aware.
- Errors out if a file is greater than 10MB, or if you've chosen a directory.
- Created a PKG file for easy install.
- Play custom sounds on success (or failure).

#### 1.0
- Initial release.
- Future features to think about
    + Adding an app icon. Is that needed for a service?
    + Erroring out if a file is too large, or if an invalid file is chosen (such as a directory)
    + Creating an installer (PKG perhaps?)
    + Insuring it loads on bootup

Contact
------------------
Built lovingly by the good folks at [Arbitrary](http://arbitrary.io). Follow us on [Twitter](http://twitter.com/arbitraryco).

License
------------------
Base64 Encode is released under the MIT license. See LICENSE for details.