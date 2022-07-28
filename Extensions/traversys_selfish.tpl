tpl 1.20 module traversys_selfish;

metadata
    origin := "Traversys";
    tree_path := 'Traversys', 'Frameworks', 'Selfish';
end metadata;

configuration defaults 1.0
    """Default API configs"""

    "API Version" api_version := "1.0";

end configuration;

table url_encoding 1.0
    ' ' -> '%20';
    '!' -> '%21';
    '"' -> '%22';
    '#' -> '%23';
    '$' -> '%24';
    '%' -> '%25';
    '&' -> '%26';
    '(' -> '%28';
    ')' -> '%29';
    '*' -> '%2A';
    '+' -> '%2B';
    ',' -> '%2C';
    '-' -> '%2D';
    '.' -> '%2E';
    '/' -> '%2F';
    '0' -> '%30';
    '1' -> '%31';
    '2' -> '%32';
    '3' -> '%33';
    '4' -> '%34';
    '5' -> '%35';
    '6' -> '%36';
    '7' -> '%37';
    '8' -> '%38';
    '9' -> '%39';
    ':' -> '%3A';
    ';' -> '%3B';
    '<' -> '%3C';
    '=' -> '%3D';
    '>' -> '%3E';
    '?' -> '%3F';
    '@' -> '%40';
    '[' -> '%5B';
    '\\' -> '%5C';
    ']' -> '%5D';
    '^' -> '%5E';
    '_' -> '%5F';
    '`' -> '%60';
    '{' -> '%7B';
    '|' -> '%7C';
    '}' -> '%7D';
    '~' -> '%7E';
    '€' -> '%%E2%%82%%AC';
    'ƒ' -> '%%C6%%92';
    '„' -> '%%E2%%80%%9E';
    '…' -> '%%E2%%80%%A6';
    '†' -> '%%E2%%80%%A0';
    '‡' -> '%%E2%%80%%A1';
    '‰' -> '%%E2%%80%%B0';
    'Š' -> '%%C5%%A0';
    'Œ' -> '%%C5%%92';
    'Ž' -> '%%C5%%BD';
    '“' -> '%%E2%%80%%9C';
    '”' -> '%%E2%%80%%9D';
    '•' -> '%%E2%%80%%A2';
    '—' -> '%%E2%%80%%94';
    '™' -> '%%E2%%84';
    'š' -> '%%C5%%A1';
    'œ' -> '%%C5%%93';
    'ž' -> '%%C5%%BE';
    'Ÿ' -> '%%C5%%B8';
    '¡' -> '%%C2%%A1';
    '¢' -> '%%C2%%A2';
    '£' -> '%%C2%%A3';
    '¤' -> '%%C2%%A4';
    '¥' -> '%%C2%%A5';
    '¦' -> '%%C2%%A6';
    '§' -> '%%C2%%A7';
    '¨' -> '%%C2%%A8';
    '©' -> '%%C2%%A9';
    'ª' -> '%%C2%%AA';
    '«' -> '%%C2%%AB';
    '¬' -> '%%C2%%AC';
    '®' -> '%%C2%%AE';
    '¯' -> '%%C2%%AF';
    '°' -> '%%C2%%B0';
    '±' -> '%%C2%%B1';
    '²' -> '%%C2%%B2';
    '³' -> '%%C2%%B3';
    'µ' -> '%%C2%%B5';
    '¶' -> '%%C2%%B6';
    '·' -> '%%C2%%B7';
    '¹' -> '%%C2%%B9';
    'º' -> '%%C2%%BA';
    '»' -> '%%C2%%BB';
    '¼' -> '%%C2%%BC';
    '½' -> '%%C2%%BD';
    '¾' -> '%%C2%%BE';
    '¿' -> '%%C2%%BF';
    'À' -> '%%C3%%80';
    'Á' -> '%%C3%%81';
    'Â' -> '%%C3%%82';
    'Ã' -> '%%C3%%83';
    'Ä' -> '%%C3%%84';
    'Å' -> '%%C3%%85';
    'Æ' -> '%%C3%%86';
    'Ç' -> '%%C3%%87';
    'È' -> '%%C3%%88';
    'É' -> '%%C3%%89';
    'Ê' -> '%%C3%%8A';
    'Ë' -> '%%C3%%8B';
    'Ì' -> '%%C3%%8C';
    'Í' -> '%%C3%%8D';
    'Î' -> '%%C3%%8E';
    'Ï' -> '%%C3%%8F';
    'Ð' -> '%%C3%%90';
    'Ñ' -> '%%C3%%91';
    'Ò' -> '%%C3%%92';
    'Ó' -> '%%C3%%93';
    'Ô' -> '%%C3%%94';
    'Õ' -> '%%C3%%95';
    'Ö' -> '%%C3%%96';
    'Ø' -> '%%C3%%98';
    'Ù' -> '%%C3%%99';
    'Ú' -> '%%C3%%9A';
    'Û' -> '%%C3%%9B';
    'Ü' -> '%%C3%%9C';
    'Ý' -> '%%C3%%9D';
    'Þ' -> '%%C3%%9E';
    'ß' -> '%%C3%%9F';
    'à' -> '%%C3%%A0';
    'á' -> '%%C3%%A1';
    'â' -> '%%C3%%A2';
    'ã' -> '%%C3%%A3';
    'ä' -> '%%C3%%A4';
    'å' -> '%%C3%%A5';
    'æ' -> '%%C3%%A6';
    'ç' -> '%%C3%%A7';
    'è' -> '%%C3%%A8';
    'é' -> '%%C3%%A9';
    'ê' -> '%%C3%%AA';
    'ë' -> '%%C3%%AB';
    'ì' -> '%%C3%%AC';
    'í' -> '%%C3%%AD';
    'î' -> '%%C3%%AE';
    'ï' -> '%%C3%%AF';
    'ð' -> '%%C3%%B0';
    'ñ' -> '%%C3%%B1';
    'ò' -> '%%C3%%B2';
    'ó' -> '%%C3%%B3';
    'ô' -> '%%C3%%B4';
    'õ' -> '%%C3%%B5';
    'ö' -> '%%C3%%B6';
    '÷' -> '%%C3%%B7';
    'ø' -> '%%C3%%B8';
    'ù' -> '%%C3%%B9';
    'ú' -> '%%C3%%BA';
    'û' -> '%%C3%%BB';
    'ü' -> '%%C3%%BC';
    'ý' -> '%%C3%%BD';
    'þ' -> '%%C3%%BE';
    'ÿ' -> '%%C3%%BF';
    default -> none;
