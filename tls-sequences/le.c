__thread unsigned int tls_var;
unsigned int* get_addr() { return &tls_var; }
