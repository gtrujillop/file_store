class CreateFileUploads < ActiveRecord::Migration[5.2]
  def change
    create_table :file_uploads, id: :uuid do |t|
      t.string :file_name, null: false
      t.integer :status
      t.timestamps
    end
    add_index :file_uploads, :file_name, unique: true
  end
end
