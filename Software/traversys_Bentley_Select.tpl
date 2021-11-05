tpl 1.9 module traversys_Bentley_SELECT;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'Bentley Systems', 'SELECTServer';
end metadata;

pattern Traversys_SI_SELECTServer 1.0
    """
        Models Bentley SELECTServer SI
    
        Change History:
        2015-09-11 1.0 | WF | Created.

    """

    metadata
        products := 'SELECT';
        urls := 'https://www.bentley.com/en/subscriptions/select-subscription/software-subscription-for-any-size-organization';
        publishers  := 'Bentley Systems';
        categories := 'License Management';
        known_versions := '0';
    end metadata;

	overview
		tags bentley, select, custom, traversys;
	end overview;
    
    constants
        type:= 'Bentley SELECTServer';
    end constants;
	
	triggers
		on p := DiscoveredProcess created, confirmed where cmd matches windows_cmd 'Bentley\.SelectServer';
    end triggers;
	
	body
	
		host:= related.host(p);
		
		name:= '%type% on %host.name%';

        key:= "%name%/%host.key%";
	
		si := model.SoftwareInstance(
                                    key:= key,
                                    name:= name,
                                    type:= type,
                                    _traversys:= true
                                    );
        model.setRemovalGroup(si, "%type%_sis");
        if p.cmd matches "Bentley\.SelectServer\.Gateway" then
            si.instance:= "Gateway";
        end if;
	
	end body;
	
end pattern;

identify Bentley 1.0
    tags Bentley;
    DiscoveredProcess cmd -> simple_identity;
    windows_cmd 'Bentley\.SelectServer' -> "Bentley SELECTServer";
end identify;

// The MIT License (MIT)

// Copyright Wes Fitzpatrick 2015

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