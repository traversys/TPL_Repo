tpl 1.6 module traversys_fileCap;

metadata
   origin:="Traversys";
   tree_path:='Traversys', 'Extended', 'File Capture';
end metadata;

configuration fileCap 1.0
    """File Inputs"""

    "File" file := "";

    "Directory" dir := "";

    "List of Files" files := [ '' ];

    "Listof Directories" dirs := [ '' ];

end configuration;

definitions lookup 1.0
    """
        Custom Traversys Functions

        Author: Wes Moskal-Fitzpatrick

        Change History:
        2022-01-26 | 1.0 | WMF | Created

    """
    
    define getFile(target, path)
        """Get a file."""
        file:= discovery.fileGet(target, path);
        if file and file.md5sum then
            log.info("File %file.path% captured!");
        else
            log.warn("File %path% not found.");
        end if;
    end define;

    define getDir(target, path)
        """Get a directory."""
        dir:= discovery.listDirectory(target, path);
        if dir and dir.method_success then
            log.info("Directory %dir.path% listed!");
        else
            log.warn("Directory %path% not found.");
        end if;
    end define;

end definitions;

pattern traversys_fileCap 1.0

    '''
    Author: Wes Moskal-Fitzpatrick

    Description:
    Handy TPL for capturing and testing random files and directories without actually
    modifying existing TPL.

    Change History:
    2022-01-26 | 1.0 | WMF | Created.

    '''

    overview 
        tags traversys, files, custom;
    end overview;
    
    triggers 
        on host := Host created, confirmed;
    end triggers;

    body

        // Single File
        if fileCap.file then
            lookup.getFile(host, fileCap.file);
        end if;

        // Single Directory
        if fileCap.dir then
            lookup.getDir(host, fileCap.dir);
        end if;

        // List of files
        if size(fileCap.files) > 0 then
            for files in fileCap.files do
                lookup.getFile(host, files);
            end for;
        end if;

        // List of directories
        if size(fileCap.dirs) > 0 then
            for dirs in fileCap.dirs do
                lookup.getFile(host, dirs);
            end for;
        end if;

    end body;

end pattern;

// The MIT License (MIT)

// Copyright Wes Moskal-Fitzpatrick 2013-2022

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.