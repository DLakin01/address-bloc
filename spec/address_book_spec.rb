require_relative "../models/address_book"

RSpec.describe AddressBook do

  describe "attributes" do

    it "responds to entries" do
      book = AddressBook.new
      expect(book).to respond_to(:entries)
    end

    it "initializes entries as an array" do
      book = AddressBook.new
      expect(book.entries).to be_an(Array)
    end

    it "initializes entries as empty" do
      book = AddressBook.new
      expect(book.entries.size).to eq(0)
    end

  end

  describe "#add_entry" do

    it "adds only one entry to the address book" do
      book = AddressBook.new
      book.add_entry('Daniel Lakin', '919-475-3122', 'DLakin01@gmail.com')

      expect(book.entries.size).to eq(1)
    end

    it "adds the correct information to entries" do
      book = AddressBook.new
      book.add_entry('Daniel Lakin', '919-475-3122', 'DLakin01@gmail.com')
      new_entry = book.entries[0]

      expect(new_entry.name).to eq('Daniel Lakin')
      expect(new_entry.phone_number).to eq('919-475-3122')
      expect(new_entry.email).to eq('DLakin01@gmail.com')
    end

  end

  describe "#remove_entry" do

    it "removes just one entry" do
      book = AddressBook.new
      book.entries = [
          ['Daniel Lakin', '919-475-3122', 'DLakin01@gmail.com'],
          ['Taylor Kuether', '111.222.3333', 'taylor.kuether@gmail.com'],
          ['Zach Zimbler', '444.555.6666', 'zzimbler@gmail.com'],
          ['Mark Carpenter', '123.456.7890', 'mark.carpenter@gmail.com']
        ]
      book.remove_entry('Zach Zimbler', '444.555.6666', 'zzimbler@gmail.com')
      expect(book.entries.size).to eq(3)
    end

    it "removes the correct information from entries" do
      book = AddressBook.new
      book.entries = [
          ['Daniel Lakin', '919-475-3122', 'DLakin01@gmail.com'],
          ['Taylor Kuether', '111.222.3333', 'taylor.kuether@gmail.com'],
          ['Zach Zimbler', '444.555.6666', 'zzimbler@gmail.com'],
          ['Mark Carpenter', '123.456.7890', 'mark.carpenter@gmail.com']
      ]
      book.remove_entry('Zach Zimbler', '444.555.6666', 'zzimbler@gmail.com')
      expect(book.entries).to eq([
        ['Daniel Lakin', '919-475-3122', 'DLakin01@gmail.com'],
        ['Taylor Kuether', '111.222.3333', 'taylor.kuether@gmail.com'],
        ['Mark Carpenter', '123.456.7890', 'mark.carpenter@gmail.com']
      ])
    end

  end

end
