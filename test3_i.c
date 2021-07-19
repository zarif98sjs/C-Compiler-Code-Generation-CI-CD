int main(){
 
	int i,j,k,l;
 
	for(i=0;i<6;i++){
		println(i);
	}
 
	k = 4;
	l = 6;
	while(k>0){
		l = l + 3;
		k--;
	}
 
	println(l);
	println(k);
	
	k = 4;
	l = 6;
	
	while(k--){
		l = l + 3;
	}
 
	println(l);
	println(k);
 
 
	return 0;
}
