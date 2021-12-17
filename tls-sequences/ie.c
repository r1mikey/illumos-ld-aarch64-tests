extern __thread char tls_var;
char* get_addr() { return &tls_var; }
