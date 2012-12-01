atom_feed do |feed|
  feed.title("All tots for topic #{@topic.name}")
  feed.updated(@tots[0].created_at) if @tots.length > 0

  @tots.each do |tot|
    feed.entry(tot) do |entry|
      entry.title(tot.created_at)
      entry.content(tot.to_s, :type => 'html')

      entry.author do |author|
        author.name("tigol")
      end
    end
  end
end