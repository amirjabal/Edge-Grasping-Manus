

Gdirtt = Gdir ; 
Idtt = Id ; 
Idtt(Idtt==0)=nan;

Gdirtt = Gdirtt+180 ; 
Gdirtt = Gdirtt/(max(max(Gdirtt))-min(min(Gdirtt))) ;
Idtt = Idtt/(max(max(Idtt))-min(min(Idtt))) ;
Idtt = Idtt - min(min(Idtt)) ; 


I_sum = Idtt+Gdirtt ; 