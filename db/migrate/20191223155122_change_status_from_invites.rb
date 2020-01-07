class ChangeStatusFromInvites < ActiveRecord::Migration[6.0]
  def change
    change_table :invites do |t|
      t.change :status, :boolean, default: false
    end
  end
end
