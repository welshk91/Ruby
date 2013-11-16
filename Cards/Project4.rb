#
# CIS 343, Winter 2011
# Project 4
# Author: Kevin Welsh
#

#
# A class that represents a card used in card games
#    rank of card: 'A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K'
#    suit of card: 'c', 'd', 'h', 's'
#    string representation: rank followed by the suit - "8d", "Js"
#
class Card


	# generate getter methods for instance variables @rank and @suit
	attr_reader :rank, :suit
	
	# initialize the instance variables with paramter values
	def initialize(rank, suit)
		@rank=rank
		@suit=suit
	end
	
	# setter method for instance variable @rank
	def rank=(rank)
		case rank
		when 'A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'T', 'J', 'Q', 'K'
			@rank=rank
		else
			raise ArgumentError.new("Invalid rank value")
		end
	end
	
	# setter method for instanve variable @suit
	def suit=(suit)
		case suit
		when 'c', 'd', 'h', 's'
			@suit=suit
		else
			raise ArgumentError.new("Invalid suit value")
		end	
	end
	
	# returns string representation of Card object
	def to_s
		puts (@rank.to_s + @suit)
	end
	
end #Card

#
# A class that represents a deck of 52 playing cards with an array of Card class defned above
#
class Deck

	# initialize the array with 52 cards in the deck
	def initialize
		@pack=Array.new(52)
		@count=0
		
		for r in (0..12)
			for s in (0..3)

				#handles rank of the card in pack
				if r==0		
					@rnk='A'
				elsif r==12
					@rnk='K'
				elsif r==11
					@rnk='Q'
				elsif r==10
					@rnk='J'
				elsif r==9
					@rnk='T'
				else
					@rnk=r+1
				end #if
			
				#handles suit of the card in pack
				if s==0
					@st='c'
				elsif s==1
					@st='d'
				elsif s==2
					@st='h'
				else
					@st='s'
				end #if
				
				#creates the card
				@pack[@count]=Card.new(@rnk,@st)
				#puts pack[count]
				@count+=1
	
			end #for s
		end #for r
	end #initialize
	
	# method that shuffles the cards in the deck
	def shuffle
		@pack.shuffle!
	end
	
	# method to determine if the deck is empty
	def empty?
		if @pack.size==0
			true
		else
			false
		end
	end
	
	# method that returns n number of cards from the deck
	def deal(n=1)
			
		if !n.is_a? Integer
			nil
		elsif n==1
			puts @pack.pop		
		elsif n>=2
			for i in (1..n)			
				puts @pack.pop
			end		
		else
			nil
		end
	end
	
	# method that returns the number of cards in the deck
	def size
		@pack.length
	end
		
	def to_s
		for i in (0..@pack.size)
			puts @pack[i].to_s
		end
	end
	
end #Deck

#
# Open and add two methods to Ruby's Array class
#
class Array
	
	# method that returns the symmetric difference of self array and other array
	def ^(other)
		if !self.is_a? Array
			nil
		elsif !other.is_a? Array
			nil
		else
			(self|other)-(self&other)
		end
	end
	
	# method that returns the cartesian product of self array and other array
	def **(other)
		if !self.is_a? Array
			nil
		elsif !other.is_a? Array
			nil
		else
			ary=[self,other]
			ary.first.product(*ary.drop(1))
		end
	end
	
end #Array

#
# global function to test the functionality in the Card, Deck, and Array classes
#
def main
	# Test the methods of Card class
	c = Card.new('A','s')
	puts(c)
	
	begin
		Card.new('15','s')
	rescue ArgumentError => ex
		puts ex.message
	end
	
	begin
		Card.new('4','z')
	rescue ArgumentError => ex
		puts ex.message
	end
	
	begin
		c.rank= '15'
	rescue ArgumentError => ex
		puts ex.message
	end
	
	begin
		c.suit= 'z'
	rescue ArgumentError => ex
		puts ex.message
	end
	
	#Test the methods of Deck class
	d = Deck.new
	puts("\nNew deck of 52 cards: #{d}");
	
	d.shuffle
	puts("\nShuffled deck of 52 cards")
	puts("Deck size: #{d.size}")
	puts("Deck empty? #{d.empty?}")
	
	puts("\nDealing one card from the deck: #{d.deal()}")
	puts("Dealing one card from the deck: #{d.deal(1)}")
	puts("Dealing ten cards from the deck: #{d.deal(10)}")
	puts("Deck size after dealing: #{d.size}")
	
	d = Deck.new
	d.shuffle
	puts("\nNew shuffled deck of 52 cards")
	puts("Deck size: #{d.size}")
	puts("Dealing all cards from the deck: #{d.deal(52)}")
	puts("Deck empty? #{d.empty?}")
	puts("Deck size after dealing: #{d.size}")
	
	d = Deck.new
	d.shuffle
	puts("\nNew shuffled deck of 52 cards")
	puts("Deck size: #{d.size}")
	puts("Dealing all cards from the deck: #{d.deal(55)}")
	puts("Deck empty? #{d.empty?}")
	puts("Deck size after dealing: #{d.size}")
	
	# Test methods added to the Array class
	a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
	b = [1, 3, 5, 7, 9, 11, 13, 15]
	c = [2, 4, 6, 8, 10, 12, 14, 16]
	
	d = a^b
	puts("\na ^ b:  #{d.sort}")
	
	d = a^c
	puts("\na ^ c:  #{d.sort}")	
	
	d = b^c
	puts("\nb ^ c:  #{d.sort}")
	
	a = [1, 2, 3]
	b = [2, 3, 4, 5]
	c = a**b
	puts("\na ** b:  #{c}")
	
	# Test cases for invalid type value
	puts(Deck.new.deal(-10))
	puts(Deck.new.deal("Hello"))
	puts(Deck.new.deal(1.5))
	puts([1, 2, 3] ^ 5)
	puts([1, 2, 3] ** 5)
end

# invoke the main function
main()