end table;

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

    define encode4url(string) -> encoded_string
        """ Format a string with HTML encoding. """

        encoded_string:= "";
        all_chars:= regex.extractAll(string, regex ".");
        for char in all_chars do
            special:= url_encoding[char];
            if special then
                encoded_string:= encoded_string + special;
            else
                encoded_string:= encoded_string + char;
            end if;
        end for;

        return encoded_string;

    end define;

    define parameters(params) -> param_string
        """ Generate a URL parameter string. """
        
        i:= 0;
        param_string:= "";
        
        for param in params do
            k:= param;
            v:= params[k];
            if datatype(v) = "text" then
                v:= encode4url(v);
            end if;
            if i = 0 then
                param_string:= "?%k%=%v%";
            else
                param_string:= param_string + "&%k%=%v%";
            end if;
            i:=i+1;
        end for;

        return param_string;

    end define;
    
    define get(datasource, endpoint, headers:=none, params:=none, version:=none) -> get_result
		""" Run a GET api call. """

        if not version then
            version_result, version:= api_version(datasource);
        end if;

        path:= "/api/v%version%" + endpoint;
        if params then
            path:= path + params;
        end if;

        if headers and datatype(headers) = "table" then
            get_result:= discovery.restfulGet(datasource, "oauth2", path, headers);
        else
            get_result:= discovery.restfulGet(datasource, "oauth2", path);
        end if;
		
        return get_result;

    end define;

    define post(datasource, endpoint, table, headers:=none, params:=none, version:=none) -> post_result
		""" Run a POST api call. """

        if not version then
            version_result, version:= api_version(datasource);
        end if;

        path:= "/api/v%version%" + endpoint;
        if params then
            path:= path + params;
        end if;
        data := json.encode(table);

        if headers and datatype(headers) = "table" then
            post_result:= discovery.restfulPost(datasource, "oauth2", path, data, headers);
        else
            post_result:= discovery.restfulPost(datasource, "oauth2", path, data);
        end if;
		
        return post_result;

    end define;

    define delete(datasource, endpoint, table:=none, headers:=none, version:=none) -> del_result
		""" Run a DELETE api call. """

        if not version then
            version_result, version:= api_version(datasource);
        end if;

        data:= none;
        path:= "/api/v%version%" + endpoint;
        if table and datatype(table) = "table" then
            data := json.encode(table);
        end if;

        if headers and datatype(headers) = "table" then
            if data then
                del_result:= discovery.restfulDelete(datasource, "oauth2", path, data, headers);
            else
                del_result:= discovery.restfulDelete(datasource, "oauth2", path, headers);
            end if;
        elif data then
            del_result:= discovery.restfulDelete(datasource, "oauth2", path, data);
        else
            del_result:= discovery.restfulDelete(datasource, "oauth2", path);
        end if;
		
        return del_result;

    end define;

    define patch(datasource, endpoint, table, headers:=none, version:=none) -> patch_result
		""" Run a PATCH api call. """

        if not version then
            version_result, version:= api_version(datasource);
        end if;

        path:= "/api/v%version%" + endpoint;
        data := json.encode(table);

        if headers and datatype(headers) = "table" then
            patch_result:= discovery.restfulPatch(datasource, "oauth2", path, headers, data);
        else
            patch_result:= discovery.restfulPatch(datasource, "oauth2", path, data);
        end if;
		
        return patch_result;

    end define;

    define put(datasource, endpoint, table, headers:=none, version:=none) -> put_result
		""" Run a PUT api call. """

        if not version then
            version_result, version:= api_version(datasource);
        end if;

        path:= "/api/v%version%" + endpoint;
        data := json.encode(table);

        if headers and datatype(headers) = "table" then
            put_result:= discovery.restfulPatch(datasource, "oauth2", path, headers, data);
        else
            put_result:= discovery.restfulPatch(datasource, "oauth2", path, data);
        end if;
		
        return put_result;

    end define;

    define about(datasource) -> about_info
		""" Return API info. """
		about_info:= self.get(datasource, "/about");
        return about_info;
    end define;

    define swagger(datasource) -> swagger_info
		""" Return Swagger info. """
		swagger_info:= self.get(datasource, "/swagger.json");
        return swagger_info;
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



