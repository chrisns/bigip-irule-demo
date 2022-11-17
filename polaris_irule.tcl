rule polaris {
  when HTTP_REQUEST {
    if { [HTTP::uri] starts_with "/polaris" } {
      HTTP::redirect "https://polaris.int.cps.gov.uk/init?cookie="[HTTP::header "cookie"]
    } 
  }
}

