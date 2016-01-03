Sequel.migration do
  change do
    create_table(:feeds) do
      primary_key :id
      String :title, :null=>false
      String :subtitle
      String :icon
      String :description, :text=>true
      String :feed_url, :null=>false
      String :source_url, :null=>false
      DateTime :created, :null=>false
      DateTime :last_updated
      DateTime :last_fetched
    end

    create_table(:entries) do
      primary_key :id
      String :title, :null=>false
      String :url, :null=>false
      String :author
      String :content, :text=>true, :null=>false
      String :summary, :text=>true
      String :image
      DateTime :created, :null=>false
      DateTime :updated
      DateTime :published
      foreign_key :feed_id, :feeds
    end
  end
end
