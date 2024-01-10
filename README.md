# Carnival

## Instructions
* Fork this Repository
* Clone your forked repo
* Complete the activity Below
* Push your solution to your repo
* Submit a Pull Request from your repo to this repo
* In your PR, please include:
  * Your name
  * A reflection on how you felt you did with this challenge

## Iteration 1 - Visitors

Graded Items:

1. Create a Visitor with attributes and a way to read that data
2. Visitors have `preferences` and can list those preferences
3. Visitors can check if they are tall enough for rides based on a given height threshold (height given in inches)


Use TDD to create a `Visitor` class that responds to the following interaction pattern:


```ruby
pry(main)> require './lib/visitor'
#=> true

pry(main)> visitor1 = Visitor.new('Bruce', 54, '$10')
#=> #<Visitor:0x000000012f2b2818 @height=54, @name="Bruce", @preferences=[], @spending_money=10>

pry(main)> visitor1.name
#=> "Bruce"

pry(main)> visitor1.height
#=> 54

pry(main)> visitor1.spending_money
#=> 10

pry(main)> visitor1.preferences
#=> []

pry(main)> visitor1.add_preference(:gentle)

pry(main)> visitor1.add_preference(:thrilling)

pry(main)> visitor1.preferences
#=> [:gentle, :thrilling]

pry(main)> visitor2 = Visitor.new('Tucker', 36, '$5')
#=> #<Visitor:0x000000012f1f30f8 @height=36, @name="Tucker", @preferences=[], @spending_money=5>

pry(main)> visitor3 = Visitor.new('Penny', 64, '$15')
#=> #<Visitor:0x000000012f176760 @height=64, @name="Penny", @preferences=[], @spending_money=15>

pry(main)> visitor1.tall_enough?(54)
#=> true

pry(main)> visitor2.tall_enough?(54)
#=> false

pry(main)> visitor3.tall_enough?(54)
#=> true

pry(main)> visitor1.tall_enough?(64)
#=> false

```

## Iteration 2 - Rides

Graded Items:

1. Create a Ride with attributes and a way to read that data
2. Rides have a rider log that tracks who has ridden the ride and how many times
3. A rider's spending money is reduced by the admission fee when they board a ride
4. A rider does not board if they are not tall enough or do not have a matching preference for the ride's excitement level or do not have enough spending money left. 
5. A ride can calculate the total revenue it has earned

Use TDD to create a `Ride` class that responds to the following interaction pattern:

```ruby
pry(main)> require './lib/visitor'
#=> true

pry(main)> require './lib/ride'
#=> true

pry(main)> ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
#=> #<Ride:0x000000015a136ab8 @admission_fee=1, @excitement=:gentle, @min_height=24, @name="Carousel", @rider_log={}>

pry(main)> ride1.name
#=> "Carousel"

pry(main)> ride1.min_height
#=> 24

pry(main)> ride1.admission_fee
#=> 1

pry(main)> ride1.excitement
#=> :gentle

pry(main)> ride1.total_revenue
#=> 0

pry(main)> visitor1 = Visitor.new('Bruce', 54, '$10')
#=> #<Visitor:0x000000015a16e918 @height=54, @name="Bruce", @preferences=[], @spending_money=10>

pry(main)> visitor2 = Visitor.new('Tucker', 36, '$5')
#=> #<Visitor:0x000000015a11c5c8 @height=36, @name="Tucker", @preferences=[], @spending_money=5>

pry(main)> visitor1.add_preference(:gentle)

pry(main)> visitor2.add_preference(:gentle)

pry(main)> ride1.board_rider(visitor1)

pry(main)> ride1.board_rider(visitor2)

pry(main)> ride1.board_rider(visitor1)

pry(main)> ride1.rider_log
#=> {#<Visitor:0x000000015a16e918 @height=54, @name="Bruce", @preferences=[:gentle], @spending_money=8> => 2,
 #<Visitor:0x000000015a11c5c8 @height=36, @name="Tucker", @preferences=[:gentle], @spending_money=4> => 1}

pry(main)> visitor1.spending_money
#=> 8

pry(main)> visitor2.spending_money
#=> 4

pry(main)> ride1.total_revenue
#=> 3

pry(main)> visitor3 = Visitor.new('Penny', 64, '$15')
#=> #<Visitor:0x0000000159a852a0 @height=64, @name="Penny", @preferences=[], @spending_money=15>

pry(main)> ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
#=> #<Ride:0x0000000159a0cd00 @admission_fee=5, @excitement=:gentle, @min_height=36, @name="Ferris Wheel", @rider_log={}>

pry(main)> ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
#=> #<Ride:0x0000000159ae7a68 @admission_fee=2, @excitement=:thrilling, @min_height=54, @name="Roller Coaster", @rider_log={}>

pry(main)> visitor2.add_preference(:thrilling)
#=> [:gentle, :thrilling]

pry(main)> visitor3.add_preference(:thrilling)
#=> [:thrilling]

pry(main)> ride3.board_rider(visitor1)

pry(main)> ride3.board_rider(visitor2)

pry(main)> ride3.board_rider(visitor3)

pry(main)> visitor1.spending_money
#=> 8

pry(main)> visitor2.spending_money
#=> 4

pry(main)> visitor3.spending_money
#=> 13

pry(main)> ride3.rider_log
#=> {#<Visitor:0x0000000159a852a0 @height=64, @name="Penny", @preferences=[:thrilling], @spending_money=13> => 1}

pry(main)> ride3.total_revenue
#=> 2
```

## Iteration 3 - Carnival

Use TDD to create a `Carnival` class that adds the following functionality:
(You may choose to add additional methods not listed here to help you build this functionality.)

1. Each carnival has a duration, as well as a way to read that data
2. Each carnival can add rides and can list those rides.

Additionally, use TDD to add the following functionality to the `Carnival` class. A passing challenge will complete *at least* one of the following. We recommend completing more than one if you have time.

1. A carnival can tell us its most popular ride. Most popular will be the ride that has been ridden the most amount of times by all visitors (not based on unique riders).
1. A carnival can tell us its most profitable ride
1. A carnival can calculate the total revenue earned from all its rides.

| Method Name             | Return Value |
|-------------            |--------------|
| `duration`              | integer representing days (ex:`14` to represent 14 days/2 weeks) |
| `add_ride(ride)`        | up to you    |
| `rides`                 | `Array` containing `Ride` objects |
| `most_popular_ride`     | `Ride` object |
| `most_profitable_ride`  | `Ride` object |
| `total_revenue`         | integer |

## Iteration 4
1. A carnival can provide a summary hash that includes:
   * Visitor count
   * Revenue earned
   * List of visitors and each visitor's favorite ride and how much total money a visitor spent
   * List of rides and who rode each ride and the ride's total revenue
1. The Carnival class can calculate the total revenue of all carnivals.

| Method Name             | Return Value |
|-------------            |--------------|
| `summary`               | `Hash` (see below) |
| `Carnival.total_revenues` | integer |


summary hash structure:
```ruby
{
  visitor_count: integer, 
  revenue_earned: integer, 
  visitors: [
    {
      visitor: Visitor object,
      favorite_ride: Ride object,
      total_money_spent: integer
    }, 
    {
      visitor: Visitor object,
      favorite_ride: Ride object,
      total_money_spent: integer
    }],
  rides: [
    {
      ride: Ride object,
      riders: [Visitor objects],
      total_revenue: integer
    },
    {
      ride: Ride object,
      riders: [Visitor objects],
      total_revenue: integer
    }]
  }
  ```