definitions twdata 1.0
    """
        Author: Wes Moskal-Fitzpatrick

        Data API calls.

        Change History:
        2022-07-26 | 1.0 | WMF | Created.

    """

    define search_query(datasource, query, offset:=none, format:=none, results_id:=none, limit:=none, delete:=false) -> results
		'''Run a search query.'''
        path:= "/data/search";
        data:= table();
        data['query'] := query;
        params:= table();
        if offset then
            params['offset'] := offset;
        end if;
        if format then
            params['format'] := format;
        end if;
        if results_id then
            params['results_id'] := results_id;
        end if;
        if delete then
            params['delete'] := delete;
        end if;
        if limit then
            params['limit'] := limit;
        end if;
        param_string:= self.parameters(params);
        results := self.post(datasource, path, data, params:= param_string);
        return results;
    end define;

    define search_condition(datasource, query, offset:=none, format:=none, results_id:=none, limit:=none, delete:=false) -> results
		'''Search using a condition, retrieving tabular data as arrays.'''
        path:= "/data/condition";
        data:= table();
        data['query'] := query;
        params:= table();
        if offset then
            params['offset'] := offset;
        end if;
        if format then
            params['format'] := format;
        end if;
        if results_id then
            params['results_id'] := results_id;
        end if;
        if delete then
            params['delete'] := delete;
        end if;
        if limit then
            params['limit'] := limit;
        end if;
        param_string:= self.parameters(params);
        results := self.post(datasource, path, data, params:= param_string);
        return results;
    end define;

    define search_param_values(datasource, query) -> results
		'''Get possible parameter values for a condition.'''
        path:= "/data/condition/param_values";
        data:= table();
        data['query'] := query;
        results := self.post(datasource, path, data);
        return results;
    end define;

    define search_templates(datasource, template_id:=none) -> results
		'''Get a list of all templates.'''
        path:= "/data/condition/templates";
        if template_id then
            path:= "/vault/credentials/%template_id%";
        end if;
        results := self.get(datasource, path);
        return results;
    end define;

    define best_candidate(datasource, query) -> results
		'''Get a list of all templates.'''
        path:= "/data/candidate";
        data:= table();
        data['query'] := query;
        results := self.post(datasource, path, data);
        return results;
    end define;

    define top_candidates(datasource, query) -> results
		'''Get a list of all templates.'''
        path:= "/data/candidates";
        data:= table();
        data['query'] := query;
        results := self.post(datasource, path, data);
        return results;
    end define;

    define search_nodes(datasource, node_id, relationships:=none, traversal:=none, flag:=none, attributes:=none, graph:= false, focus:=none, apply_rules:=none, complete:= none) -> results
		'''Get node details with specified id.'''
        path:= "/data/nodes/%node_id%";
        params:= table();
        if graph then
            path:= "/data/nodes/%node_id%/graph";
            if focus then
                params['focus'] := focus;
            end if;
            if apply_rules then
                params['apply_rules'] := apply_rules;
            end if;
            if complete then
                params['complete'] := complete;
            end if;
        else
            if relationships then
                params['relationships'] := relationships;
            end if;
            if traversal then
                params['traverse'] := traversal;
            end if;
            if flag then
                params['flags'] := flag;
            end if;
            if attributes then
                params['attributes'] := attributes;
            end if;
        end if;
        param_string:= self.parameters(params);
        results := self.get(datasource, path, params:= param_string);
        return results;
    end define;

    define search_kinds(datasource, kind, offset:=none, format:=none, results_id:=none, limit:=none, delete:=false) -> results
		'''Find all nodes of a specified node kind.'''
        path:= "/data/kinds/%kind%";
        params:= table();
        if offset then
            params['offset'] := offset;
        end if;
        if format then
            params['format'] := format;
        end if;
        if results_id then
            params['results_id'] := results_id;
        end if;
        if delete then
            params['delete'] := delete;
        end if;
        if limit then
            params['limit'] := limit;
        end if;
        param_string:= self.parameters(params);
        results := self.get(datasource, path, params:= param_string);
        return results;
    end define;

    define partitions(datasource, new:=none) -> parts
		'''Get names and ids of partitions or create a new partition.'''
        path:= "/data/partitions";
        if new then
            parts := self.post(datasource, path, new);
        else
            parts := self.get(datasource, path);
        end if;
        return parts;
    end define;

    define upload(datasource, data) -> imported
		'''Imports data. Returns the import UUID.'''
        path:= "/data/import";
        imported := self.post(datasource, path, data);
        return imported;
    end define;

    define write(datasource, data) -> written
		'''Perform arbitrary write operations.'''
        path:= "/data/write";
        written := self.post(datasource, path, data);
        return written;
    end define;

    define graph(datasource, node_id, focus:=none, apply_rules:=none, complete:=none) -> results
		'''Retrieve graph data associated to the given node.'''
        path:= "/data/nodes/%node_id%/graph";
        params:= table();
        if focus then
            params['focus'] := focus;
        end if;
        if apply_rules then
            params['apply_rules'] := apply_rules;
        end if;
        if complete then
            params['complete'] := complete;
        end if;
        param_string:= self.parameters(params);
        results := self.get(datasource, path, params:= param_string);
    end define;

