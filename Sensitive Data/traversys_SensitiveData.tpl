tpl 1.6 module traversys_SensitiveData;

metadata
   origin:="Traversys";
   tree_path:='Traversys', 'Extended', 'Sensitive Data';
end metadata;

configuration target 1.0
    """File Input"""

    "Files" files := [
                        "README.md",
                        "plaintext.json",
                        "random_1.txt",
                        "random_2.txt",
                        "plaintext.xml"
                    ];
    "Path" path := """/Users/Documents/GitHub/TPL_Repo/Sensitive Data/""";

end configuration;

pattern traversys_SensitiveData 1.0

    '''
    Author: Wes Moskal-Fitzpatrick

    Description:
    Pattern for testing sensitive data filters.

    Change History:
    2022-05-16 | 1.0 | WMF | Created.

    '''

    overview 
        tags traversys, sensitive, custom;
    end overview;
    
    triggers 
        on process := DiscoveredProcess where args matches regex "\bfakedp\b";
    end triggers;

    body

        host:= related.host(process);

        // Get file contents
        for file in target.files do
            target_file:= "%target.path%%file%";
            discovery.fileGet(host, target_file);
        end for;

    end body;

end pattern;

// The MIT License (MIT)

// Copyright Wes Moskal-Fitzpatrick 2022

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