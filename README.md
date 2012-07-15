phrak
=====

An IRC bot written in perl

phrak is an opbot(ie phrak can give ops,take ops, give half ops, take half ops from users)

phrak was written in perl using Bot:BasicBot (not Bot:BasicBot:Pluggable)

Instructions:
You need to change the irc.example.com in phrak.pl to whatever server you frequent.
just say phrak help for a list of options they are pretty self explanatory, you need to add your user name to phrak.yml though
the syntax for adding users isn't that hard example


---
OP:
  - placeUserNameHere
  - placeUserNameHere
  - placeUserNameHere

you have to make sure that the - lines up vertically with : and make sure there is a space between - and the username

---
OP:
-Bob (this is incorrect there isn't a space between the - and Bob and it doesn't line up with :

---
OP:
  - Bob (this is correct as it lines up with : and there is a space after the -

make sure your username is in the list other wise phrak will refuse to op anyone,also make sure that phrak is an op :P

other than that there isn't much more that you need to do really


OTHER:
!reloadcfg doesn't work properly
I'm not sure but I'm relatively certain that !addop doesn't work either

