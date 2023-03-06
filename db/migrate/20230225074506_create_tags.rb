class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      # t.string :name #カラムはname
      t.string :name, null: false #模範回答
      t.timestamps
    end
  end
end
