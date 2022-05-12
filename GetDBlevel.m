
function dbSampleData = GetDBlevel (y, Fs)
  ampl_ref = 0.00001;
  yabs = abs(y);
  ampl = yabs./ampl_ref;
  b = nonzeros(ampl);
  logsSampleData = log10(b);
  dbSampleData =20*logsSampleData;
endfunction
