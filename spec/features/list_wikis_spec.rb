require 'spec_helper'

describe "Viewing the list of wikis" do

  before(:suite) do
    wiki1 = Wiki.create(wiki_attributes)
    wiki2 = Wiki.create(title: "Favorite Dog",
                        body: "Boxers are my favorite dogs.  They are so adorable, yet look so tough!")
    wiki3 = Wiki.create(title: "How to make water into wine",
                        body: "This wiki will show you how to turn water into wine and other neat tips and tricks.")
    visit wikis_url
  end


  it "shows the wikis" do
    expect(page).to have_text("3 Wikis")
  end

  it "shows an excerpt from the body" do
    expect(page).to have_text(wiki1.body[0..10])
  end

  it 'displays the created at date' do
    expect(page).to have_text(wiki1.created_at.to_s)
  end

  it 'displays titles of the wikis' do
    expect(page).to have_text(wiki1.title)
    expect(page).to have_text(wiki2.title)
    expect(page).to have_text(wiki3.title)
  end

end