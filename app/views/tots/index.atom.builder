atom_feed do |feed|
  feed.title("All tots for topic #{@topic.name}")
  feed.updated(@tots[0]['updated_at']) if @tots.length > 0

  @tots.each do |tot|
    url = request.url.gsub(/tots\.atom/, "tots/#{tot['_id']}.json")
    feed.entry(tot, {:id => url, :url => url}) do |entry|
      entry.title(tot['created_at'])
      entry.content(tot.to_s, :type => 'html')

      entry.author do |author|
        author.name("tigol")
      end
    end
  end
end