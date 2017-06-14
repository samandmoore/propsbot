class User < ApplicationRecord
  has_many :praises
  has_many :praise_recipients

end
