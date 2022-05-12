## Get all .wav and mp3 files
function FenterRecording ()
  [fileName,file_in_path] = uigetfile({'*.wav';'*.mp3'}); 
  
  if isequal(fileName,0)
       disp("You cancelled")
  else
       cd(file_in_path) 
       [y,Fs] = audioread(fileName);
       Fs
       ## Get Recording's data
       dbSampleData = GetDBlevel(y,Fs);
  
       ##plot db/sec diagram
        dt = 1/Fs;
        xlabel('Seconds'); 
        ylabel ('Decibel');
        ty = 0:dt:(length(y)*dt)-dt;
        t = 0:dt:(length(dbSampleData)*dt)-dt;
        plot(t,dbSampleData);
        newAr = [nonzeros(y),t']; ##create an array of y values,without 0s
        dbLimit = 48; ## Decibel limit
        NoiseSounds(dbSampleData,newAr,dbLimit,fileName,Fs);     
 endif
endfunction
        
 
