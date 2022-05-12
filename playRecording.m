

function playRecording ()
       cd("Recordings")
       [filename,fpath] = uigetfile({'*.wav';'*.mp3'});##get the files from recordings folder
       if filename != 0 
           c = strsplit(fpath,'\');
           cd (c{7})
           [y,Fs] = audioread(filename);
           player = audioplayer(y,Fs);##play the recording
           play(player);
           getInfo = input ("Do you wanna see recording's Duration(Y)?",'s');##shows the duration of the recording
           if getInfo == "Y"
             info = audioinfo(filename);
             disp(info.Duration);
           endif
        endif         
endfunction