end definitions;



definitions twdiscovery 1.0
    """
        Author: Wes Moskal-Fitzpatrick

        Discovery API calls.

        Change History:
        2022-07-27 | 1.0 | WMF | Created.

    """

    define status(datasource) -> result
		'''Get the current status of the discovery process.'''
        path:= "/discovery";
        result := self.get(datasource, path);
        return result;
    end define;

    define scanning(datasource,data) -> result
		'''Set the Discovery status.'''
        path:= "/discovery";
        result := self.post(datasource, path, data);
        return result;
    end define;

    define api_metadata(datasource) -> result
		'''Get metadata for the API providers currently supported by BMC Discovery.'''
        path:= "/discovery/api_provider_metadata";
        result := self.get(datasource, path);
        return result;
    end define;

    define cloud_metadata(datasource) -> result
		'''Get metadata for the cloud providers currently supported by BMC Discovery.'''
        path:= "/discovery/cloud_metadata";
        result := self.get(datasource, path);
        return result;
    end define;

    define excludes(datasource, exclude_id:=none) -> result
		'''Get a list of all excludes or specific.'''
        path:= "/discovery/excludes";
        if exclude_id then
            path:= "/discovery/excludes/%exclude_id%";
        end if;
        result := self.get(datasource, path);
        return result;
    end define;

    define add_exclude(datasource, data) -> exclude
		'''Get a list of all excludes or specific.'''
        path:= "/discovery/excludes";
        exclude := self.post(datasource, path, data);
        return exclude;
    end define;

    define del_exclude(datasource, exclude_id) -> exclude
		'''Delete a specific exclude.'''
        path:= "/discovery/excludes/%exclude_id%";
        exclude := self.delete(datasource, path);
        return exclude;
    end define;

    define patch_exclude(datasource, exclude_id, data) -> exclude
		'''Update an exclude.'''
        path:= "/discovery/excludes/%exclude_id%";
        exclude := self.patch(datasource, path, data);
        return exclude;
    end define;

    define runs(datasource, run_id:=none) -> result
		'''Get details of all or specific currently processing discovery runs.'''
        path:= "/discovery/runs";
        if run_id then
            path:= "/discovery/runs/%run_id%";
        end if;
        result := self.get(datasource, path);
        return result;
    end define;

    define add_run(datasource, data) -> run
		'''Create a new snapshot discovery run.'''
        path:= "/discovery/runs";
        run := self.post(datasource, path, data);
        return run;
    end define;

    define patch_run(datasource, run_id, data) -> run
		'''Update the state of a specific discovery run.'''
        path:= "/discovery/excludes/%run_id%";
        run := self.patch(datasource, path, data);
        return run;
    end define;

    define run_results(datasource, run_id, result:=none, inferred_kind:=none, offset:=none, results_id:=none, format:=none, limit:=none, delete:=none) -> run_result
		'''Get a summary of the results from scanning all endpoints in the run that had a specific type of result.'''
        path:= "/discovery/runs/%run_id%/results";
        if result then
            path:= "/discovery/runs/%run_id%/results/%result%";
        end if;
        params:= table();
        if offset then
            params['offset'] := offset;
        end if;
        if format then
            params['format'] := format;
        end if;
        if results_id then
            params['results_id'] := results_id;
        end if;
        if delete then
            params['delete'] := delete;
        end if;
        if limit then
            params['limit'] := limit;
        end if;
        param_string:= self.parameters(params);
        results := self.get(datasource, path, params:= param_string);
        return run_result;
    end define;

    define inferred_results(datasource, run_id, inferred_kind:=none, inferred_kind:=none, offset:=none, results_id:=none, format:=none, limit:=none, delete:=none) -> run_result
		'''Get a summary of the devices inferred by a discovery run which have a specific inferred kind.'''
        path:= "/discovery/runs/%run_id%/inferred";
        if inferred_kind then
            path:= "/discovery/runs/%run_id%/inferred/%inferred_kind%";
        end if;
        params:= table();
        if offset then
            params['offset'] := offset;
        end if;
        if format then
            params['format'] := format;
        end if;
        if results_id then
            params['results_id'] := results_id;
        end if;
        if delete then
            params['delete'] := delete;
        end if;
        if limit then
            params['limit'] := limit;
        end if;
        param_string:= self.parameters(params);
        results := self.get(datasource, path, params:= param_string);
        return run_result;
    end define;

    define schedules(datasource, run_id:=none) -> schedule
		'''Get a list of all scheduled runs or specific.'''
        path:= "/discovery/runs/scheduled";
        if run_id then
            path:= "/discovery/runs/scheduled/%run_id%";
        end if;
        schedule := self.get(datasource, path);
        return schedule;
    end define;

    define add_schedule(datasource, data) -> schedule
		'''Add a new scheduled run.'''
        path:= "/discovery/runs/scheduled";
        schedule := self.post(datasource, path, data);
        return schedule;
    end define;

    define del_schedule(datasource, run_id) -> schedule
		'''Delete a specific scheduled discovery run.'''
        path:= "/discovery/scheduled/%run_id%";
        schedule := self.delete(datasource, path);
        return schedule;
    end define;

    define patch_schedule(datasource, run_id, data) -> schedule
		'''Update the parameters of a specific scheduled discovery run.'''
        path:= "/discovery/excludes/%run_id%";
        schedule := self.patch(datasource, path, data);
        return schedule;
    end define;

