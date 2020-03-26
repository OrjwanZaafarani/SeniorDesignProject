function [destination] = keywordCheck(text)
    keywords = ["restroom" "office" "cafeteria" "elevator" "toilet" "bathroom" "washroom" "lavatory" "wc" "kitchen"];
    for i=1:numel(keywords)
        search = strfind(text,keywords(i));
        if numel(search)>0
            found = 1;
            index = i;
            break
        else
            found = 0;
        end
    end
    if found
        switch keywords(index)
            case {"restroom","bathroom","toilet","washroom","lavatory","wc"}
                destination = "restroom";
            otherwise
                destination = keywords(index);
        end
    else
        destination = "not detected";
    end
end