module Streamable

  def self.included(base)
    base.class_eval do
      validates_presence_of :user_id, :user
      belongs_to :user
      attr_accessible :user, :user_id

      after_save :add_to_author_stream

      def to_param
        stream_items.where(:user_id => user.id).where(:refeed => false).first.id
      end

      def add_to_author_stream
        user.add_stream_item(self, refeed=false)
      end

      def author
        self.user
      end
    end
  end


end