end definitions;



definitions twknowledge 1.0
    """
        Author: Wes Moskal-Fitzpatrick

        Knowledge API calls.

        Change History:
        2022-07-27 | 1.0 | WMF | Created.

    """

    define status(datasource) -> know_status
		'''Get the current state of the appliance's knowledge, including TKU versions.'''
        path:= "/knowledge";
        know_status := self.get(datasource, path);
        return know_status;
    end define;

    define upload_status(datasource) -> know_status
		'''Get the current state of a knowledge upload.'''
        path:= "/knowledge/status";
        know_status := self.get(datasource, path);
        return know_status;
    end define;

end definitions;

definitions twevents 1.0
    """
        Author: Wes Moskal-Fitzpatrick

        Events API calls.

        Change History:
        2022-07-27 | 1.0 | WMF | Created.

    """

    define events(datasource, data) -> event
		'''Returns a unique ID if the event has been recorded, otherwise an
            empty string is returned e.g. if the event source has been disabled.'''
        path:= "/events";
        event := self.post(datasource, path, data);
        return event;
    end define;

end definitions;



definitions twmodels 1.0
    """
        Author: Wes Moskal-Fitzpatrick

        Models API calls.

        Change History:
        2022-07-28 | 1.0 | WMF | Created.

    """

    define get_models(datasource, name:=none, type:=none, kind:=none, published:=none, review_suggested:=none, version:=none, favorite:=none, compatibility:=none, results_id:=none, delete:=none) -> results
		'''Get model definitions.'''
        path:= "/models";
        params:= table();
        if name then
            params['name'] := name;
        if focus then
            params['focus'] := focus;
        end if;
        if type then
            params['type'] := type;
        end if;
        if kind then
            params['kind'] := kind;
        end if;
        if published then
            params['published'] := published;
        end if;
        if review_suggested then
            params['review_suggested'] := review_suggested;
        end if;
        if version then
            params['version'] := version;
        end if;
        if favorite then
            params['favorite'] := favorite;
        end if;
        if compatibility then
            params['compatibility'] := compatibility;
        end if;
        if results_id then
            params['results_id'] := results_id;
        end if;
        if delete then
            params['delete'] := delete;
        end if;
        param_string:= self.parameters(params);
        results := self.get(datasource, path, params:= param_string);
        return results;
    end define;

    define get_model(datasource, key) -> result
		'''Get model definition for the specified key.'''
        path:= "/models/%key%";
        result := self.get(datasource, path);
        return result;
    end define;

    define new_model(datasource, data) -> result
		'''Create a new model.'''
        path:= "/models";
        result := self.post(datasource, path, data);
        return result;
    end define;

    define multi(datasource, data) -> result
		'''Manipulate multiple models in a single request.'''
        path:= "/models/multi";
        result := self.post(datasource, path, data);
        return result;
    end define;

    define remove_model(datasource, key) -> result
		'''Delete a model.'''
        path:= "/models/%key%";
        result := self.delete(datasource, path);
        return result;
    end define;

    define patch_model(datasource, key, data) -> result
		'''Modify a model.'''
        path:= "/models/%key%";
        result := self.patch(datasource, path, data);
        return result;
    end define;

    define model_topology(datasource, key, attributes:=none) -> result
		'''Get topology for the model definition specified by key.'''
        path:= "/models/%key%/topology";
        params:= table();
        if attributes then
            params['attributes'] := attributes;
        end if;
        param_string:= self.parameters(params);
        result := self.get(datasource, path, params:=param_string);
        return result;
    end define;

    define model_nodes(datasource, key, kind:=none, format:=none, limit:=none, results_id:=none, delete:=none) -> results
		'''Get nodes for the model definition specified by key.'''
        path:= "/models/%key%/nodes";
        params:= table();
        if kind then
            path:= "/models/%key%/nodes/%kind%";
        end if;
        if format then
            params['format'] := format;
        end if;
        if limit then
            params['limit'] := limit;
        end if;
        if results_id then
            params['results_id'] := results_id;
        end if;
        if delete then
            params['delete'] := delete;
        end if;
        param_string:= self.parameters(params);
        results := self.get(datasource, path, params:= param_string);
        return results;
    end define;

    define model_node_id(datasource, node_id, expand_related:=none, delete:=none) -> result
		'''Get/delete model definition for the specified node id.'''
        path:= "/models/by_node_id/%node_id%";
        params:= table();
        if expand_related then
            params['expand_related'] := expand_related;
        end if;
        if delete then
            result := self.delete(datasource, path);
        else
            param_string:= self.parameters(params);
            result := self.get(datasource, path, params:= param_string);
        end if;
        return result;
    end define;

    define patch_model_node_id(datasource, node_id, data) -> result
		'''Modify a model by node id.'''
        path:= "/models/by_node_id/%node_id%";
        result := self.patch(datasource, path, data);
        return result;
    end define;

    define topology_node_id(datasource, node_id, attributes:=none) -> result
		'''Get topology for the model definition specified by node id.'''
        path:= "/models/by_node_id/%node_id%/topology";
        params:= table();
        if attributes then
            params['attributes'] := attributes;
        end if;
        param_string:= self.parameters(params);
        result := self.get(datasource, path, params:=param_string);
        return result;
    end define;

    define nodecount_by_id(datasource, node_id) -> result
		'''Get node count for the model definition specified by node id.'''
        path:= "/models/by_node_id/%node_id%/nodecount";
        result := self.get(datasource, path);
        return result;
    end define;

    define nodes_by_id(datasource, node_id, kind:=none, format:=none, limit:=none, results_id:=none, delete:=none) -> results
		'''Get nodes for the model definition specified by node id.'''
        path:= "/models/by_node_id/%node_id%";
        params:= table();
        if kind then
            path:= "/models/by_node_id/%node_id%/%kind%";
        end if;
        if format then
            params['format'] := format;
        end if;
        if limit then
            params['limit'] := limit;
        end if;
        if results_id then
            params['results_id'] := results_id;
        end if;
        if delete then
            params['delete'] := delete;
        end if;
        param_string:= self.parameters(params);
        results := self.get(datasource, path, params:= param_string);
        return results;
    end define;

