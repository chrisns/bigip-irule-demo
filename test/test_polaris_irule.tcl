package require testcl
namespace import ::testcl::*

log::lvSuppressLE info 0

it "not polaris events go unchanged" {
  event HTTP_REQUEST
  on HTTP::uri return "/bar"
  endstate HTTP::respond 404
  run polaris_irule.tcl polaris
}

# it "polaris requests to /polaris get redirected" {
#   event HTTP_REQUEST
#   on HTTP::uri return "/polaris"
#   verify "there should be only one Vary header" 1 == {HTTP::header count vary}
#   HTTP::header insert Cookie "foobar"
#   verify "response status code is 302" 302 eq {HTTP::status}
#   verify "Location header is correct" "https://polaris.int.cps.gov.uk/init?cookie=foobars" eq {HTTP::header Location}
#   endstate HTTP::respond 302
#   run polaris_irule.tcl polaris
# }