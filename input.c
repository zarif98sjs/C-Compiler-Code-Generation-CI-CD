int main(){
 
	int i,j,k,l,m,n,o,p;
 
	i = 1;
	println(i);
	j = 5 + 8;
	println(j);
	k = i + 2*j;
	println(k);
	l = k/3;
	println(l);
	m = k%9;
	println(m);
 
	n = m <= l;
	println(n);
 
	o = i != j;
	println(o);
 
	p = n || o;
	println(p);
 
	p = n && o;
	println(p);
	
	p++;
	println(p);
 
	k = -p;
	println(k);
 
  
 
 
	return 0;
}

