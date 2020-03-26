function [textString] = speechRecognition(audio_file)
%   Returns the sampled data and the sample rate FS, in Hertz
    [samples, fs] = audioread(audio_file);
    y = samples(:,1);
    
%   Creates a speechClient object to interface with Google's cloud-based speech API
    speechObject = speechClient('Google','languageCode','en-US'); 
    
%   Returns a table that contains the transcription and confidence metrics.
    tableOut = speech2text(speechObject, y, fs);
    textArray = table2array(tableOut(:,1));

%   Concatenates the trascription array (textArray) into one string (textString)
    textdefault = '';
    for i=1:numel(textArray)
        textString = strcat(textdefault,textArray(i));
        textdefault = textString;
    end
end

