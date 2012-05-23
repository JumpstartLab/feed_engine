require 'spec_helper'

describe Video do
  let(:user) {FactoryGirl.create(:user)}

  describe "#new" do
    context "Validations" do
      it "when I have no link" do
        video = Video.new(link: "", user_id: user.id)
        video.should_not be_valid
      end
      it "when I have a non-youtube link" do
        link = "http://foo.com/kfakfj"
        video = Video.new(link: link, user_id: user.id)
        video.should_not be_valid
      end
      it "when I have a youtube embed link" do
        link = "http://youtu.be/BgAlQuqzl8o"
        video = Video.new(link: link, user_id: user.id)
        video.should be_valid
      end
      it "when I have a youtube header link" do
        link = "http://www.youtube.com/watch?feature=endscreen&NR=1&v=DRVvFYppU0w"
        video = Video.new(link: link, user_id: user.id)
      end

      context "comments" do
        let(:link) { "http://youtu.be/DRVvFYppU0w" }

        it "works with a comment" do
          comment="Foomanchu"
          video = Video.new(link: link, user_id: user.id, comment: comment)
          video.should be_valid
        end

        it "fails if comment is too long" do
          comment = "a" * 400
          video = Video.new(link: link, user_id: user.id, comment: comment)
          video.should_not be_valid
        end
      end
    end
  end
end