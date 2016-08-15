class AddChatToUserToChatRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :chat_rooms, :chat_to_user, :string
  end
end
