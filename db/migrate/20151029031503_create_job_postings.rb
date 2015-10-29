class CreateJobPostings < ActiveRecord::Migration
  def change
    create_table :job_postings do |t|
      t.string :title, null: false
      t.string :company
      t.string :location, null: false
      t.text :description, null: false
      t.string :url, null: false
      t.datetime :date_posted, null: false
      t.string :source, null: false
      t.string :source_id, null: false

      t.timestamps null: false
    end

    add_index :job_postings, :title
    add_index :job_postings, :company
    add_index :job_postings, [:company, :title, :location], unique: true
    add_index :job_postings, :description
    add_index :job_postings, :url, unique: true
    add_index :job_postings, :date_posted
    add_index :job_postings, :source
    add_index :job_postings, :source_id, unique: true
  end
end
