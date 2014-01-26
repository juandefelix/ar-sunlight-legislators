require_relative '../config'
class CreateLegislators < ActiveRecord::Migration
  def change
    create_table :legislators do |t|
      t.string :state
      t.string :type
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.string :name_suffix
      t.string :phone
      t.string :fax
      t.string :website
      t.string :webform
      t.string :party
      t.string :gender
      t.string :birthdate
      t.string :twitter_id
      t.boolean :in_office
    end
  end
end
