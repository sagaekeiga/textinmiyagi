class AddAttachmentPhotoToMicroposts < ActiveRecord::Migration
  def self.up
    change_table :microposts do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :microposts, :photo
  end
end
