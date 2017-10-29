class AddKhanModels < ActiveRecord::Migration[5.1]
    def change
        create_table :nodes do |t|
            t.string :type
            t.string :title
            t.string :slug
            t.string :khan_id
            t.string :relative_url

            t.timestamps
            t.index ["title"], name: "index_title_on_nodes", using: :btree
        end
    end
end
