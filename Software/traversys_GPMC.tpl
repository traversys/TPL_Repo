tpl 1.6 module traversys_GPMC;

metadata
  __name        := 'Microsoft Group Policy Management Console';
  tree_path     := 'Traversys', 'Software', 'Microsoft Group Policy Management Console';
end metadata;

pattern Traversys_SI_AD_GPMC 1.2
    '''
    Microsoft Group Policy Management Console
    
    This pattern looks up services associated with GPMC and checks packages to create SIs for
    the Active Directory Management Pack Helper Object and Microsoft Group Policy Management Console.
    
    Change History:
    2015-05-01 | 1.0 | WMF | Created.
    2015-05-06 | 1.1 | WMF | Removed service SI creation - only valid if package is found.
    2015-10-01 | 1.2 | WMF | Removed Helper Object.
    
    search DiscoveredService where (name = "gpsvc" or name = "RSoPProv") and state = "RUNNING"

    '''
    
    overview 
      tags Custom, Traversys, ActiveDirectory, LDAP, GPMC;
    end overview;
    
    constants
      pkg_rx:= [ regex "Microsoft Group Policy Management Console" ];
      type  := "Microsoft Group Policy Management Console";
    end constants;
    
    triggers
      on svc:= DiscoveredService created, confirmed where (name = "gpsvc" or name = "RSoPProv") and state = "RUNNING";
    end triggers;

    body

      host      := related.host(svc);
      state     := svc.state;
      name      := '%type% on %host.name%';
      key       := text.hash("%type%/%host.key%");
      version   := "";
      pr_version:= "";
      
      packages:= model.findPackages(host, pkg_rx);
      
      if size(packages) > 0 then
          for pkg in packages do
              if "version" in pkg then
                  version:= pkg.version;
                  pr_version:= regex.extract(version, regex '^(\d+(?:\.\d+)?)', raw '\1', no_match := version);
                  name:= '%type% %pr_version% on %host.name%';
              end if;
          end for;
      end if;

      si:= model.SoftwareInstance(key:= key, name:= name, type:=type, version:= version, product_version:= pr_version, state:= state, _traversys:= true);
      model.setRemovalGroup(si, "sis");
      
    end body;
  
end pattern;

identify tsys_GPMC 1.0
  tags GPMC;
  DiscoveredProcess cmd -> set_by, simple_identity;
    windows_cmd 'gpsvc'    -> 'traversys', 'Microsoft Group Policy Management Console';
    windows_cmd 'RSoPProv' -> 'traversys', 'Microsoft Group Policy Management Console';
end identify;

// The MIT License (MIT)

// Copyright Wes Moskal-Fitzpatrick 2015

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