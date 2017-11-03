require_relative '../models/address_book'

class MenuController
  attr_accessor :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - NUKE ALL ENTRIES"
    puts "6 - Exit"
    print "Enter your selection: "

    selection = gets.to_i

    case selection
      when 1
        system "clear"
        view_all_entries
      when 2
        system "clear"
        create_entry
        main_menu
      when 3
        system "clear"
        search_entries
        main_menu
      when 4
        system "clear"
        read_csv
        main_menu
      when 5
        system "clear"
        nuke_entries
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
    print "---Available Entries---\n\n"
    address_book.entries.each do |entry|
      puts "---"
      puts entry.to_s
    end
    print "\n---End of entries---\n\n"
    entry_submenu
    puts ""
    puts "Return to main menu? Y/N"
    input = gets.chomp

    case input
       when "y"
        system "clear"
        main_menu
      when "n"
        view_all_entries
      else
        system "clear"
        print "Sorry, that is not a valid input!\n\n"
        view_all_entries
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
    print "Search by name: "
    name = gets.chomp
    match = address_book.binary_search(name)
    system "clear"
    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No match found for #{name}"
    end
  end

  def search_submenu(entry)
    puts "\nd - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"
    selection = gets.chomp

    case selection
      when "d"
        system "clear"
        delete_entry(entry)
        main_menu
      when "e"
        edit_entry(entry)
        system "clear"
        main_menu
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        puts entry.to_s
        search_submenu(entry)
    end
  end

  def read_csv
    print "Enter CSV file to import: "
    file_name = gets.chomp

    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end

    begin
      entry_count = address_book.import_from_csv(file_name).count
      system "clear"
      puts "#{entry_count} new entries added from #{file_name}"
    rescue
      puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
    end
  end

  def edit_entry(entry)
    if entry == ""
      system "clear"
      puts "Which entry would you like to edit? "
      entry = gets.chomp.to_i
      system "clear"
      print "Updated name: "
      name = gets.chomp
      print "Updated phone number: "
      phone_number = gets.chomp
      print "Updated email: "
      email = gets.chomp

      address_book.entries[entry-1].name = name if !name.empty?
      address_book.entries[entry-1].phone_number = phone_number if !phone_number.empty?
      address_book.entries[entry-1].email = email if !email.empty?
      system "clear"

      puts "Updated entry #{entry}"
      puts "----------------------"

    else
      print "Updated name: "
      name = gets.chomp
      print "Updated phone number: "
      phone_number = gets.chomp
      print "Updated email: "
      email = gets.chomp
      entry.name = name if !name.empty?
      entry.phone_number = phone_number if !phone_number.empty?
      entry.email = email if !email.empty?
      system "clear"
      puts "Updated entry:"
      puts entry
    end
    view_all_entries
  end

  def nuke_entries
    if address_book.entries.empty?
      puts "Uhh, boss? There aren't any entries to destroy right now."
      puts "---------------------------------------------------------"
      main_menu
    else
      puts "Are you sure you want to do this? You could destroy all entries as we know them. Y/N"
      answer = gets.chomp.downcase

      case answer
        when "y"
          system "clear"
          puts "Fire when ready. I hope you're happy with yourself."
          puts "---------------------------------------------------"
          puts "                               ________________
                          ____/ (  (    )   )  ___
                         /( (  (  )   _    ))  )   )|
                       ((     (   )(    )  )   (   )  )
                     ((/  ( _(   )   (   _) ) (  () )  )
                    ( (  ( (_)   ((    (   )  .((_ ) .  )_
                   ( (  )    (      (  )    )   ) . ) (   )
                  (  (   (  (   ) (  _  ( _) ).  ) . ) ) ( )
                  ( (  (   ) (  )   (  ))     ) _)(   )  )  )
                 ( (  ( / ) (    (_  ( ) ( )  )   ) )  )) ( )
                  (  (   (  (   (_ ( ) ( _    )  ) (  )  )   )
                 ( (  ( (  (  )     (_  )  ) )  _)   ) _( ( )
                  ((  (   )(    (     _    )   _) _(_ (  (_ )
                   (_((__(_(__(( ( ( |  ) ) ) )_))__))_)___)
                   ((__)        //||lll|l||///          /_))
                            (   |(/ (  )  ) )|   )
                          (    ( ( ( | | ) ) )|   )
                           (   /(| / ( )) ) ) )) )
                         (     ( ((((_(|)_)))))     )
                          (      |||(|(|)|/||     )
                        (        |(||(||)||||        )
                          (     //|/l|||)||| |     )
                        (/ / //  /|//||||///  | |  | _)"
          address_book.entries.clear
        when "n"
          system "clear"
          puts "Phew. I'm glad you saw reason."
          puts "------------------------------"
          main_menu
      end
    end
  end

  def entry_submenu
    puts "d - delete an entry"
    puts "e - edit an entry"
    puts "m - return to main menu"

    selection = gets.chomp

    case selection
    when "d"
      system "clear"
      delete_entry("")
      main_menu
    when "e"
      system "clear"
      edit_entry("")
      main_menu
    when "m"
      system "clear"
      main_menu
    else
      system "clear"
      print "\n#{selection} is not a valid input\n\n"
      entry_submenu(entry)
    end
  end

  def delete_entry(entry)
    if entry == ""
      system "clear"
      puts "Which entry would you like to delete? "
      entry = gets.chomp.to_i
      begin
        address_book.entries.delete_at(entry - 1)
        system "clear"
        print "\nThe entry has been deleted\n"
        puts "---------------------------"
      rescue
        puts "#{entry} is not a valid entry number"
        view_all_entries
      end
      view_all_entries
    else
      address_book.entries.delete(entry)
      puts ""
      puts "#{entry.name} has been deleted from AddressBloc"
      puts "--------------------------------------"
  end

end
end
