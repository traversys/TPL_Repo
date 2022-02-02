tpl 1.6 module traversys_runAnything;

metadata
   origin:="Traversys";
   tree_path:='Traversys', 'Extended', 'Run Anything';
end metadata;

configuration runAnything 1.0
    """File Inputs"""

    "Command" cmd := "";

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

pattern traversys_runAnything 1.0

    '''
    Author: Wes Moskal-Fitzpatrick

    Description:
    Handy TPL for running any command ad-hoc to see results.
    Includes tw_capture for capturing exit status.

    Change History:
    2022-02-02 | 1.0 | WMF | Created.

    '''

    overview 
        tags traversys, rumcmd, custom;
    end overview;
    
    triggers 
        on host := Host created, confirmed;
    end triggers;

    body

        if runAnything.cmd then
            runcmd:= discovery.runCommand(host, "tw_capture run_anything %runAnything.cmd%");
            if runcmd and runcmd.result then
                log.info("%runAnything.cmd% Output: %runcmd.result%");
            elif runcmd and runcmd.failure_reason then
                log.warn("%runAnything.cmd% failed - %runcmd.failure_reason%");
            else
                log.critical("%runAnything.cmd% failed to run.");
            end if;
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