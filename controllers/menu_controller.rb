require_relative '../models/address_book'

class MenuController
  attr_accessor :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View All Entries"
    puts "2 - View Entry Number n"
    puts "3 - Create an Entry"
    puts "4 - Search for an Entry"
    puts "5 - Import Entries from a CSV"
    puts "6 - Exit"
    print "Enter your selection: "

    selection = gets.to_i

    case selection
      when 1
        system "clear"
        view_all_entries
        main_menu
      when 2
        system "clear"
        view_entry_n
        main_menu
      when 3
        system "clear"
        create_entry
        main_menu
      when 4
        system "clear"
        search_entries
        main_menu
      when 5
        system "clear"
        read_csv
        main_menu
      when 6
        print "\nGood-bye!\n\n"
        exit(0)
      else
        system "clear"
        print "\nSorry, that is not a valid input\n\n"
        main_menu
    end
  end

  def view_all_entries
    address_book.entries.each do |entry|
      system "clear"
      puts entry.to_s
      entry_submenu(entry)
    end

    system "clear"
    puts "End of entries"
  end

  def view_entry_n
    system "clear"
    puts "Please choose an entry number:"
    number = gets.chomp.to_i
    if number <= address_book.entries.size
      system "clear"
      puts address_book.entries[number-1].to_s
      entry_submenu(address_book.entries[number])
    else
      print "\nSorry, #{number} is not a valid selection\n\n"
      view_entry_n
    end
  end

  def create_entry
    system "clear"
    puts "New AddressBloc Entry"

    print "Name: "
    name = gets.chomp
    print "Phone number: "
    phone = gets.chomp
    print "Email: "
    email = gets.chomp

    address_book.add_entry(name, phone, email)

    system "clear"
    puts "New entry created"

  end

  def search_entries
  end

  def read_csv
  end

  def entry_submenu(entry)
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

    selection = gets.chomp

    case selection
    when "n"
    when "d"
    when "e"
    when "m"
      system "clear"
      main_menu
    else
      system "clear"
      print "\n#{selection} is not a valid input\n\n"
      entry_submenu(entry)
    end
  end
end
