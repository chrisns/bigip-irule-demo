package require testcl
namespace import ::testcl::*

log::lvSuppressLE info 0

before {
  event HTTP_REQUEST
}

it "not polaris events go unchanged" {
  HTTP::uri "/cannot_be_handled"
  
  verify "response status code is undefined" "" eq {HTTP::status}
  verify "Location header is undefined" "" eq {HTTP::header Location}
  run polaris_irule.tcl polaris
}

it "polaris requests to /polaris get redirected" {
  HTTP::uri "/polaris"
  HTTP::header insert Cookie "foo&bar=2"
  HTTP::header insert referer "bar&foo"
  verify "response status code is 302" 302 eq {HTTP::status}
  verify "Location header is correct" "https://api.polaris.int.cps.gov.uk/init?cookie=foo%26bar%3d2&referer=bar%26foo&q=" eq {HTTP::header Location}
  run polaris_irule.tcl polaris
}

it "polaris requests to /polaris q string gets added" {
  HTTP::uri "/polaris?q=fooa"
  verify "response status code is 302" 302 eq {HTTP::status}
  verify "Location header is correct" "https://api.polaris.int.cps.gov.uk/init?cookie=&referer=&q=fooa" eq {HTTP::header Location}
  run polaris_irule.tcl polaris
}

it "CORS is set to /polaris" {
  HTTP::uri "/polaris?q=fooa"
  verify "Location CORS is correct" "https://polaris.int.cps.gov.uk" eq {HTTP::header "Access-Control-Allow-Origin"}
  run polaris_irule.tcl polaris
}
