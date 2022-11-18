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
  verify "Location header is correct" "https://polaris.int.cps.gov.uk/init?cookie=foo%26bar%3d2&referer=bar&foo" eq {HTTP::header Location}
  run polaris_irule.tcl polaris
}
