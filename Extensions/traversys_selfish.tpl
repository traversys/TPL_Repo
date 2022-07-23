tpl 1.20 module traversys_selfish;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Frameworks', 'Selfish';
end metadata;

configuration defaults 1.0
    """Default API configs"""

    "API Version" api_version := "1.0";

end configuration;

definitions self 1.0
    """
        Framework for utilising Discovery API.

        Author: Wes Moskal-Fitzpatrick

        Change History:
        2022-07-23 | 1.0 | WMF | Created.

    """

    define debug(result)
		""" Output debug info. """
		
        if result and result.response_status then
            log.debug("Endpoint : %result.path%");
            log.debug("Status : %result.response_status%");
            log.debug("Headers : %result.response_headers%");
            log.debug("Reason : %result.response_reason%");
            log.debug("Body : %result.response_body%");
        else
            log.debug("API call failed to run, couldn't get response status.");
        end if;

    end define;

    define api_version(datasource) -> result, version
        """ Find the version in use """
        
        result:= discovery.restfulGet(datasource, "oauth2", "/api/about");
        //debug(result);

        version:= defaults.api_version;
        
        if result and result.response_status = 200 then
            res_json:= json.decode(result.response_body);
            version:= jmespath.evaluate(res_json, "api_versions[-1:]|[0]");
        end if;

        return result, version;

    end define;
    
    define get(datasource, endpoint, headers:=none, version:=none) -> get_result
		""" Run a GET api call. """

        if not version then
            version_result, version:= api_version(datasource);
        end if;

        path:= "/api/v%version%" + endpoint;

        if headers and datatype(headers) = "table" then
            get_result:= discovery.restfulGet(datasource, "oauth2", path, headers);
        else
            get_result:= discovery.restfulGet(datasource, "oauth2", path);
        end if;
		
        return get_result;

    end define;

end definitions;

definitions twadmin 1.0
    """
        Admin API calls.

        Author: Wes Moskal-Fitzpatrick

        Change History:
        2022-07-23 | 1.0 | WMF | Created.

    """
    
    define about(datasource) -> about_info
		""" Return about info. """
		about_info:= self.get(datasource, "/admin/about");
        return about_info;
    end define;

    define baseline(datasource) -> baseline_info
		""" Get the current baseline. """
		baseline_info:= self.get(datasource, "/admin/baseline");
        return baseline_info;
    end define;

    define license(datasource) -> licensing
		""" Get licensing output (plaintext). """
        headers:= table();
        headers["Accept"]:= "text/plain";
		licensing:= self.get(datasource, "/admin/licensing",headers:=headers);
        return licensing;
    end define;

end definitions;

definitions twvault 1.0
    """
        Author: Wes Moskal-Fitzpatrick

        Vault API calls.

        Change History:
        2022-07-23 | 1.0 | WMF | Created.

    """

    define credential_types(datasource, group:=none, category:=none, type:=none) -> types
		'''Get a list of all credential types and filter by group and/or category.'''
        path:= "/vault/credential_types";
        params:= table();
        if group then
            params['group'] := group;
        end if;
        if category then
            params['category'] := category;
        end if;
        if type then
            path:= "/vault/credential_types/%type%";
        end if;
        types := self.get(datasource, path, headers:=params);
        return types;
    end define;

    define credentials(datasource, uuid:=none) -> types
		'''Get a list of all credential types and filter by group and/or category.'''
        path:= "/vault/credentials";
        if uuid then
            path:= "/vault/credentials/%uuid%";
        end if;
        types := self.get(datasource, path);
        return types;
    end define;

end definitions;

pattern traversys_framework_test 1.0

    '''
    Author: Wes Moskal-Fitzpatrick

    Description:
    Test for framework.

    Change History:
    2022-07-23 | 1.0 | WMF | Created.

    '''

    overview 
        tags traversys, api, framework;
    end overview;
    
    triggers 
        on si := SoftwareInstance created, confirmed where type = "BMC Discovery";
    end triggers;

    body

        // Basic Auth
        log.debug("Getting DS");
        ds:= discovery.dataSource('Disco Oauth');

        // Credentials
        log.debug("Running credential types query");
        credential_types:= twvault.credential_types(ds,type:="oracle");
        self.debug(credential_types);

        log.debug("Running credentials query");
        credentials:= twvault.credentials(ds,uuid:="");
        self.debug(credentials);

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