#this application behaves like a real life ATM

=begin
features (methods)
pin, accounts, withdraw, deposit, check balance, language,
 transaction fee, greeting, loading, camera security, etc
https:/stackoverflow.com/questions/2068027/grabbing-snapshots-from-webcams-in-ruby
https://stackoverflow.com/questions/2068027/grabbing-snapshots-from-webcams-in-ruby/39938139#39938139

 MVP = minimal viable product
=end


class Atm
  require 'io/console'

  def initialize()
    @balance= 1000
  end

  def greeting
    #checks the pin for AAB customers, charges $2 for not AAB
    def aab_cus
      puts "It looks like your not a AAB customer \n a $2 charge will be incurred"
      puts "Would you like to proceed [y/n]"
      proceed = gets.chomp
      case proceed
      when "y"
        @balance = @balance - 2
        menu
      when "n"
        goodbye
      else
        aab_cus
      end
    end
    puts "Hello, welcome to Almost Anything Banking [AAB]"
    puts "             __"
    puts "   /\\   /\\  | _)"
    puts "  / -\\ / -\\ |__)"
    puts
    puts "please enter your Personal Identification Number [PIN]"
    text = STDIN.noecho(&:gets)

    if (text.count("12345abAB")+0.0)/(text.length+0.0)> 0.5
      menu
    else
      aab_cus
    end
  end
#print out balance
  def check_balance
    balance=@balance
    sleep(0.5)
    puts "Your balance is : $#{sprintf('%.2f', balance)}"
    sleep(1)
    puts
    puts "Return to Menu [1],  exit [2], recheck balance [press any key]"
    nav= gets.chomp.to_i
    case nav
    when 1
      menu
    when 2
      goodbye
    else
      puts
      print "rechecking balance"
      sleep (1)
      print "."
      sleep (1)
      print "."
      sleep (1)
      print "."
      check_balance
    end
  end
#displays the Menu, linking user to other methods
  def menu
    puts "What would you like to do"
    puts "\n 1- Check balance \n 2- Withdraw cash \n 3- Deposit cash\n 4- Exit"
    choice = gets.chomp.to_i
    case choice
      when 1
        check_balance
      when 2
        withdraw
      when 3
        deposit
      when 4
        goodbye
      else
        "not a valid entry"
        choice = gets.chomp
    end
  end
#checks widrawal amount against correct note combonations, max withdrawl amount, and not a string
#finds min number of notes needed to deposit
#prints notes
  def withdraw
    all_combos = [0, 20, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150,
       160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 260, 270, 280, 290,
        300, 310, 320, 330, 340, 350, 360, 370, 380, 390, 400, 410, 420, 430,
         440, 450, 460, 470, 480, 490, 500]

         def fifty(num)
           l1=""
           l2=""
           l3=""
           num.times{|i|l1=l1 + " ______ "}
           num.times{|i|l2=l2 + "|  $50 |"}
           num.times{|i|l3=l3 + "|______|"}
           puts l1
           puts l2
           puts l3
         end
         def twenty(num)
           l1=""
           l2=""
           l3=""
           num.times{|i|l1=l1 + " ______ "}
           num.times{|i|l2=l2 + "|  $20 |"}
           num.times{|i|l3=l3 + "|______|"}
           puts l1
           puts l2
           puts l3
         end

         #cal combonation @ this point the combo has been checked against list
         def combo_calc(amount)
           cash = amount
           num50 = 0
           num20 = 0
           if cash %50 ==0
             num50 = cash/50
             num20 = 0
           elsif cash <50
             num50 = 0
             num20 = cash/20
           elsif cash %50 != 0
             while cash % 50 != 0
               cash = cash-20
               num20 += 1
             end
             num50 = cash/50
           end
           return num50, num20
         end
    go=false
    while go == false
      puts "How much would you like to withdraw? \n(this atm  deposits $20, $50 & $100 notes,\n max withdraw $500)\n ____________ "
      sleep(0.3)
      print "$ "
      amount=gets.chomp.to_i
      if amount == 0
        sleep(0.3)
        puts "Sorry please enter an number amount"
      else
        if all_combos.include?(amount)
          puts "depositing"
          for i in 0...3
            sleep(0.5)
            print "."
          end
          puts
          fifty(combo_calc(amount)[0])
          twenty(combo_calc(amount)[1])
          go = true
        elsif amount >500
          puts "sorry, maximum withdrawal is $500"
        else
          puts "sorry, please enter a combonation of $20 and $50"
          puts
        end
      end
    end
    #maybe enter a money graphic :)

    @balance = @balance - amount
    check_balance
    #puts "your balance is : $#{sprintf('%.2f', balance)}"
    #needs to ask for receipt and another option.

  end
#assumes machine can take notes and gold coins only, adds amount to balance
  def deposit
      puts "How much would you like to deposit?"
      print "$ "
      deposit_amount = gets.chomp.to_i

    case deposit_amount
    when 0
      sleep(0.3)
      puts "Sorry please deposit whole number amount only"
      puts
      deposit
    else
      print "Processing "
      for i in 0...3
        sleep(0.5)
        print ". "
      end
      @balance = @balance + deposit_amount
       check_balance

   end

  end
#simple goodbye message, called when cus exits program
  def goodbye
    puts "Goodbye, thankyou for banking with AAB"
  end

end
#calls script.
atm = Atm.new()
atm.greeting()