end definitions;



definitions twtaxonomy 1.0
    """
        Author: Wes Moskal-Fitzpatrick

        Taxonomy API calls.

        Change History:
        2022-07-28 | 1.0 | WMF | Created.

    """

    define sections(datasource) -> results
		'''Get list of taxonomy model sections.'''
        path:= "/taxonomy/sections";
        results := self.get(datasource, path);
        return results;
    end define;

    define locales(datasource) -> results
		'''Get list of known taxonomy locales.'''
        path:= "/taxonomy/locales";
        results := self.get(datasource, path);
        return results;
    end define;

    define nodekinds(datasource, format:=none, section:=none, locale:=none, kind:=none, fieldlists:=none) -> results
		'''Get list of defined node kinds with kind info.'''
        path:= "/taxonomy/nodekinds";
        params:= table();
        if format then
            params['format'] := format;
            params['section'] := section;
            params['locale'] := locale;
        elif kind then
            params['locale'] := locale;
            path:= "/taxonomy/nodekinds/%kind%";
            if fieldlists then
                path:= "/taxonomy/nodekinds/%kind%/fieldlists";
            end if;
        end if;
        param_string:= self.parameters(params);
        results := self.get(datasource, path, params:= param_string);
        return results;
    end define;

    define relkinds(datasource, format:=none, locale:=none, kind:=none) -> results
		'''Get list of defined node kinds with kind info.'''
        path:= "/taxonomy/relkinds";
        params:= table();
        if format then
            params['format'] := format;
            params['locale'] := locale;
        elif kind then
            params['locale'] := locale;
            path:= "/taxonomy/relkinds/%kind%";
        end if;
        param_string:= self.parameters(params);
        results := self.get(datasource, path, params:= param_string);
        return results;
    end define;

