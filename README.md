# oystercard

User stories

```text
In order to use public transport
As a customer
I want money on my card

In order to keep using public transport
As a customer
I want to add money to my card

In order to protect my money from theft or loss
As a customer
I want a maximum limit (of £90) on my card

In order to pay for my journey
As a customer
I need my fare deducted from my card

In order to get through the barriers.
As a customer
I need to touch in and out.

2.7.0 :001 > require  './lib/oystercard.rb'
 => true 
2.7.0 :002 > oyster = Oystercard.new
2.7.0 :003 > oyster.in_journey
 => false 
2.7.0 :004 > oyster.touch_in
 => true 
2.7.0 :005 > oyster.in_journey
 => true 
2.7.0 :006 > oyster.touch_out
 => false 
2.7.0 :007 > oyster.in_journey
 => false

In order to pay for my journey
As a customer
I need to have the minimum amount (£1) for a single journey.

2.7.0 :003 > oyster.balance
 => 0
2.7.0 :004 > oyster.touch_in
        5: from /Users/.../.rvm/rubies/ruby-2.7.0/bin/irb:23:in `<main>'
        3: from /Users/.../.rvm/rubies/ruby-2.7.0/lib/ruby/gems/2.7.0/gems/irb-1.2.1/exe/irb:11:in `<top (required)>'
        2: from (irb):4
        1: from /Users/.../Documents/.../.../oystercard/lib/oystercard.rb:22:in `touch_in'
RuntimeError (Cannot enter if balance is below £1)
2.7.0 :005 > oyster.top_up(1)
 => 1 
2.7.0 :006 > oyster.balance
 => 1 
2.7.0 :007 > oyster.touch_in
 => true 
2.7.0 :008 > oyster.in_journey
 => true 
2.7.0 :009 > oyster.touch_out
 => false 
2.7.0 :010 > oyster.in_journey
 => false 

In order to pay for my journey
As a customer
When my journey is complete, I need the correct amount deducted from my card

 2.7.0 :003 > oyster.top_up(10)
 => 10 
2.7.0 :004 > oyster.touch_in
 => true 
2.7.0 :005 > oyster.touch_out
 => false 
2.7.0 :006 > oyster.balance
 => 9 
```
