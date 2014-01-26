require_relative '../config'
require_relative '../../app/models/legislator'
require_relative '../../app/models/state'
class CreateStates < ActiveRecord::Migration
  def up
    create_table :states do |t|
      t.string :state
    end

    all_states =Legislator.uniq.pluck(:state)
    all_states.each do |state|
      st = State.create!
      st.update_attribute("state", state)
      # st.save!
    end
  end

  def down
    
    drop_table(:states)
  end
end
