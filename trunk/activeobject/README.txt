Sample code to demonstrate the Active Object pattern
http://en.wikipedia.org/wiki/Active_Object

This is intended to be used in my talk on Active Object at the Melbourne Patterns group
http://melbournepatterns.org/

The audience is not expected to be Ruby experts, but Ruby helps keep the code concise and easy to present.

The example is a contrived one of a domain name reseller selling .com, .com.au, and .co.nz domain names
with the restriction that the respective domain name registries (or registrars) only allowing one
connection at a time from the reseller.

Note that I assume a really simple FIFO scheduler and so do not supply a queue iterator on the Activation Queue,
instead I just supply a dequeue method to take the first item off the queue, blocking if the queue is empty.

Directory structure:
 
 - examples: contains example usage of the classes defined in the other directories.
 
 - classic: contains classes needed for a classic implementation of Active Object where each "active object" consists
 of a proxy (ActiveDomainNameRegistry) that has a reference to a single servant (DomainNameRegistry),
 and a single scheduler (Scheduler), and the scheduler contains a single activation queue (ActivationQueue).
  
  - variation: contains a variation of the pattern that allows multiple servants per activation queue
  and is avoids being tied to a single type of servant by using method_missing.
  