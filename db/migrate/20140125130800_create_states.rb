require_relative '../config'
require_relative '../app/models/state'
class CreateStates < ActiveRecord::Migration
  def up
    create_table :states do |t|
      t.string :state
    end

    Legislator.all.each do |l|
      value = l.state
      st = State.create!
      st.update_attribute("state", value)
      st.save!
    end
  end

  def down

  end
end
