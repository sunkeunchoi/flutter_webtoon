for id in 631842 536554 776835 884184 1026563 758009 713704 983768 502356 758323 804150 713704 785084 493529 916224 1016121 840326 931954 933419 848058 649609 447365 901563 830896 455476 955644 1047041 796185;do
curl -L https://movies-api.nomadcoders.workers.dev/movie?id=$id >> defatils.json; 
done;
