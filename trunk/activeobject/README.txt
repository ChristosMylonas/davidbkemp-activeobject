Sample code to demonstrate the Active Object pattern
http://en.wikipedia.org/wiki/Active_Object

This is intended to be used in my talk on Active Object at the Melbourne Patterns group
http://melbournepatterns.org/

The audience is not expected to be Ruby experts, but Ruby helps keep the code concise and easy to present.

The example is a contrived one of a domain name reseller selling .com, .com.au, and .co.nz domain names
with the restriction that the respective domain name registries (or registrars) only allowing one
connection at a time from the reseller.