tpl 1.6 module traversys_SwiftMQ;
    
metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Software', 'SwiftMQ';
end metadata;

pattern traversys_SwiftMQ 1.0
    """
    Author: Wes Moskal-Fitzpatrick (Traverys Limited)
    
    This pattern creates an SI for SwiftMQ.
    
    The pattern:-
      1. Triggers on swiftmq discovered process.
      2. Extracts the application string from the process.
      3. Extracts the version from the process string.
      4. Models the SoftwareInstance for the SwiftMQ SI.
      5. Adds related SIs to the containment via process children.
      
    Change History:
    2014-10-20 | 1.0 | WMF | Created.
    
    Supported Platforms:
    N/A
    
    """    
  
    metadata
        publishers := "IIT Software";
        products := "SwiftMQ";
        product_synonyms := "SwiftMQ";
    end metadata;
  
    overview
      tags custom, traversys, SwiftMQ, JBoss, MQ;
    end overview;

    triggers
      on p := DiscoveredProcess where cmd matches windows_cmd "cmd" and args matches regex "\bswiftmq\w";
    end triggers;

    body
    
        h:= model.host(p);
        app:= "Unknown";
        pv:= "";
        cps:= discovery.children(p);
        
        ax:= regex.extract(p.args, regex "\bswiftmq(_\d+)+_(\D\w+)", raw "\2");
        
        if ax then
            app:= text.upper(ax);
        else
            log.warn("No application string defined, not genuine SwiftMQ process, stopping...");
            stop;
        end if;
        
        i:= app;
        t:= "SwiftMQ";
        n:= "%t% %i% instance on %h.name%";
        k:=text.hash("%t%/%i%/%h.key%");
        
        rv:= regex.extract(p.args, regex "\bswiftmq_((\d+_?)+)", raw "\1");
        vs:= text.rightStrip(rv, "_");
        v:= text.replace(vs, "_", ".");
        
        if v then
            pv:= regex.extract(v, regex "^(\d+(?:\.\d+)?)", raw "\1", no_match:= v);
            n:= "%t% %pv% %i% instance on %h.name%";
            k:=text.hash("%t%/%i%/%v%/%h.key%");
        end if;
        
        si:= model.SoftwareInstance(key:= k, type:= t, name:= n, version:= v, product_version:= pv, instance:= i, _traversys:= true);
        log.info("Software Instance created for %n%");
        
        inference.associate(si, cps);

  end body;

end pattern;

identify tsys_swiftmq 1.0
    tags SwiftMQ;
    DiscoveredProcess cmd, args -> simple_identity;
    windows_cmd "cmd", regex '\bswiftmq\w' -> 'SwiftMQ Initilisation';
end identify;

// The MIT License (MIT)

// Copyright Corporate Software Services 2014

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