rule polaris {
  when HTTP_REQUEST {
    if { [HTTP::uri] eq "/polaris" } {
      HTTP::redirect [format "https://polaris.int.cps.gov.uk/init?cookie=%s&referer=%s" [URI::encode [HTTP::header "cookie"]] [HTTP::header "referer"]]
    }
  }
}