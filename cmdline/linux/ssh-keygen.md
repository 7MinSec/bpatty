# ssh-keygen
Generates RSA/DSA keys:
 
    ssh-keygen -t rsa -b 2048
 
Then, to copy it to your target's authorized_keys list:
 
    cat id_rsa.pub | ssh username@f.q.d.n 'cat >> ~/.ssh/authorized_keys'
 