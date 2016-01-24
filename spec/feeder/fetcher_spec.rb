require 'spec_helper'

describe Fetcher do

  it 'fetches and parses a feed' do
    fetcher = Feeder::Fetcher.new

    feed_source = double
    feed_returned = {
      :title => 'test title',
      :description => 'test description',
      :last_modified => 'last modified',
      :feed_url => 'feed url',
      :source_url => 'source url',
      :articles => ['articles']
    }

    expect(fetcher).to receive(:fetch_and_parse).with('http://www.fake.com/rss').and_return(feed_source)
    expect(feed_source).to receive(:respond_to?).and_return(true)
    expect(feed_source).to receive(:title).and_return('test title')
    expect(feed_source).to receive(:description).and_return('test description')
    expect(feed_source).to receive(:last_modified).and_return('last modified')
    expect(feed_source).to receive(:feed_url).and_return('feed url')
    expect(feed_source).to receive(:url).and_return('source url')
    expect(feed_source).to receive(:entries).and_return(['articles'])
    expect(fetcher.fetch_feed('http://www.fake.com/rss')).to have_attributes(feed_returned)
  end

end
