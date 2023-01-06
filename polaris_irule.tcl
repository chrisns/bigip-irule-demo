rule polaris {
  when HTTP_REQUEST {
    if { [HTTP::path] eq "/polaris" } {
      HTTP::header insert "Access-Control-Allow-Origin" "https://polaris.int.cps.gov.uk"
      HTTP::redirect [format "https://api.polaris.int.cps.gov.uk/init?cookie=%s&referer=%s&q=%s" [URI::encode [HTTP::header "cookie"]] [URI::encode [HTTP::header "referer"]] [URI::query [HTTP::uri] "q"]]
    }
  }
}