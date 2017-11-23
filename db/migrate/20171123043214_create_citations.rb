class CreateCitations < ActiveRecord::Migration[5.1]
  def change
    create_table :citations do |t|
      t.integer :group_id
      t.integer :user_id
      t.text :document_type
      t.text :booktitle
      t.text :edition
      t.text :journal
      t.text :title
      t.text :authors
      t.text :year
      t.text :volume
      t.text :issue
      t.text :pages
      t.text :publisher
      t.text :institution
      t.text :month
      t.text :address
      t.text :doi
      t.text :pubmed
      t.text :url
      t.text :note
      t.text :editors

      t.text :notation_html
      
      t.timestamps
    end
  end
end