end definitions;



definitions twtopology 1.0
    """
        Author: Wes Moskal-Fitzpatrick

        Topology API calls.

        Change History:
        2022-07-28 | 1.0 | WMF | Created.

    """

    define nodes(datasource, data) -> results
		'''Get topology data from one or more starting nodes.'''
        path:= "/topology/nodes";
        results := self.post(datasource, path, data);
        return results;
    end define;

    define nodekinds(datasource, data) -> results
		'''Get nodes of the specified kinds which are related to a given set of nodes.'''
        path:= "/topology/nodes/kinds";
        results := self.post(datasource, path, data);
        return results;
    end define;

    define visualisation(datasource) -> results
		'''Get the current state of the visualization for the authenticated user.'''
        path:= "/topology/visualization_state";
        results := self.get(datasource, path);
        return results;
    end define;

    define patch_visualisation(datasource, data) -> results
		'''Update one or more attributes of the current state of the visualization for the authenticated user.'''
        path:= "/topology/visualization_state";
        results := self.patch(datasource, path, data);
        return results;
    end define;

    define replace_visualisation(datasource, data) -> results
		'''Update any or all of the attributes of the current state of the visualization for the authenticated user.'''
        path:= "/topology/visualization_state";
        results := self.put(datasource, path, data);
        return results;
    end define;

end definitions;



