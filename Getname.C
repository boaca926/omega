const int NbTree = 10, NbVar = 3;

TString gettreename(Int_t index) {
	TString myArr[NbTree] = {"OMEGAPI","KPM","KSL","THREEPIGAM", "THREEPI", "ETAGAM", "BKGSUM1", "BKGSUM2", "MCSUM", "ALLCHAIN"}; 
	
	TString st = myArr[index]; 
	return st;
}

TString getbraname(Int_t index) {
	TString myArr[NbVar] = {"mctype","IMthreepi","Eisr"}; 
	
	TString st = myArr[index]; 
	return st;
}


void Getname() {
	TString a = gettreename(0);
	//std::cout<<a<<endl; 
	
	
}

