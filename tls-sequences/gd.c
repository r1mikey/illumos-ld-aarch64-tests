extern __thread char tls_var;
char* get_tls_var() {
  return &tls_var;
}