definitions twvault 1.0
    """
        Author: Wes Moskal-Fitzpatrick

        Vault API calls.

        Change History:
        2022-07-23 | 1.0 | WMF | Created.

    """

    define status(datasource) -> result
		'''Get details of the state of the vault.'''
        path:= "/vault";
        result := self.get(datasource, path);
        return result;
    end define;

    define patch_vault(datasource, data) -> result
		'''Get details of the state of the vault.'''
        path:= "/vault";
        result := self.post(datasource, path, data);
        return result;
    end define;

    define credential_types(datasource, type:=none, group:=none, category:=none) -> types
		'''Get a list of all credential types and filter by group and/or category.'''
        path:= "/vault/credential_types";
        params:= table();
        if group then
            params['group'] := group;
        end if;
        if category then
            params['category'] := category;
        end if;
        param_string:= self.parameters(params);
        if type then
            path:= "/vault/credential_types/%type%";
        end if;
        types := self.get(datasource, path, params:= param_string);
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

    define new_credential(datasource, data) -> result
		'''Create a new credential.'''
        path:= "/vault/credentials";
        result := self.post(datasource, path, data);
        return result;
    end define;

    define remove_credential(datasource, uuid) -> result
		'''Remove a credential.'''
        path:= "/vault/credentials/%uuid%";
        result := self.delete(datasource, path);
        return result;
    end define;

    define patch_credential(datasource, uuid, data) -> result
		'''Patch a credential.'''
        path:= "/vault/credentials/%uuid%";
        result := self.patch(datasource, path, data);
        return result;
    end define;

    define replace_credential(datasource, uuid, data) -> result
		'''Replace new credential.'''
        path:= "/vault/credentials/%uuid%";
        result := self.patch(datasource, path, data);
        return result;
    end define;

    define realms(datasource, realm:=none) -> results
		'''Retrieve all or specific realm.'''
        path:= "/vault/kerberos/realms";
        if realm then
            path:= "/vault/kerberos/realms/%realm%";
        end if;
        results := self.get(datasource, path);
        return results;
    end define;

    define remove_realm(datasource, realm) -> result
		'''Delete a realm.'''
        path:= "/vault/kerberos/realms/%realm%";
        result := self.delete(datasource, path);
        return result;
    end define;

    define new_realm(datasource, name, data, test:=none) -> result
		'''Create a realm and Test user credentials by attempting to acquire a new Kerberos Ticket Granting Ticket (TGT).'''
        path:= "/vault/kerberos/realms/%name%";
        if test then
            path:= "/vault/kerberos/realms/%name%/test";
        end if;
        result := self.post(datasource, path, data);
        return result;
    end define;

    define patch_realm(datasource, realm, data) -> result
		'''Update a Kerberos realm.'''
        path:= "/vault/kerberos/realms/%realm%";
        result := self.patch(datasource, path, data);
        return result;
    end define;

    define keytabs(datasource, realm) -> results
		'''List users with a Kerberos keytab file.'''
        path:= "/vault/kerberos/realms/%realm%/keytabs";
        results := self.get(datasource, path);
        return results;
    end define;

    define remove_keytab(datasource, realm, username) -> result
		'''Delete a keytab file.'''
        path:= "/vault/kerberos/realms/%realm%/keytabs/%username%";
        result := self.delete(datasource, path);
        return result;
    end define;

    define caches(datasource, realm) -> results
		'''List users with a Kerberos credential cache file.'''
        path:= "/vault/kerberos/realms/%realm%/ccaches";
        results := self.get(datasource, path);
        return results;
    end define;

    define remove_cache(datasource, realm, username) -> result
		'''Delete a cedential cache file.'''
        path:= "/vault/kerberos/realms/%realm%/ccaches/%username%";
        result := self.delete(datasource, path);
        return result;
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

        // Basic Oauth
        log.debug("Getting DS");
        ds:= discovery.dataSource('Disco Oauth');

        //log.debug("Getting search results");
        //results:= twdata.search_query(ds,"search Host", limit:=50, format:="object");
        //self.debug(results);

        //log.debug("Getting node details");
        //results:= twdata.search_nodes(ds,"30c577625e064d10300bfc686e536f667477617265496e7374616e6365");
        //self.debug(results);

        //log.debug("Getting SI kind");
        //results:= twdata.search_kinds(ds,"SoftwareInstance");
        //self.debug(results);

        // Credentials
        //log.debug("Running credential types query");
        //credential_types:= twvault.credential_types(ds,category:="Host Credentials");
        //self.debug(credential_types);

        //log.debug("Running credentials query");
        //credentials:= twvault.credentials(ds,uuid:="");
        //self.debug(credentials);

        //log.debug("Post new credential");
        //payload:= table();
        // payload["enabled"]:= true;
        // payload["username"]:= "discovery_service";
        // payload["password"]:="password";
        // payload["label"]:= "Generic SSH Service Account";
        // payload["description"]:= "Service Account for SSH";
        // payload["ip_range"]:="0.0.0.0/0,::/0";
        // payload["types"]:= ["ssh"];
        // new_cred:= twvault.new_credential(ds,payload);
        // self.debug(new_cred);

        //log.debug("Remove credential");
        //remove_cred:= twvault.remove_credential(ds,"df99a13aef024289872cc0a801630e89");
        //self.debug(remove_cred);

        //log.debug("Update credential");
        //payload:= table();
        //payload["enabled"]:= false;
        //update_cred:= twvault.patch_credential(ds,"df99a13aef024289872cc0a801630e89",payload);
        //self.debug(update_cred);

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