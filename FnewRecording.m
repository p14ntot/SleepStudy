function FnewRecording()
  
  ## Take a Recording
  ## FS=8000, bits=16, channel=1
  recObj = audiorecorder(8000,16,1);
  disp('Start speaking.')
  record (recObj)
  prompt = 'Press 1 if you want to stop recording';
  ##take input from user to stop recording
  answer = input(prompt);
  
 ## Check the valid of input
 if  ( answer ~= 1 )
    disp('Now you are recording.. You have to press the 1 button')
  else  
  
    stop (recObj)
    
  endif  
  ## Check valid again until input=1
  while (answer ~= 1 )  
    prompt = 'Press 1 if you want to stop recording ';
    answer = input(prompt)
  
    if  ( answer ~= 1 )
      disp('Now you are recording.. You have to press the 1 button')
    else  
  
      stop (recObj)
      
  endif
endwhile 

  ## Get the date from the pc
  recordingDate = date();
  
  ## Get Recording's data
  y = getaudiodata(recObj);
  Fs=8000;
  ## call getdblevel
  dbSampleData = GetDBlevel(y,Fs);
  
  ##plot db/sec diagram
  dt = 1/Fs; ## calculate time duration of each sample 
  xlabel('Seconds'); 
  ylabel ('Decibel');
  t = 0:dt:(length(dbSampleData)*dt)-dt;
  plot(t,dbSampleData);
  
  ## Find and cut and save Noisy sounds
  
     
  
  ##Save Recording and Categorize By Month 
  cd('Recordings')
  date = date();
  
  ##CategorizeByMonth
  [n,str]=month(date);
  ## Create the non-existing folder
  if ~exist(str,'dir')
       mkdir(str)
  endif
  cd(str)

  ##Save
  name = input("Input recording's Name ",'s');
  conc = strcat(name,".wav");
  audiowrite(conc,y,8000);
  
  ##GetNoisyRecordings
  getNoise = input("Do you want to find the Noisy sounds(Y)?",'s');
  if getNoise == "Y" 
       [y,Fs] = audioread(conc);
       cd ../..
       ## Get Recording's data/ Turn amplience to Decibel
       dbSampleData = GetDBlevel(y,Fs);
       ##plot db/sec diagram
          ## dt = time distance of each sample
          ## ty : time starts :0 ,step :dt, end:recording duration (for amplience)
         
        dt = 1/Fs;
        xlabel('Seconds'); 
        ylabel ('Decibel');
        ty = 0:dt:(length(y)*dt)-dt;
        t = 0:dt:(length(dbSampleData)*dt)-dt;
        plot(t,dbSampleData);
        
       ##Create  Recordings
        newAr = [nonzeros(y),t'];
        dbLimit = 48;
        cd "Recordings"
        cd (str)
        NoiseSounds(dbSampleData,newAr,dbLimit,conc,Fs);
  endif
  
endfunction