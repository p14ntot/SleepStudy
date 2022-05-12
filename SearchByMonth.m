
function SearchByMonth()
  mon = input("Pick a month(1-12)");## Input the number of the month
  while   (!isinteger(mon) &&  ( mon<1 || mon>12)) ## check the correct value
      disp("Enter a number (1-12) that corresponds to a month")
      mon = input("Pick a month(1-12)"); 
  endwhile
  switch mon ## One case for each number
   case 1
      monStr = "Jan"
   case 2
      monStr = "Feb"
   case 3
      monStr = "Mar"
   case 4
      monStr = "Apr"
   case 5
      monStr = "May"
   case 6
      monStr = "Jun"
   case 7
      monStr = "Jul"
   case 8
      monStr = "Aug"
   case 9
      monStr = "Sep"
   case 10
      monStr = "Oct"
   case 11
      monStr = "Nov"
   case 12
      monStr = "Dec"
  end
  cd("Recordings") ##Change directory
  
  if exist(monStr,'dir') ## Check if the month dir exist
    cd(monStr)
    files = dir ("*.wav");
    disp(strcat("All Recordings In ",monStr));
    for i=1:length(files)
      disp(files(i).name);## Display all the wav files of the month
    endfor
  else
     cd ..
     disp(strcat("No recordings Found on",monStr)) ## Message for no recordings
  endif
    
##  Categorise By Week
    listByWeek = input("Do you want a list per week?(Y)",'s');
    week1 = [];
    week2 = [];
    week3 = [];
    week4 = [];
    week5 = [];
    if listByWeek == "Y"
      for i=1:length(files)
        if day(files(i).date)>=1 && day(files(i).date) <=7 ##check for the first 7 days
          week1 = [week1;files(i)];
        elseif day(files(i).date)>=8 && day(files(i).date) <=14 ## check for the days 8-14
          week2 = [week2;files(i)];
        elseif day(files(i).date)>=15 && day(files(i).date) <=21 ## check for the days 15-21
          week3= [week3;files(i)];
        elseif day(files(i).date)>=22 && day(files(i).date) <=29 ## check for the days 22-29
          week4 = [week4;files(i)];
        else
          week5 = [week5;files(i)]; # check for the last week
        endif
      endfor
      week = input("Choose a week(1-5)"); # Ask for week
      while   (!isinteger(week) &&  ( week<1 || week>5))
        disp("Enter a number (1-5) that corresponds to a week")
        week = input("Choose a week(1-5)"); 
      endwhile
      switch week
        case 1
          if isempty(week1)
            disp("No Recordings");# check if week 1 is empty
          else
            for j=1:length(week1)
            disp(week1(j).name); # Display the names of all week 1 files
            endfor  
          endif
        case 2
          if isempty(week2)
            disp("No Recordings");
          else
            for j=1:length(week2)
              disp(week2(j).name);
            endfor
          endif
        case 3
          if isempty(week3)
          disp("No Recordings");
          else
            for j=1:length(week3)
            disp(week3(j).name);
            endfor
          endif
        case 4
          if isempty(week4)
            disp("No Recordings");
          else
            for j=1:length(week4)
            disp(week4(j).name);
            endfor
          endif      
        case 5
          if isempty(week5)
              disp("No Recordings");
           else
              for j=1:length(week5)
              disp(week5(j).name);
              endfor
          endif   
      endswitch
    endif
endfunction
