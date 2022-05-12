
function NoiseSounds (dbSampleData,newAr,dbLimit,fileName,Fs)
        NoisySamples= [0,0];
        date = date();
        dt = 1/Fs;
        ##Create a matrix (y,t) where db>48     
        for i=1:rows(dbSampleData)
           if dbSampleData(i) > dbLimit
             NoisySamples = [NoisySamples;newAr(i,:)];
           endif     
        endfor
##      Create new noisy recordings if time difference is more than 1 sec
        if isempty(NoisySamples) 
          disp("No Noise Detected");
        else
          startI = 2;
          c=1; ## is a counter
          foo = false; ## this boolean helps to check if the whole recording is over the threshold
          for x=2:(rows(NoisySamples)-1)
            difdis=abs(NoisySamples(x,2)-NoisySamples(x+1,2)); ## calculate the time difference between 2 next rows
            threshold = Fs*dt;  ## threshold is 1 sec
            if difdis>threshold
              fileN=strcat(int2str(c),"_",fileName);
              foo = true;
              stopI = x; ## time when stoped the soisy recordings
              audiowrite(fileN,NoisySamples(startI:stopI,1),Fs); ## audioread the detected noisy samples
              startI=x+1;
              c++
            endif
          endfor
          if foo
            fileN=strcat(int2str(c),"_",fileName);
            audiowrite(fileN,NoisySamples(startI:end,1),Fs); ##audiowrite the last part of noisy samples
            ##audiowrites all the noisy samples in one file
            audiowrite(strcat("All_Noise_In_",fileName),NoisySamples(:,1),Fs);
            ##convert integer to string and display the number of recording
            disp(strcat(int2str(c++)," recordings detected"));
            
          else
            ##AudioWrite Only the Noise(recordings united)
            disp("One recording detected");
            audiowrite(strcat("All_Noise_In_",fileName),NoisySamples(:,1),Fs);
          endif
        endif
endfunction
