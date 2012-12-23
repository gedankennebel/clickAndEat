class FilterDefinition < ActiveRecord::Base
  attr_accessible :cookable, :cooked, :served, :tables
  serialize :tables
  has_one :user_account

  def as_json(options = {})
    {
        cookable: self.cookable,
        cooked: self.cooked,
        served: self.served,
        tables: self.tables
    }
  end
end
