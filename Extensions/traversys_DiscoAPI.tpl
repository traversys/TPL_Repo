tpl 1.20 module traversys_discoAPI;

metadata
   origin:="Traversys";
   tree_path:='Traversys', 'Extended', 'Discovery API';
end metadata;

from PsuedoVault import psuedoVault 1.0;

pattern traversys_discoAPI 1.0

    '''
    Author: Wes Moskal-Fitzpatrick

    Description:
    Interact with Discovery API.
    Contains method of using oauth2 with Data Source to access via login (temporary token).
    Includes method to retrieve the temporary token using psuedoVault credential.

    Change History:
    2022-03-19 | 1.0 | WMF | Created.

    '''

    overview 
        tags traversys, rumcmd, custom;
    end overview;
    
    triggers 
        on si := SoftwareInstance created, confirmed where type = "BMC Discovery";
    end triggers;

    body

        host := related.host(si);

        // Basic Auth
        selfDS:= discovery.dataSource('Disco Oauth');
        for k in selfDS do
            v:= selfDS[k];
            log.debug("selfDS: %k%, %v%");
        end for;

        // About
        about:= discovery.restfulGet(selfDS, "oauth2", "/api/about");
        if about and about.response then
            log.debug("%host.name% : About >>> Status : %about.response_status%");
            log.debug("%host.name% : About >>> Headers : %about.response_headers%");
            log.debug("%host.name% : About >>> Reason : %about.response_reason%");
            log.debug("%host.name% : About >>> Body : %about.response_body%");
        end if;

        // Get a Token
        username:= psuedoVault.username;
        configs:=search(PatternConfiguration where name = "PsuedoVault.psuedoVault");
        config:=configs[0];
        password:= PsuedoVault.reveal(config._p);
        payload:= "grant_type=password&username=%username%&password=%password%";
        log.debug("payload=%payload%");
        token:= discovery.restfulPost(selfDS, "oauth2", "/api/token",payload);
        if token and token.resonse then
            log.debug("%host.name% : Token >>> Status : %token.response_status%");
            log.debug("%host.name% : Token >>> Headers : %token.response_headers%");
            log.debug("%host.name% : Token >>> Reason : %token.response_reason%");
            log.debug("%host.name% : Token >>> Body : %token.response_body%");
        end if;

        // Vault
        vault:= discovery.restfulGet(selfDS, "oauth2", "/api/v1.4/vault");
        if vault and vault.resonse then
            log.debug("%host.name% : Vault >>> Status : %vault.response_status%");
            log.debug("%host.name% : Vault >>> Headers : %vault.response_headers%");
            log.debug("%host.name% : Vault >>> Reason : %vault.response_reason%");
            log.debug("%host.name% : Vault >>> Body : %vault.response_body%");
        end if;

        // Query
        query:= table();
        query['query']:= "search Host show os_type process with unique()'";
        payload := json.encode(query);
        result:= discovery.restfulPost(selfDS, "oauth2", "/api/v1.4/data/search",payload);
        if result and result.resonse then
            log.debug("%host.name% : Query Result >>> Status : %result.response_status%");
            log.debug("%host.name% : Query Result >>> Headers : %result.response_headers%");
            log.debug("%host.name% : Query Result >>> Reason : %result.response_reason%");
            log.debug("%host.name% : Query Result >>> Body : %result.response_body%");
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
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE// SOFTWARE.
